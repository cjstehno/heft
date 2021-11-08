import 'dart:developer' as dev;
import 'package:heft/models/weight_record.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseAccessor {
  static const String _weightRecordsTable = 'weight_records';

  DatabaseAccessor._();

  static final DatabaseAccessor db = DatabaseAccessor._();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    dev.log('Initializing database...', name: 'db.databaseaccessor');
    return await openDatabase(
      'heft.db',
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        dev.log('Creating tables...', name: 'db.databaseaccessor');
        await db.execute("""CREATE TABLE weight_records (
          id INTEGER PRIMARY KEY,
          timestamp INTEGER NOT NULL,
          weight REAL NOT NULL
        )""");
      },
    );
  }

  // FIXME: ordering, limiting
  Future<List<WeightRecord>> retrieveAllRecords() async {
    final db = await database;
    final res = await db.query(_weightRecordsTable);
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
