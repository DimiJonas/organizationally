import 'package:uuid/uuid.dart';

enum TaskCategory { repeated, oneShot, freetime }
enum TaskPriority { low, medium, high }

class Task {
  final String id;
  final String title;
  final DateTime? dueDate;
  final TaskCategory category;
  final TaskPriority priority;
  final List<String> subTaskIds;  // tasks this task depends on
  final String? parentTaskId;  // if this is a subtask
  final int? estimatedTimeMinutes; // optional estimated time for task
  final List<DateTime> dynamicPriorityChangeTimes; // when priority changes
  final bool isCompleted;
  final DateTime? completedAt;
  final Duration? repeatInterval; // for repeated tasks

  Task({
    required this.id,
    required this.title,
    this.dueDate,
    this.category = TaskCategory.oneShot,
    this.priority = TaskPriority.medium,
    this.subTaskIds = const [],
    this.parentTaskId,
    this.estimatedTimeMinutes,
    this.dynamicPriorityChangeTimes = const [],
    this.isCompleted = false,
    this.completedAt,
    this.repeatInterval,
  });

  Task copyWith({
    String? title,
    DateTime? dueDate,
    TaskCategory? category,
    TaskPriority? priority,
    List<String>? subTaskIds,
    String? parentTaskId,
    int? estimatedTimeMinutes,
    List<DateTime>? dynamicPriorityChangeTimes,
    bool? isCompleted,
    DateTime? completedAt,
    Duration? repeatInterval,
  }) {
    return Task(
      id: id,
      title: title ?? this.title,
      dueDate: dueDate ?? this.dueDate,
      category: category ?? this.category,
      priority: priority ?? this.priority,
      subTaskIds: subTaskIds ?? this.subTaskIds,
      parentTaskId: parentTaskId ?? this.parentTaskId,
      estimatedTimeMinutes: estimatedTimeMinutes ?? this.estimatedTimeMinutes,
      dynamicPriorityChangeTimes:
      dynamicPriorityChangeTimes ?? this.dynamicPriorityChangeTimes,
      isCompleted: isCompleted ?? this.isCompleted,
      completedAt: completedAt ?? this.completedAt,
      repeatInterval: repeatInterval ?? this.repeatInterval,
    );
  }

  Task createRepetition(){
    // Handle repeated task logic

    return Task(
      id: const Uuid().v4(),
      title: title,
      category: category,
      dueDate: DateTime.now().add(repeatInterval!),
      repeatInterval: repeatInterval,
      priority: priority,
      estimatedTimeMinutes: estimatedTimeMinutes,
    );
    // TODO: handle update of parent and child tasks
    // TODO: handle dynamicPriorityChangeTimes
  }
}
