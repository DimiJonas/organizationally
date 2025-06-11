import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'task.dart';

enum DurationUnit { day, week, month }

class TaskNotifier extends StateNotifier<List<Task>> {
  TaskNotifier() : super([]);

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