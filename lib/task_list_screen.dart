import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:organizationally/task_detail_screen.dart';
import 'package:organizationally/task_form_screen.dart';
import 'package:uuid/uuid.dart';
import 'task_provider.dart';
import 'task.dart';
import 'completion_toggle.dart';


class TaskListScreen extends ConsumerStatefulWidget {
  const TaskListScreen({super.key});

  @override
  ConsumerState<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends ConsumerState<TaskListScreen> {
  final Set<String> _expandedTasks = {};
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
        children: topLevelTasks.map((t) => _buildTaskTile(t, 0, tasks)).toList(),
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
    buffer.write("• Priority: ${task.priority.name} ");
    buffer.write("• Category: ${task.category.name} ");
    return buffer.toString();
  }

  // TODO: remove indentLevel since its not used right now
  Widget _buildTaskTile(Task task, int indentLevel, List<Task> allTasks) {
    final hasSubtasks = allTasks.any((t) => t.parentTaskId == task.id);
    final isExpanded = _expandedTasks.contains(task.id);
    final subtasks = ref.watch(taskProvider).where((t) => t.parentTaskId == task.id).toList();
    final uncompletedCount = subtasks.where((s) => !s.isCompleted).length;
    final completedCount = subtasks.length - uncompletedCount;
    final progress = subtasks.isEmpty ? 1.0 : completedCount / subtasks.length;

    return Padding(
      padding: EdgeInsets.only(left: 16.0 * indentLevel, right: 8.0, top: 6.0),
      child: Card(
        // margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        shape: _categoryShape(task.category),
        color: _priorityColor(task.priority),
        elevation: task.dependentTaskIds.length + 2,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: Container(
                width: 6,
                decoration: BoxDecoration(
                  color: _categoryColor(task.category),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8), // shift content slightly to the right
              child: GestureDetector(
                onLongPress: () => _navigateToEditForm(context, task),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        title: Row(
                          children: [
                            Expanded(
                              child: Text(
                                task.title,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            if (uncompletedCount > 0)
                              Text(
                                '$uncompletedCount remaining',
                                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                              ),
                          ],
                        ),
                        subtitle: Text(_buildSubtitle(task)),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildStatusBox(task),
                            if (hasSubtasks)
                              IconButton(
                                icon: Icon(isExpanded ? Icons.expand_less : Icons.expand_more),
                                onPressed: () {
                                  setState(() {
                                    if (isExpanded) {
                                      _expandedTasks.remove(task.id);
                                    } else {
                                      _expandedTasks.add(task.id);
                                    }
                                  });
                                },
                              ),
                          ],
                        ),
                        onTap: () => _showCompletionDialog(task),
                      ),
                      if (isExpanded)
                        ...subtasks.map((sub) => _buildTaskTile(sub, indentLevel + 0, allTasks)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBox(Task task) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: task.isCompleted ? Colors.green[400] : Colors.red[400],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        task.isCompleted ? "Completed" : "Not Completed",
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
      ),
    );
  }

  void _showCompletionDialog(Task task) {
    showDialog(
      context: context,
      builder: (context) {
        bool isCompleted = task.isCompleted;
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              content: CompletionToggle(
                isCompleted: isCompleted,
                onChanged: (val) => setState(() => isCompleted = val),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    final notifier = ref.read(taskProvider.notifier);
                    final allTasks = ref.read(taskProvider);

                    notifier.setTaskCompletion(task.id, isCompleted);
                    Navigator.of(context).pop();
                  },
                  child: const Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _navigateToEditForm(BuildContext context, Task task) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TaskFormScreen(existingTask: task),
      ),
    );
  }

  RoundedRectangleBorder _categoryShape(TaskCategory category) {
    switch (category) {
      case TaskCategory.freetime:
        return RoundedRectangleBorder(borderRadius: BorderRadius.circular(4));
      case TaskCategory.oneShot:
        return RoundedRectangleBorder(borderRadius: BorderRadius.circular(16));
      case TaskCategory.repeated:
        return RoundedRectangleBorder(borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ));
    // case TaskCategory.health:
    //   return RoundedRectangleBorder(borderRadius: BorderRadius.circular(20));
    // default:
    //   return RoundedRectangleBorder(borderRadius: BorderRadius.circular(12));
    }
  }

  Color _categoryColor(TaskCategory category) {
    switch (category) {
      case TaskCategory.freetime:
        return Colors.blueAccent;
      case TaskCategory.oneShot:
        return Colors.pinkAccent;
      case TaskCategory.repeated:
        return Colors.teal;
    // case TaskCategory.health:
    //   return Colors.deepOrange;
    // default:
    //   return Colors.grey;
    }
  }

  Color _priorityColor(TaskPriority priority) {
    switch (priority) {
      case TaskPriority.low:
        return Colors.green.shade100;
      case TaskPriority.medium:
        return Colors.orange.shade100;
      case TaskPriority.high:
        return Colors.red.shade200;
    // default:
    //   return Colors.grey.shade200;
    }
  }
}