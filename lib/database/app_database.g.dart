// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $TasksTable extends Tasks with TableInfo<$TasksTable, Task> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TasksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dueDateMeta = const VerificationMeta(
    'dueDate',
  );
  @override
  late final GeneratedColumn<DateTime> dueDate = GeneratedColumn<DateTime>(
    'due_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<TaskCategory, int> category =
      GeneratedColumn<int>(
        'category',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<TaskCategory>($TasksTable.$convertercategory);
  @override
  late final GeneratedColumnWithTypeConverter<TaskPriority, int> priority =
      GeneratedColumn<int>(
        'priority',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<TaskPriority>($TasksTable.$converterpriority);
  static const VerificationMeta _parentTaskIdMeta = const VerificationMeta(
    'parentTaskId',
  );
  @override
  late final GeneratedColumn<String> parentTaskId = GeneratedColumn<String>(
    'parent_task_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _estimatedTimeMinutesMeta =
      const VerificationMeta('estimatedTimeMinutes');
  @override
  late final GeneratedColumn<int> estimatedTimeMinutes = GeneratedColumn<int>(
    'estimated_time_minutes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isCompletedMeta = const VerificationMeta(
    'isCompleted',
  );
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
    'is_completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_completed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _repeatIntervalDaysMeta =
      const VerificationMeta('repeatIntervalDays');
  @override
  late final GeneratedColumn<int> repeatIntervalDays = GeneratedColumn<int>(
    'repeat_interval_days',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    dueDate,
    category,
    priority,
    parentTaskId,
    estimatedTimeMinutes,
    isCompleted,
    completedAt,
    repeatIntervalDays,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tasks';
  @override
  VerificationContext validateIntegrity(
    Insertable<Task> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('due_date')) {
      context.handle(
        _dueDateMeta,
        dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta),
      );
    }
    if (data.containsKey('parent_task_id')) {
      context.handle(
        _parentTaskIdMeta,
        parentTaskId.isAcceptableOrUnknown(
          data['parent_task_id']!,
          _parentTaskIdMeta,
        ),
      );
    }
    if (data.containsKey('estimated_time_minutes')) {
      context.handle(
        _estimatedTimeMinutesMeta,
        estimatedTimeMinutes.isAcceptableOrUnknown(
          data['estimated_time_minutes']!,
          _estimatedTimeMinutesMeta,
        ),
      );
    }
    if (data.containsKey('is_completed')) {
      context.handle(
        _isCompletedMeta,
        isCompleted.isAcceptableOrUnknown(
          data['is_completed']!,
          _isCompletedMeta,
        ),
      );
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    if (data.containsKey('repeat_interval_days')) {
      context.handle(
        _repeatIntervalDaysMeta,
        repeatIntervalDays.isAcceptableOrUnknown(
          data['repeat_interval_days']!,
          _repeatIntervalDaysMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Task map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Task(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      dueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}due_date'],
      ),
      category: $TasksTable.$convertercategory.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}category'],
        )!,
      ),
      priority: $TasksTable.$converterpriority.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}priority'],
        )!,
      ),
      parentTaskId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}parent_task_id'],
      ),
      estimatedTimeMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}estimated_time_minutes'],
      ),
      isCompleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_completed'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
      repeatIntervalDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}repeat_interval_days'],
      ),
    );
  }

  @override
  $TasksTable createAlias(String alias) {
    return $TasksTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<TaskCategory, int, int> $convertercategory =
      const EnumIndexConverter<TaskCategory>(TaskCategory.values);
  static JsonTypeConverter2<TaskPriority, int, int> $converterpriority =
      const EnumIndexConverter<TaskPriority>(TaskPriority.values);
}

class Task extends DataClass implements Insertable<Task> {
  final String id;
  final String title;
  final DateTime? dueDate;
  final TaskCategory category;
  final TaskPriority priority;
  final String? parentTaskId;
  final int? estimatedTimeMinutes;
  final bool isCompleted;
  final DateTime? completedAt;
  final int? repeatIntervalDays;
  const Task({
    required this.id,
    required this.title,
    this.dueDate,
    required this.category,
    required this.priority,
    this.parentTaskId,
    this.estimatedTimeMinutes,
    required this.isCompleted,
    this.completedAt,
    this.repeatIntervalDays,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || dueDate != null) {
      map['due_date'] = Variable<DateTime>(dueDate);
    }
    {
      map['category'] = Variable<int>(
        $TasksTable.$convertercategory.toSql(category),
      );
    }
    {
      map['priority'] = Variable<int>(
        $TasksTable.$converterpriority.toSql(priority),
      );
    }
    if (!nullToAbsent || parentTaskId != null) {
      map['parent_task_id'] = Variable<String>(parentTaskId);
    }
    if (!nullToAbsent || estimatedTimeMinutes != null) {
      map['estimated_time_minutes'] = Variable<int>(estimatedTimeMinutes);
    }
    map['is_completed'] = Variable<bool>(isCompleted);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    if (!nullToAbsent || repeatIntervalDays != null) {
      map['repeat_interval_days'] = Variable<int>(repeatIntervalDays);
    }
    return map;
  }

  TasksCompanion toCompanion(bool nullToAbsent) {
    return TasksCompanion(
      id: Value(id),
      title: Value(title),
      dueDate: dueDate == null && nullToAbsent
          ? const Value.absent()
          : Value(dueDate),
      category: Value(category),
      priority: Value(priority),
      parentTaskId: parentTaskId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentTaskId),
      estimatedTimeMinutes: estimatedTimeMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(estimatedTimeMinutes),
      isCompleted: Value(isCompleted),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      repeatIntervalDays: repeatIntervalDays == null && nullToAbsent
          ? const Value.absent()
          : Value(repeatIntervalDays),
    );
  }

  factory Task.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Task(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      dueDate: serializer.fromJson<DateTime?>(json['dueDate']),
      category: $TasksTable.$convertercategory.fromJson(
        serializer.fromJson<int>(json['category']),
      ),
      priority: $TasksTable.$converterpriority.fromJson(
        serializer.fromJson<int>(json['priority']),
      ),
      parentTaskId: serializer.fromJson<String?>(json['parentTaskId']),
      estimatedTimeMinutes: serializer.fromJson<int?>(
        json['estimatedTimeMinutes'],
      ),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      repeatIntervalDays: serializer.fromJson<int?>(json['repeatIntervalDays']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'dueDate': serializer.toJson<DateTime?>(dueDate),
      'category': serializer.toJson<int>(
        $TasksTable.$convertercategory.toJson(category),
      ),
      'priority': serializer.toJson<int>(
        $TasksTable.$converterpriority.toJson(priority),
      ),
      'parentTaskId': serializer.toJson<String?>(parentTaskId),
      'estimatedTimeMinutes': serializer.toJson<int?>(estimatedTimeMinutes),
      'isCompleted': serializer.toJson<bool>(isCompleted),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'repeatIntervalDays': serializer.toJson<int?>(repeatIntervalDays),
    };
  }

  Task copyWith({
    String? id,
    String? title,
    Value<DateTime?> dueDate = const Value.absent(),
    TaskCategory? category,
    TaskPriority? priority,
    Value<String?> parentTaskId = const Value.absent(),
    Value<int?> estimatedTimeMinutes = const Value.absent(),
    bool? isCompleted,
    Value<DateTime?> completedAt = const Value.absent(),
    Value<int?> repeatIntervalDays = const Value.absent(),
  }) => Task(
    id: id ?? this.id,
    title: title ?? this.title,
    dueDate: dueDate.present ? dueDate.value : this.dueDate,
    category: category ?? this.category,
    priority: priority ?? this.priority,
    parentTaskId: parentTaskId.present ? parentTaskId.value : this.parentTaskId,
    estimatedTimeMinutes: estimatedTimeMinutes.present
        ? estimatedTimeMinutes.value
        : this.estimatedTimeMinutes,
    isCompleted: isCompleted ?? this.isCompleted,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
    repeatIntervalDays: repeatIntervalDays.present
        ? repeatIntervalDays.value
        : this.repeatIntervalDays,
  );
  Task copyWithCompanion(TasksCompanion data) {
    return Task(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      dueDate: data.dueDate.present ? data.dueDate.value : this.dueDate,
      category: data.category.present ? data.category.value : this.category,
      priority: data.priority.present ? data.priority.value : this.priority,
      parentTaskId: data.parentTaskId.present
          ? data.parentTaskId.value
          : this.parentTaskId,
      estimatedTimeMinutes: data.estimatedTimeMinutes.present
          ? data.estimatedTimeMinutes.value
          : this.estimatedTimeMinutes,
      isCompleted: data.isCompleted.present
          ? data.isCompleted.value
          : this.isCompleted,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
      repeatIntervalDays: data.repeatIntervalDays.present
          ? data.repeatIntervalDays.value
          : this.repeatIntervalDays,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Task(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('dueDate: $dueDate, ')
          ..write('category: $category, ')
          ..write('priority: $priority, ')
          ..write('parentTaskId: $parentTaskId, ')
          ..write('estimatedTimeMinutes: $estimatedTimeMinutes, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('completedAt: $completedAt, ')
          ..write('repeatIntervalDays: $repeatIntervalDays')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    dueDate,
    category,
    priority,
    parentTaskId,
    estimatedTimeMinutes,
    isCompleted,
    completedAt,
    repeatIntervalDays,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Task &&
          other.id == this.id &&
          other.title == this.title &&
          other.dueDate == this.dueDate &&
          other.category == this.category &&
          other.priority == this.priority &&
          other.parentTaskId == this.parentTaskId &&
          other.estimatedTimeMinutes == this.estimatedTimeMinutes &&
          other.isCompleted == this.isCompleted &&
          other.completedAt == this.completedAt &&
          other.repeatIntervalDays == this.repeatIntervalDays);
}

class TasksCompanion extends UpdateCompanion<Task> {
  final Value<String> id;
  final Value<String> title;
  final Value<DateTime?> dueDate;
  final Value<TaskCategory> category;
  final Value<TaskPriority> priority;
  final Value<String?> parentTaskId;
  final Value<int?> estimatedTimeMinutes;
  final Value<bool> isCompleted;
  final Value<DateTime?> completedAt;
  final Value<int?> repeatIntervalDays;
  final Value<int> rowid;
  const TasksCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.category = const Value.absent(),
    this.priority = const Value.absent(),
    this.parentTaskId = const Value.absent(),
    this.estimatedTimeMinutes = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.repeatIntervalDays = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TasksCompanion.insert({
    required String id,
    required String title,
    this.dueDate = const Value.absent(),
    required TaskCategory category,
    required TaskPriority priority,
    this.parentTaskId = const Value.absent(),
    this.estimatedTimeMinutes = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.repeatIntervalDays = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       category = Value(category),
       priority = Value(priority);
  static Insertable<Task> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<DateTime>? dueDate,
    Expression<int>? category,
    Expression<int>? priority,
    Expression<String>? parentTaskId,
    Expression<int>? estimatedTimeMinutes,
    Expression<bool>? isCompleted,
    Expression<DateTime>? completedAt,
    Expression<int>? repeatIntervalDays,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (dueDate != null) 'due_date': dueDate,
      if (category != null) 'category': category,
      if (priority != null) 'priority': priority,
      if (parentTaskId != null) 'parent_task_id': parentTaskId,
      if (estimatedTimeMinutes != null)
        'estimated_time_minutes': estimatedTimeMinutes,
      if (isCompleted != null) 'is_completed': isCompleted,
      if (completedAt != null) 'completed_at': completedAt,
      if (repeatIntervalDays != null)
        'repeat_interval_days': repeatIntervalDays,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TasksCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<DateTime?>? dueDate,
    Value<TaskCategory>? category,
    Value<TaskPriority>? priority,
    Value<String?>? parentTaskId,
    Value<int?>? estimatedTimeMinutes,
    Value<bool>? isCompleted,
    Value<DateTime?>? completedAt,
    Value<int?>? repeatIntervalDays,
    Value<int>? rowid,
  }) {
    return TasksCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      dueDate: dueDate ?? this.dueDate,
      category: category ?? this.category,
      priority: priority ?? this.priority,
      parentTaskId: parentTaskId ?? this.parentTaskId,
      estimatedTimeMinutes: estimatedTimeMinutes ?? this.estimatedTimeMinutes,
      isCompleted: isCompleted ?? this.isCompleted,
      completedAt: completedAt ?? this.completedAt,
      repeatIntervalDays: repeatIntervalDays ?? this.repeatIntervalDays,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<DateTime>(dueDate.value);
    }
    if (category.present) {
      map['category'] = Variable<int>(
        $TasksTable.$convertercategory.toSql(category.value),
      );
    }
    if (priority.present) {
      map['priority'] = Variable<int>(
        $TasksTable.$converterpriority.toSql(priority.value),
      );
    }
    if (parentTaskId.present) {
      map['parent_task_id'] = Variable<String>(parentTaskId.value);
    }
    if (estimatedTimeMinutes.present) {
      map['estimated_time_minutes'] = Variable<int>(estimatedTimeMinutes.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (repeatIntervalDays.present) {
      map['repeat_interval_days'] = Variable<int>(repeatIntervalDays.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TasksCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('dueDate: $dueDate, ')
          ..write('category: $category, ')
          ..write('priority: $priority, ')
          ..write('parentTaskId: $parentTaskId, ')
          ..write('estimatedTimeMinutes: $estimatedTimeMinutes, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('completedAt: $completedAt, ')
          ..write('repeatIntervalDays: $repeatIntervalDays, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SubTaskLinksTable extends SubTaskLinks
    with TableInfo<$SubTaskLinksTable, SubTaskLink> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SubTaskLinksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _taskIdMeta = const VerificationMeta('taskId');
  @override
  late final GeneratedColumn<String> taskId = GeneratedColumn<String>(
    'task_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _subTaskIdMeta = const VerificationMeta(
    'subTaskId',
  );
  @override
  late final GeneratedColumn<String> subTaskId = GeneratedColumn<String>(
    'sub_task_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [taskId, subTaskId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sub_task_links';
  @override
  VerificationContext validateIntegrity(
    Insertable<SubTaskLink> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('task_id')) {
      context.handle(
        _taskIdMeta,
        taskId.isAcceptableOrUnknown(data['task_id']!, _taskIdMeta),
      );
    } else if (isInserting) {
      context.missing(_taskIdMeta);
    }
    if (data.containsKey('sub_task_id')) {
      context.handle(
        _subTaskIdMeta,
        subTaskId.isAcceptableOrUnknown(data['sub_task_id']!, _subTaskIdMeta),
      );
    } else if (isInserting) {
      context.missing(_subTaskIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  SubTaskLink map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SubTaskLink(
      taskId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}task_id'],
      )!,
      subTaskId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sub_task_id'],
      )!,
    );
  }

  @override
  $SubTaskLinksTable createAlias(String alias) {
    return $SubTaskLinksTable(attachedDatabase, alias);
  }
}

class SubTaskLink extends DataClass implements Insertable<SubTaskLink> {
  final String taskId;
  final String subTaskId;
  const SubTaskLink({required this.taskId, required this.subTaskId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['task_id'] = Variable<String>(taskId);
    map['sub_task_id'] = Variable<String>(subTaskId);
    return map;
  }

  SubTaskLinksCompanion toCompanion(bool nullToAbsent) {
    return SubTaskLinksCompanion(
      taskId: Value(taskId),
      subTaskId: Value(subTaskId),
    );
  }

  factory SubTaskLink.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SubTaskLink(
      taskId: serializer.fromJson<String>(json['taskId']),
      subTaskId: serializer.fromJson<String>(json['subTaskId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'taskId': serializer.toJson<String>(taskId),
      'subTaskId': serializer.toJson<String>(subTaskId),
    };
  }

  SubTaskLink copyWith({String? taskId, String? subTaskId}) => SubTaskLink(
    taskId: taskId ?? this.taskId,
    subTaskId: subTaskId ?? this.subTaskId,
  );
  SubTaskLink copyWithCompanion(SubTaskLinksCompanion data) {
    return SubTaskLink(
      taskId: data.taskId.present ? data.taskId.value : this.taskId,
      subTaskId: data.subTaskId.present ? data.subTaskId.value : this.subTaskId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SubTaskLink(')
          ..write('taskId: $taskId, ')
          ..write('subTaskId: $subTaskId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(taskId, subTaskId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SubTaskLink &&
          other.taskId == this.taskId &&
          other.subTaskId == this.subTaskId);
}

class SubTaskLinksCompanion extends UpdateCompanion<SubTaskLink> {
  final Value<String> taskId;
  final Value<String> subTaskId;
  final Value<int> rowid;
  const SubTaskLinksCompanion({
    this.taskId = const Value.absent(),
    this.subTaskId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SubTaskLinksCompanion.insert({
    required String taskId,
    required String subTaskId,
    this.rowid = const Value.absent(),
  }) : taskId = Value(taskId),
       subTaskId = Value(subTaskId);
  static Insertable<SubTaskLink> custom({
    Expression<String>? taskId,
    Expression<String>? subTaskId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (taskId != null) 'task_id': taskId,
      if (subTaskId != null) 'sub_task_id': subTaskId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SubTaskLinksCompanion copyWith({
    Value<String>? taskId,
    Value<String>? subTaskId,
    Value<int>? rowid,
  }) {
    return SubTaskLinksCompanion(
      taskId: taskId ?? this.taskId,
      subTaskId: subTaskId ?? this.subTaskId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (taskId.present) {
      map['task_id'] = Variable<String>(taskId.value);
    }
    if (subTaskId.present) {
      map['sub_task_id'] = Variable<String>(subTaskId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SubTaskLinksCompanion(')
          ..write('taskId: $taskId, ')
          ..write('subTaskId: $subTaskId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DynamicPriorityChangesTable extends DynamicPriorityChanges
    with TableInfo<$DynamicPriorityChangesTable, DynamicPriorityChange> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DynamicPriorityChangesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _taskIdMeta = const VerificationMeta('taskId');
  @override
  late final GeneratedColumn<String> taskId = GeneratedColumn<String>(
    'task_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _changeTimeMeta = const VerificationMeta(
    'changeTime',
  );
  @override
  late final GeneratedColumn<DateTime> changeTime = GeneratedColumn<DateTime>(
    'change_time',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [taskId, changeTime];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'dynamic_priority_changes';
  @override
  VerificationContext validateIntegrity(
    Insertable<DynamicPriorityChange> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('task_id')) {
      context.handle(
        _taskIdMeta,
        taskId.isAcceptableOrUnknown(data['task_id']!, _taskIdMeta),
      );
    } else if (isInserting) {
      context.missing(_taskIdMeta);
    }
    if (data.containsKey('change_time')) {
      context.handle(
        _changeTimeMeta,
        changeTime.isAcceptableOrUnknown(data['change_time']!, _changeTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_changeTimeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  DynamicPriorityChange map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DynamicPriorityChange(
      taskId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}task_id'],
      )!,
      changeTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}change_time'],
      )!,
    );
  }

  @override
  $DynamicPriorityChangesTable createAlias(String alias) {
    return $DynamicPriorityChangesTable(attachedDatabase, alias);
  }
}

class DynamicPriorityChange extends DataClass
    implements Insertable<DynamicPriorityChange> {
  final String taskId;
  final DateTime changeTime;
  const DynamicPriorityChange({required this.taskId, required this.changeTime});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['task_id'] = Variable<String>(taskId);
    map['change_time'] = Variable<DateTime>(changeTime);
    return map;
  }

  DynamicPriorityChangesCompanion toCompanion(bool nullToAbsent) {
    return DynamicPriorityChangesCompanion(
      taskId: Value(taskId),
      changeTime: Value(changeTime),
    );
  }

  factory DynamicPriorityChange.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DynamicPriorityChange(
      taskId: serializer.fromJson<String>(json['taskId']),
      changeTime: serializer.fromJson<DateTime>(json['changeTime']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'taskId': serializer.toJson<String>(taskId),
      'changeTime': serializer.toJson<DateTime>(changeTime),
    };
  }

  DynamicPriorityChange copyWith({String? taskId, DateTime? changeTime}) =>
      DynamicPriorityChange(
        taskId: taskId ?? this.taskId,
        changeTime: changeTime ?? this.changeTime,
      );
  DynamicPriorityChange copyWithCompanion(
    DynamicPriorityChangesCompanion data,
  ) {
    return DynamicPriorityChange(
      taskId: data.taskId.present ? data.taskId.value : this.taskId,
      changeTime: data.changeTime.present
          ? data.changeTime.value
          : this.changeTime,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DynamicPriorityChange(')
          ..write('taskId: $taskId, ')
          ..write('changeTime: $changeTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(taskId, changeTime);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DynamicPriorityChange &&
          other.taskId == this.taskId &&
          other.changeTime == this.changeTime);
}

class DynamicPriorityChangesCompanion
    extends UpdateCompanion<DynamicPriorityChange> {
  final Value<String> taskId;
  final Value<DateTime> changeTime;
  final Value<int> rowid;
  const DynamicPriorityChangesCompanion({
    this.taskId = const Value.absent(),
    this.changeTime = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DynamicPriorityChangesCompanion.insert({
    required String taskId,
    required DateTime changeTime,
    this.rowid = const Value.absent(),
  }) : taskId = Value(taskId),
       changeTime = Value(changeTime);
  static Insertable<DynamicPriorityChange> custom({
    Expression<String>? taskId,
    Expression<DateTime>? changeTime,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (taskId != null) 'task_id': taskId,
      if (changeTime != null) 'change_time': changeTime,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DynamicPriorityChangesCompanion copyWith({
    Value<String>? taskId,
    Value<DateTime>? changeTime,
    Value<int>? rowid,
  }) {
    return DynamicPriorityChangesCompanion(
      taskId: taskId ?? this.taskId,
      changeTime: changeTime ?? this.changeTime,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (taskId.present) {
      map['task_id'] = Variable<String>(taskId.value);
    }
    if (changeTime.present) {
      map['change_time'] = Variable<DateTime>(changeTime.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DynamicPriorityChangesCompanion(')
          ..write('taskId: $taskId, ')
          ..write('changeTime: $changeTime, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $TasksTable tasks = $TasksTable(this);
  late final $SubTaskLinksTable subTaskLinks = $SubTaskLinksTable(this);
  late final $DynamicPriorityChangesTable dynamicPriorityChanges =
      $DynamicPriorityChangesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    tasks,
    subTaskLinks,
    dynamicPriorityChanges,
  ];
}

typedef $$TasksTableCreateCompanionBuilder =
    TasksCompanion Function({
      required String id,
      required String title,
      Value<DateTime?> dueDate,
      required TaskCategory category,
      required TaskPriority priority,
      Value<String?> parentTaskId,
      Value<int?> estimatedTimeMinutes,
      Value<bool> isCompleted,
      Value<DateTime?> completedAt,
      Value<int?> repeatIntervalDays,
      Value<int> rowid,
    });
typedef $$TasksTableUpdateCompanionBuilder =
    TasksCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<DateTime?> dueDate,
      Value<TaskCategory> category,
      Value<TaskPriority> priority,
      Value<String?> parentTaskId,
      Value<int?> estimatedTimeMinutes,
      Value<bool> isCompleted,
      Value<DateTime?> completedAt,
      Value<int?> repeatIntervalDays,
      Value<int> rowid,
    });

class $$TasksTableFilterComposer extends Composer<_$AppDatabase, $TasksTable> {
  $$TasksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<TaskCategory, TaskCategory, int>
  get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<TaskPriority, TaskPriority, int>
  get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get parentTaskId => $composableBuilder(
    column: $table.parentTaskId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get estimatedTimeMinutes => $composableBuilder(
    column: $table.estimatedTimeMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get repeatIntervalDays => $composableBuilder(
    column: $table.repeatIntervalDays,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TasksTableOrderingComposer
    extends Composer<_$AppDatabase, $TasksTable> {
  $$TasksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get parentTaskId => $composableBuilder(
    column: $table.parentTaskId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get estimatedTimeMinutes => $composableBuilder(
    column: $table.estimatedTimeMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get repeatIntervalDays => $composableBuilder(
    column: $table.repeatIntervalDays,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TasksTableAnnotationComposer
    extends Composer<_$AppDatabase, $TasksTable> {
  $$TasksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<DateTime> get dueDate =>
      $composableBuilder(column: $table.dueDate, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TaskCategory, int> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TaskPriority, int> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<String> get parentTaskId => $composableBuilder(
    column: $table.parentTaskId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get estimatedTimeMinutes => $composableBuilder(
    column: $table.estimatedTimeMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get repeatIntervalDays => $composableBuilder(
    column: $table.repeatIntervalDays,
    builder: (column) => column,
  );
}

class $$TasksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TasksTable,
          Task,
          $$TasksTableFilterComposer,
          $$TasksTableOrderingComposer,
          $$TasksTableAnnotationComposer,
          $$TasksTableCreateCompanionBuilder,
          $$TasksTableUpdateCompanionBuilder,
          (Task, BaseReferences<_$AppDatabase, $TasksTable, Task>),
          Task,
          PrefetchHooks Function()
        > {
  $$TasksTableTableManager(_$AppDatabase db, $TasksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TasksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TasksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TasksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<DateTime?> dueDate = const Value.absent(),
                Value<TaskCategory> category = const Value.absent(),
                Value<TaskPriority> priority = const Value.absent(),
                Value<String?> parentTaskId = const Value.absent(),
                Value<int?> estimatedTimeMinutes = const Value.absent(),
                Value<bool> isCompleted = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<int?> repeatIntervalDays = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TasksCompanion(
                id: id,
                title: title,
                dueDate: dueDate,
                category: category,
                priority: priority,
                parentTaskId: parentTaskId,
                estimatedTimeMinutes: estimatedTimeMinutes,
                isCompleted: isCompleted,
                completedAt: completedAt,
                repeatIntervalDays: repeatIntervalDays,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                Value<DateTime?> dueDate = const Value.absent(),
                required TaskCategory category,
                required TaskPriority priority,
                Value<String?> parentTaskId = const Value.absent(),
                Value<int?> estimatedTimeMinutes = const Value.absent(),
                Value<bool> isCompleted = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<int?> repeatIntervalDays = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TasksCompanion.insert(
                id: id,
                title: title,
                dueDate: dueDate,
                category: category,
                priority: priority,
                parentTaskId: parentTaskId,
                estimatedTimeMinutes: estimatedTimeMinutes,
                isCompleted: isCompleted,
                completedAt: completedAt,
                repeatIntervalDays: repeatIntervalDays,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TasksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TasksTable,
      Task,
      $$TasksTableFilterComposer,
      $$TasksTableOrderingComposer,
      $$TasksTableAnnotationComposer,
      $$TasksTableCreateCompanionBuilder,
      $$TasksTableUpdateCompanionBuilder,
      (Task, BaseReferences<_$AppDatabase, $TasksTable, Task>),
      Task,
      PrefetchHooks Function()
    >;
typedef $$SubTaskLinksTableCreateCompanionBuilder =
    SubTaskLinksCompanion Function({
      required String taskId,
      required String subTaskId,
      Value<int> rowid,
    });
typedef $$SubTaskLinksTableUpdateCompanionBuilder =
    SubTaskLinksCompanion Function({
      Value<String> taskId,
      Value<String> subTaskId,
      Value<int> rowid,
    });

class $$SubTaskLinksTableFilterComposer
    extends Composer<_$AppDatabase, $SubTaskLinksTable> {
  $$SubTaskLinksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get taskId => $composableBuilder(
    column: $table.taskId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get subTaskId => $composableBuilder(
    column: $table.subTaskId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SubTaskLinksTableOrderingComposer
    extends Composer<_$AppDatabase, $SubTaskLinksTable> {
  $$SubTaskLinksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get taskId => $composableBuilder(
    column: $table.taskId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get subTaskId => $composableBuilder(
    column: $table.subTaskId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SubTaskLinksTableAnnotationComposer
    extends Composer<_$AppDatabase, $SubTaskLinksTable> {
  $$SubTaskLinksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get taskId =>
      $composableBuilder(column: $table.taskId, builder: (column) => column);

  GeneratedColumn<String> get subTaskId =>
      $composableBuilder(column: $table.subTaskId, builder: (column) => column);
}

class $$SubTaskLinksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SubTaskLinksTable,
          SubTaskLink,
          $$SubTaskLinksTableFilterComposer,
          $$SubTaskLinksTableOrderingComposer,
          $$SubTaskLinksTableAnnotationComposer,
          $$SubTaskLinksTableCreateCompanionBuilder,
          $$SubTaskLinksTableUpdateCompanionBuilder,
          (
            SubTaskLink,
            BaseReferences<_$AppDatabase, $SubTaskLinksTable, SubTaskLink>,
          ),
          SubTaskLink,
          PrefetchHooks Function()
        > {
  $$SubTaskLinksTableTableManager(_$AppDatabase db, $SubTaskLinksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SubTaskLinksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SubTaskLinksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SubTaskLinksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> taskId = const Value.absent(),
                Value<String> subTaskId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SubTaskLinksCompanion(
                taskId: taskId,
                subTaskId: subTaskId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String taskId,
                required String subTaskId,
                Value<int> rowid = const Value.absent(),
              }) => SubTaskLinksCompanion.insert(
                taskId: taskId,
                subTaskId: subTaskId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SubTaskLinksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SubTaskLinksTable,
      SubTaskLink,
      $$SubTaskLinksTableFilterComposer,
      $$SubTaskLinksTableOrderingComposer,
      $$SubTaskLinksTableAnnotationComposer,
      $$SubTaskLinksTableCreateCompanionBuilder,
      $$SubTaskLinksTableUpdateCompanionBuilder,
      (
        SubTaskLink,
        BaseReferences<_$AppDatabase, $SubTaskLinksTable, SubTaskLink>,
      ),
      SubTaskLink,
      PrefetchHooks Function()
    >;
typedef $$DynamicPriorityChangesTableCreateCompanionBuilder =
    DynamicPriorityChangesCompanion Function({
      required String taskId,
      required DateTime changeTime,
      Value<int> rowid,
    });
typedef $$DynamicPriorityChangesTableUpdateCompanionBuilder =
    DynamicPriorityChangesCompanion Function({
      Value<String> taskId,
      Value<DateTime> changeTime,
      Value<int> rowid,
    });

class $$DynamicPriorityChangesTableFilterComposer
    extends Composer<_$AppDatabase, $DynamicPriorityChangesTable> {
  $$DynamicPriorityChangesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get taskId => $composableBuilder(
    column: $table.taskId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get changeTime => $composableBuilder(
    column: $table.changeTime,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DynamicPriorityChangesTableOrderingComposer
    extends Composer<_$AppDatabase, $DynamicPriorityChangesTable> {
  $$DynamicPriorityChangesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get taskId => $composableBuilder(
    column: $table.taskId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get changeTime => $composableBuilder(
    column: $table.changeTime,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DynamicPriorityChangesTableAnnotationComposer
    extends Composer<_$AppDatabase, $DynamicPriorityChangesTable> {
  $$DynamicPriorityChangesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get taskId =>
      $composableBuilder(column: $table.taskId, builder: (column) => column);

  GeneratedColumn<DateTime> get changeTime => $composableBuilder(
    column: $table.changeTime,
    builder: (column) => column,
  );
}

class $$DynamicPriorityChangesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DynamicPriorityChangesTable,
          DynamicPriorityChange,
          $$DynamicPriorityChangesTableFilterComposer,
          $$DynamicPriorityChangesTableOrderingComposer,
          $$DynamicPriorityChangesTableAnnotationComposer,
          $$DynamicPriorityChangesTableCreateCompanionBuilder,
          $$DynamicPriorityChangesTableUpdateCompanionBuilder,
          (
            DynamicPriorityChange,
            BaseReferences<
              _$AppDatabase,
              $DynamicPriorityChangesTable,
              DynamicPriorityChange
            >,
          ),
          DynamicPriorityChange,
          PrefetchHooks Function()
        > {
  $$DynamicPriorityChangesTableTableManager(
    _$AppDatabase db,
    $DynamicPriorityChangesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DynamicPriorityChangesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$DynamicPriorityChangesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$DynamicPriorityChangesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> taskId = const Value.absent(),
                Value<DateTime> changeTime = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DynamicPriorityChangesCompanion(
                taskId: taskId,
                changeTime: changeTime,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String taskId,
                required DateTime changeTime,
                Value<int> rowid = const Value.absent(),
              }) => DynamicPriorityChangesCompanion.insert(
                taskId: taskId,
                changeTime: changeTime,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DynamicPriorityChangesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DynamicPriorityChangesTable,
      DynamicPriorityChange,
      $$DynamicPriorityChangesTableFilterComposer,
      $$DynamicPriorityChangesTableOrderingComposer,
      $$DynamicPriorityChangesTableAnnotationComposer,
      $$DynamicPriorityChangesTableCreateCompanionBuilder,
      $$DynamicPriorityChangesTableUpdateCompanionBuilder,
      (
        DynamicPriorityChange,
        BaseReferences<
          _$AppDatabase,
          $DynamicPriorityChangesTable,
          DynamicPriorityChange
        >,
      ),
      DynamicPriorityChange,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$TasksTableTableManager get tasks =>
      $$TasksTableTableManager(_db, _db.tasks);
  $$SubTaskLinksTableTableManager get subTaskLinks =>
      $$SubTaskLinksTableTableManager(_db, _db.subTaskLinks);
  $$DynamicPriorityChangesTableTableManager get dynamicPriorityChanges =>
      $$DynamicPriorityChangesTableTableManager(
        _db,
        _db.dynamicPriorityChanges,
      );
}
