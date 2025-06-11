import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:organizationally/task_detail_screen.dart';
import 'package:organizationally/task_form_screen.dart';
import 'package:uuid/uuid.dart';
import 'task_provider.dart';
import 'task.dart';

class TaskListScreen extends ConsumerStatefulWidget {
  const TaskListScreen({super.key});

  @override
  ConsumerState<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends ConsumerState<TaskListScreen> {
  final _uuid = Uuid();
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

    return Scaffold(
      appBar: AppBar(title: Text('Task Organizer')),
      body: ListView(
        children: tasks.map((task) {

          return GestureDetector(
            onLongPress: () => _showEditTaskDialog(context, ref, task),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => TaskDetailScreen(taskId: task.id),
              ),
            ),
            child: CheckboxListTile(
              title: Text(task.title),
              subtitle: Text(_buildSubtitle(task)),
              value: task.isCompleted,
              onChanged: (_) {
                ref.read(taskProvider.notifier).markTaskCompleted(task.id);
              },
              secondary: IconButton(
                icon: Icon(Icons.info_outline),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => TaskDetailScreen(taskId: task.id),
                    ),
                  );
                },
              ),
            ),
          );
        }).toList(),
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

  String _buildSubtitle(Task task) {
    final buffer = StringBuffer();
    if (task.dueDate != null) {
      buffer.write("Due: ${task.dueDate!.toLocal().toString().split(' ')[0]} ");
    }
    if (task.estimatedTimeMinutes != null) {
      buffer.write("• Est: ${task.estimatedTimeMinutes} min ");
    }
    buffer.write("• Priority: ${task.priority.name}");
    return buffer.toString();
  }

  void _showEditTaskDialog(BuildContext context, WidgetRef ref, Task task) {
    final titleController = TextEditingController(text: task.title);
    DateTime? selectedDate = task.dueDate;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Task'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextButton(
              child: Text('Change Due Date'),
              onPressed: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: selectedDate ?? DateTime.now(),
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
            child: Text('Update'),
            onPressed: () {
              final updatedTask = task.copyWith(
                title: titleController.text,
                dueDate: selectedDate,
              );
              ref.read(taskProvider.notifier).updateTask(updatedTask);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

}
