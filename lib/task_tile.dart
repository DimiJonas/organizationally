import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:organizationally/task_form_screen.dart';
import 'completion_toggle.dart';
import 'task.dart';
import 'task_provider.dart';

// TODO: remove indentLevel since its not used right now
class TaskTile extends ConsumerStatefulWidget {
  final Task task;
  final int indentLevel;
  final List<Task> allTasks;
  final bool initiallyExpanded;

  const TaskTile({
    super.key,
    required this.task,
    required this.indentLevel,
    required this.allTasks,
    this.initiallyExpanded = false,
  });

  @override
  ConsumerState<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends ConsumerState<TaskTile> with SingleTickerProviderStateMixin {
  late bool isExpanded;

  @override
  void initState() {
    super.initState();
    isExpanded = widget.initiallyExpanded;
  }

  @override
  Widget build(BuildContext context) {
    final allTasks = ref.watch(taskProvider);
    final task = allTasks.firstWhere((t) => t.id == widget.task.id);

    final subtasks = allTasks.where((t) => t.parentTaskId == task.id).toList();
    final hasSubtasks = subtasks.isNotEmpty;
    final uncompletedCount = subtasks.where((s) => !s.isCompleted).length;
    final completedCount = subtasks.length - uncompletedCount;
    final progress = subtasks.isEmpty ? 1.0 : completedCount / subtasks.length;

    return Padding(
      padding: EdgeInsets.only(left: 16.0 * widget.indentLevel, right: 8.0, top: 6.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: _priorityColor(task.priority),
        elevation: task.dependentTaskIds.length + 2,
        child: Stack(
          children: [
            Positioned(
              top: 8,
              right: 8,
              child: Icon(
                _categoryIcon(task.category),
                color: _categoryColor(task.category),
                size: 20,
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
                                onPressed: () => setState(() => isExpanded = !isExpanded),
                              ),
                          ],
                        ),
                        onTap: () => _showCompletionDialog(task),
                      ),
                      if (hasSubtasks)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: progress,
                              minHeight: 6,
                              backgroundColor: Colors.grey[300],
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.greenAccent),
                            ),
                          ),
                        ),
                      if (hasSubtasks)
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0, bottom: 4.0),
                          child: Text('${(progress * 100).toStringAsFixed(0)}% subtasks completed',
                              style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                        ),
                      if (isExpanded)
                        ...subtasks.map((sub) => TaskTile(
                            task: sub,
                            indentLevel: widget.indentLevel + 0,
                            allTasks: allTasks
                        )),
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

  String _buildSubtitle(Task task) {
    final buffer = StringBuffer();
    if (task.dueDate != null) {
      buffer.write("Due: ${task.dueDate!.toLocal().toString().split(' ')[0]} ");
    }
    if (task.estimatedTimeMinutes != null) {
      buffer.write("• Est: ${task.estimatedTimeMinutes} min ");
    }
    // buffer.write("• Priority: ${task.priority.name} ");
    // buffer.write("• Category: ${task.category.name} ");
    return buffer.toString();
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

  IconData _categoryIcon(TaskCategory category) {
    switch (category) {
      case TaskCategory.freetime:
        return Icons.weekend; // relaxed / leisure
      case TaskCategory.oneShot:
        return Icons.flash_on; // quick action
      case TaskCategory.repeated:
        return Icons.repeat; // recurring task
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
