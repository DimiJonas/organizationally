import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'task_provider.dart';
import 'task.dart';

class TaskFormScreen extends ConsumerStatefulWidget {
  const TaskFormScreen({super.key});

  @override
  ConsumerState<TaskFormScreen> createState() => _TaskFormScreenState();
}

class _TaskFormScreenState extends ConsumerState<TaskFormScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  DateTime? _dueDate;
  TaskCategory _category = TaskCategory.oneShot;
  TaskPriority _priority = TaskPriority.medium;
  String? _parentTaskId;
  List<String> _subtaskIds = [];
  int? _estimatedMinutes;
  List<DateTime> _dynamicPriorityDates = [];
  int? _repeatIntervalValue;
  String _repeatIntervalUnit = 'days';

  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;

    final task = Task(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: _titleController.text,
      dueDate: _dueDate,
      category: _category,
      priority: _priority,
      parentTaskId: _parentTaskId,
      dependentTaskIds: _subtaskIds,
      estimatedTimeMinutes: _estimatedMinutes,
      dynamicPriorityChangeTimes: _dynamicPriorityDates,
      repeatInterval: _repeatIntervalValue != null
          ? Duration(
          days: _repeatIntervalUnit == 'days'
              ? _repeatIntervalValue!
              : _repeatIntervalUnit == 'weeks'
              ? _repeatIntervalValue! * 7
              : _repeatIntervalValue! * 30)
          : null,
    );

    ref.read(taskProvider.notifier).addTask(task);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final allTasks = ref.watch(taskProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Create Task')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) => value == null || value.isEmpty ? 'Enter a title' : null,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Text(_dueDate != null
                      ? 'Due: ${_dueDate!.toLocal().toString().split(' ')[0]}'
                      : 'No due date'),
                  const Spacer(),
                  TextButton(
                    child: const Text('Pick Due Date'),
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) {
                        setState(() => _dueDate = picked);
                      }
                    },
                  ),
                ],
              ),
              DropdownButtonFormField<TaskCategory>(
                value: _category,
                decoration: const InputDecoration(labelText: 'Category'),
                items: TaskCategory.values
                    .map((c) => DropdownMenuItem(value: c, child: Text(c.name)))
                    .toList(),
                onChanged: (value) => setState(() => _category = value!),
              ),
              DropdownButtonFormField<TaskPriority>(
                value: _priority,
                decoration: const InputDecoration(labelText: 'Initial Priority'),
                items: TaskPriority.values
                    .map((p) => DropdownMenuItem(value: p, child: Text('Priority $p')))
                    .toList(),
                onChanged: (value) => setState(() => _priority = value!),
              ),
              DropdownButtonFormField<String>(
                value: _parentTaskId,
                decoration: const InputDecoration(labelText: 'Parent Task'),
                items: [
                  const DropdownMenuItem(value: null, child: Text('None')),
                  ...allTasks.map((t) => DropdownMenuItem(value: t.id, child: Text(t.title)))
                ],
                onChanged: (value) => setState(() => _parentTaskId = value),
              ),
              const SizedBox(height: 8),
              const Text('Subtasks'),
              ...allTasks.map((t) {
                return CheckboxListTile(
                  title: Text(t.title),
                  value: _subtaskIds.contains(t.id),
                  onChanged: (checked) {
                    setState(() {
                      if (checked == true) {
                        _subtaskIds.add(t.id);
                      } else {
                        _subtaskIds.remove(t.id);
                      }
                    });
                  },
                );
              }),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Estimated minutes'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  final parsed = int.tryParse(value);
                  _estimatedMinutes = parsed;
                },
              ),
              const SizedBox(height: 12),
              const Text('Dynamic Priority Dates'),
              Wrap(
                spacing: 8,
                children: _dynamicPriorityDates
                    .map((d) => Chip(
                  label: Text(d.toLocal().toString().split(' ')[0]),
                  onDeleted: () {
                    setState(() => _dynamicPriorityDates.remove(d));
                  },
                ))
                    .toList(),
              ),
              TextButton(
                child: const Text('Add Priority Boost Date'),
                onPressed: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) {
                    setState(() => _dynamicPriorityDates.add(picked));
                  }
                },
              ),
              const Divider(),
              const Text('Repetition Interval'),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(labelText: 'Interval'),
                      keyboardType: TextInputType.number,
                      onChanged: (val) {
                        _repeatIntervalValue = int.tryParse(val);
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _repeatIntervalUnit,
                      items: ['days', 'weeks', 'months']
                          .map((u) => DropdownMenuItem(value: u, child: Text(u)))
                          .toList(),
                      onChanged: (val) => setState(() => _repeatIntervalUnit = val!),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Create Task'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
