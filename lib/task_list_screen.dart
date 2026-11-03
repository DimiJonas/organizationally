import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:organizationally/task_form_screen.dart';
import 'package:organizationally/task_tile.dart';
import 'task_provider.dart';


class TaskListScreen extends ConsumerStatefulWidget {
  const TaskListScreen({super.key});

  @override
  ConsumerState<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends ConsumerState<TaskListScreen> {
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(taskProvider.notifier).updatePriorities();
        ref.read(taskProvider.notifier).carryOverTasks();
      });
      _initialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final tasks = ref.watch(taskProvider);
    final topLevelTasks = tasks.where((t) => t.parentTaskId == null).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Task Organizer')),
      body: ListView(
        children: topLevelTasks.map((t) => TaskTile(task: t, indentLevel: 0, allTasks: tasks)).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const TaskFormScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

}