import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:organizationally/task.dart';
import 'package:organizationally/task_provider.dart';
import 'package:organizationally/task_tile.dart';

class TimelineScreen extends ConsumerWidget {
  const TimelineScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allTasks = ref.watch(taskProvider);

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(Duration(days: 1));
    final tomorrow = today.add(Duration(days: 1));

    return Scaffold(
      appBar: AppBar(title: const Text("Timeline")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildDayTile(context, "Yesterday", yesterday, allTasks),
          _buildDayTile(context, "Today", today, allTasks),
          _buildDayTile(context, "Tomorrow", tomorrow, allTasks),
        ],
      ),
    );
  }

  Widget _buildDayTile(BuildContext context, String label, DateTime date, List<Task> tasks) {
    final start = date;
    final end = date.add(Duration(days: 1));

    final completed = tasks.where((t) =>
    t.isCompleted &&
        t.completedAt != null &&
        t.completedAt!.isAfter(start) &&
        t.completedAt!.isBefore(end)
    ).toList();

    final dueOrAvailable = tasks.where((t) =>
    !t.isCompleted &&
        (t.dueDate != null && t.dueDate!.isAfter(start) && t.dueDate!.isBefore(end))
    ).toList();

    final showTasks = completed + dueOrAvailable;

    return ExpansionTile(
      title: Text(label),
      subtitle: Row(
        children: completed.map((task) => Padding(
          padding: const EdgeInsets.only(right: 4),
          child: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: _categoryColor(task.category),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        )).toList(),
      ),
      children: showTasks.map((task) => TaskTile(
        task: task,
        indentLevel: 0,
        allTasks: tasks,
        initiallyExpanded: false,
      )).toList(),
    );
  }

  Color _categoryColor(TaskCategory category) {
    switch (category) {
      case TaskCategory.freetime:
        return Colors.blueAccent;
      case TaskCategory.oneShot:
        return Colors.pinkAccent;
      case TaskCategory.repeated:
        return Colors.teal;
    }
  }
}
