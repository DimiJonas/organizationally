import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:organizationally/task_provider.dart';

class TaskDetailScreen extends ConsumerWidget {
  final String taskId;

  TaskDetailScreen({required this.taskId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final task = ref.watch(taskProvider).firstWhere((t) => t.id == taskId);
    final tasks = ref.watch(taskProvider);

    final subtasks = tasks.where((t) => t.parentTaskId == task.id).toList();
    final dependencies = tasks.where((t) => task.dependentTaskIds.contains(t.id)).toList();

    return Scaffold(
      appBar: AppBar(title: Text(task.title)),
      body: ListView(
        children: [
          ListTile(title: Text('Category: ${task.category}')),
          ListTile(title: Text('Priority: ${task.priority}')),
          if (task.dueDate != null) ListTile(title: Text('Due: ${task.dueDate}')),
          if (task.estimatedTimeMinutes != null)
            ListTile(title: Text('Estimated time: ${task.estimatedTimeMinutes} min')),
          Divider(),
          Text('Subtasks'),
          ...subtasks.map((sub) => ListTile(
            title: Text(sub.title),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => TaskDetailScreen(taskId: sub.id)),
            ),
          )),
          Divider(),
          Text('Dependencies'),
          ...dependencies.map((dep) => ListTile(
            title: Text(dep.title),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => TaskDetailScreen(taskId: dep.id)),
            ),
          )),
        ],
      ),
    );
  }
}
