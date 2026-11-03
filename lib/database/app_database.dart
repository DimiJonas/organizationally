import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:drift/native.dart';

part 'app_database.g.dart';

class Tasks extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  DateTimeColumn get dueDate => dateTime().nullable()();
  IntColumn get category => intEnum<TaskCategory>()();
  IntColumn get priority => intEnum<TaskPriority>()();
  TextColumn get parentTaskId => text().nullable()();
  IntColumn get estimatedTimeMinutes => integer().nullable()();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get completedAt => dateTime().nullable()();
  IntColumn get repeatIntervalDays => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class SubTaskLinks extends Table {
  TextColumn get taskId => text()(); // main task
  TextColumn get subTaskId => text()(); // dependent task
}

class DynamicPriorityChanges extends Table {
  TextColumn get taskId => text()();
  DateTimeColumn get changeTime => dateTime()();
}

enum TaskCategory { repeated, oneShot, freetime }
enum TaskPriority { low, medium, high }

@DriftDatabase(tables: [Tasks, SubTaskLinks, DynamicPriorityChanges])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<Task>> getAllTasks() => select(tasks).get();
  Stream<List<Task>> watchAllTasks() => select(tasks).watch();
  Future<void> insertTask(Task task) => into(tasks).insert(task, mode: InsertMode.insertOrReplace);
  Future<void> deleteTaskById(String id) => (delete(tasks)..where((t) => t.id.equals(id))).go();
  Future<void> updateTask(Task task) => update(tasks).replace(task);
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final dbPath = p.join(dir.path, 'tasks.sqlite');
    return NativeDatabase.createInBackground(
      File(dbPath),
      logStatements: true,
    );
  });
}
