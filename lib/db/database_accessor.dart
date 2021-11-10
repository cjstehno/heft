import 'dart:developer' as dev;

import 'package:heft/models/weight_record.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseAccessor {
  static const String _weightRecordsTable = 'weight_records';
  static const String _tag = 'db.databaseaccessor';

  DatabaseAccessor._();

  static final DatabaseAccessor db = DatabaseAccessor._();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    dev.log('Initializing database...', name: _tag);
    return await openDatabase(
      'heft.db',
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        dev.log('Creating tables...', name: _tag);
        await db.execute("""CREATE TABLE weight_records (
          id INTEGER PRIMARY KEY,
          timestamp INTEGER NOT NULL,
          weight REAL NOT NULL
        )""");
      },
    );
  }

  Future<List<WeightRecord>> retrieveRecordsWithin(final int days) async {
    final res = await (await database).query(
      _weightRecordsTable,
      orderBy: 'timestamp desc',
      where: "cast(julianday('now') - julianday(timestamp/1000, 'unixepoch') as INTEGER ) <= ?",
      whereArgs: [days],
    );
    return res.isNotEmpty
        ? res.map((r) => WeightRecord.fromMap(r)).toList()
        : [];
  }

  Future<List<WeightRecord>> retrieveRecords([int? limit]) async {
    final res = await (await database)
        .query(_weightRecordsTable, orderBy: 'timestamp desc', limit: limit);
    return res.isNotEmpty
        ? res.map((r) => WeightRecord.fromMap(r)).toList()
        : [];
  }

  Future<WeightRecord> createRecord(final WeightRecord record) async {
    final recordId = await (await database).insert(
      _weightRecordsTable,
      record.toMap(),
    );
    return record.copyWith(id: recordId);
  }

  Future<void> updateRecord(final WeightRecord record) async {
    await (await database).update(
      _weightRecordsTable,
      record.toMap(),
      where: 'id = ?',
      whereArgs: [record.id],
    );
  }

  Future<void> deleteRecord(final int id) async {
    (await database).delete(
      _weightRecordsTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
