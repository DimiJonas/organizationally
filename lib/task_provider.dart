import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'database_provider.dart';
import 'task.dart';

enum DurationUnit { day, week, month }

class TaskNotifier extends StateNotifier<List<Task>> {
  TaskNotifier() : super([]);
  final tasksStreamProvider = StreamProvider.autoDispose((ref) {
    final db = ref.watch(databaseProvider);
    return db.watchAllTasks(); // reactive updates
  });

  void addTask(Task task) {
    // TODO: possibly put this in a hashmap for faster search usw. or some other data structure for when the list of tasks grows
    state = [...state, task];
  }

  void removeTask(String id) {
    state = state.where((t) => t.id != id).toList();
  }

  void updateTask(Task updatedTask) {
    state = [
      for (final task in state)
        if (task.id == updatedTask.id) updatedTask else task,
    ];
  }

  void notifyParentOfSubtask(String parentId, String subtaskId){
    for (final task in state) {
      if (task.id == parentId) {
        if (!task.subTaskIds.contains(subtaskId)) {
          task.subTaskIds.add(subtaskId);
        }
      }
    }
  }

  void markTaskCompleted(String id) {
    final task = state.firstWhere((t) => t.id == id);
    final completedTask = task.copyWith(
      isCompleted: true,
      completedAt: DateTime.now(),
    );

    updateTask(completedTask);

    if (task.category == TaskCategory.repeated && task.repeatInterval != null) {
      addTask(task.createRepetition());
    }
  }

  void carryOverTasks() {
    final now = DateTime.now();
    state = state.map((task) {
      if (!task.isCompleted &&
          task.dueDate != null &&
          task.dueDate!.isBefore(now)) {
        return task.copyWith(dueDate: now);
      }
      return task;
    }).toList();
  }

  void updatePriorities() {
    final now = DateTime.now();
    state = state.map((task) {
      if (!task.isCompleted && task.dueDate != null) {
        final daysLeft = task.dueDate!.difference(now).inDays;
        final updatedPriority = daysLeft <= 1
            ? TaskPriority.high
            : daysLeft <= 3
            ? TaskPriority.medium
            : TaskPriority.low;
        return task.copyWith(priority: updatedPriority);
      }
      return task;
    }).toList();
  }

  void setTaskCompletion(String taskId, bool isCompleted) {
    final taskIndex = state.indexWhere((t) => t.id == taskId);
    if (taskIndex == -1) return;

    final updatedTask = state[taskIndex].copyWith(isCompleted: isCompleted);
    state = [
      ...state.sublist(0, taskIndex),
      updatedTask,
      ...state.sublist(taskIndex + 1),
    ];

    if (isCompleted) {
      // Recursively mark all subtasks as completed
      _markSubtasksRecursively(taskId, true);
    } else {
      // Recursively unmark parent tasks if needed
      _unmarkParentsIfNecessary(taskId);
    }
  }

  void _markSubtasksRecursively(String parentId, bool isCompleted) {
    final subtasks = state.where((t) => t.parentTaskId == parentId);
    for (final subtask in subtasks) {
      final index = state.indexWhere((t) => t.id == subtask.id);
      if (index != -1) {
        state = [
          ...state.sublist(0, index),
          subtask.copyWith(isCompleted: isCompleted),
          ...state.sublist(index + 1),
        ];
        _markSubtasksRecursively(subtask.id, isCompleted); // recurse
      }
    }
  }

  void _unmarkParentsIfNecessary(String taskId) {
    final task = state.firstWhere((t) => t.id == taskId);
    if (task.parentTaskId == null) return;

    final parentId = task.parentTaskId!;
    final parent = state.firstWhere((t) => t.id == parentId);

    if (parent.isCompleted) {
      final parentIndex = state.indexWhere((t) => t.id == parentId);
      state = [
        ...state.sublist(0, parentIndex),
        parent.copyWith(isCompleted: false),
        ...state.sublist(parentIndex + 1),
      ];
      _unmarkParentsIfNecessary(parentId); // bubble up
    }
  }
}

Duration durationBetweenDates(DateTime start, DateTime end) {
  return end.difference(start);
}

Duration userInputToDurationEnum(int value, DurationUnit unit) {
  switch (unit) {
    case DurationUnit.day:
      return Duration(days: value);
    case DurationUnit.week:
      return Duration(days: 7 * value);
    case DurationUnit.month:
      return Duration(days: 30 * value);
  }
}

final taskProvider = StateNotifierProvider<TaskNotifier, List<Task>>((ref) {
  return TaskNotifier();
});