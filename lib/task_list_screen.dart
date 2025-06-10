import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'task_provider.dart';
import 'task.dart';

class TaskListScreen extends ConsumerWidget {
  final _uuid = Uuid();

  TaskListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskProvider);
    final today = DateTime.now();

    return Scaffold(
      appBar: AppBar(title: Text('Task Organizer')),
      body: ListView(
        children: tasks.map((task) {
          final dueSoon = task.dueDate != null &&
              task.dueDate!.isAfter(today) &&
              task.dueDate!.difference(today).inDays <= 3;

          return ListTile(
            title: Text(task.title),
            subtitle: task.dueDate != null
                ? Text(
                'Due: ${task.dueDate!.toLocal().toString().split(' ')[0]}${dueSoon ? " (Soon!)" : ""}')
                : null,
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () =>
                  ref.read(taskProvider.notifier).removeTask(task.id),
            ),
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskDialog(context, ref),
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context, WidgetRef ref) {
    final titleController = TextEditingController();
    DateTime? selectedDate;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('New Task'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextButton(
              child: Text('Pick Due Date (Optional)'),
              onPressed: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2100),
                );
                if (picked != null) {
                  selectedDate = picked;
                }
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            child: Text('Add'),
            onPressed: () {
              final task = Task(
                id: _uuid.v4(),
                title: titleController.text,
                dueDate: selectedDate,
              );
              ref.read(taskProvider.notifier).addTask(task);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
