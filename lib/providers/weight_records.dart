import 'dart:developer' as dev;
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:heft/db/database_accessor.dart';
import 'package:heft/models/weight_record.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

// fIXME: testing
class WeightRecords with ChangeNotifier {
  static const _tag = 'heft.provider.weightrecords';
  final List<WeightRecord> _records = [];

  Future<void> load() async {
    // FIXME: why is this called twice
    final dbrecs = await DatabaseAccessor.db.retrieveAllRecords();

    _records.clear();
    _records.addAll(dbrecs);
    _sortRecords();

    dev.log('Loaded ${_records.length} records...', name: _tag);
  }

  List<WeightRecord> get records {
    return _records;
  }

  WeightRecord? get mostRecent {
    return _records.isNotEmpty ? records[0] : null;
  }

  Future<File> export() async {
    final directory = await path_provider.getApplicationDocumentsDirectory();
    final File exportFile = File(
      '${directory.path}/heft-export-${DateTime.now().millisecondsSinceEpoch}.csv',
    );

    final exportFormat = DateFormat('MM-dd-yyyy');
    await exportFile.writeAsString(
      records
          .map((rec) => '${exportFormat.format(rec.timestamp)},${rec.weight}')
          .toList()
          .join('\n'),
    );

    dev.log(
        'Exported ${_records.length} records to csv file (${exportFile.path}).');

    return exportFile;
  }

  WeightRecord? oldestWithin(final int days) {
    if (_records.isNotEmpty) {
      final boundary = DateTime.now().subtract(Duration(days: days));
      return _records.lastWhere(
        (r) => r.timestamp.isAfter(boundary),
        orElse: () => _records[0],
      );
    } else {
      return null;
    }
  }

  void create(final WeightRecord record) {
    DatabaseAccessor.db.createRecord(record).then((rec) {
      _records.add(rec);
      _sortRecords();

      dev.log('Created: $record.', name: _tag);

      notifyListeners();
    });
  }

  void update(final WeightRecord record) {
    DatabaseAccessor.db.updateRecord(record).then((rec) {
      _records.setAll(
        _records.indexWhere((r) => r.id == record.id),
        [record],
      );
      _sortRecords();

      dev.log('Updated: $record.', name: _tag);

      notifyListeners();
    });
  }

  void remove(final int recordId) {
    DatabaseAccessor.db.deleteRecord(recordId).then((rec) {
      _records.removeWhere((r) => r.id == recordId);

      dev.log('Deleted: $recordId.', name: _tag);

      notifyListeners();
    });
  }

  void _sortRecords() {
    _records.sort((a, b) => b.timestamp.compareTo(a.timestamp));
  }
}
