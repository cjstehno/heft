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

  Future<List<WeightRecord>> get records async {
    return DatabaseAccessor.db.retrieveRecords();
  }

  Future<WeightRecord?> get mostRecent async {
    final list = await DatabaseAccessor.db.retrieveRecords(1);
    return list.isNotEmpty ? list[0] : null;
  }

  Future<List<WeightRecord>> recordsWithin(final int days) async {
    return DatabaseAccessor.db.retrieveRecordsWithin(days);
  }

  Future<File> export() async {
    final directory = await path_provider.getApplicationDocumentsDirectory();
    final File exportFile = File(
      '${directory.path}/heft-export-${DateTime.now().millisecondsSinceEpoch}.csv',
    );

    final exporting = await records;

    final exportFormat = DateFormat('MM-dd-yyyy');
    await exportFile.writeAsString(
      exporting
          .map((rec) => '${exportFormat.format(rec.timestamp)},${rec.weight}')
          .toList()
          .join('\n'),
    );

    dev.log(
      'Exported ${exporting.length} records to csv file (${exportFile.path}).',
    );

    return exportFile;
  }

  void create(final WeightRecord record) {
    DatabaseAccessor.db.createRecord(record).then((rec) {
      dev.log('Created: $record.', name: _tag);
      notifyListeners();
    });
  }

  void update(final WeightRecord record) {
    DatabaseAccessor.db.updateRecord(record).then((rec) {
      dev.log('Updated: $record.', name: _tag);
      notifyListeners();
    });
  }

  void remove(final int recordId) {
    DatabaseAccessor.db.deleteRecord(recordId).then((rec) {
      dev.log('Deleted: $recordId.', name: _tag);
      notifyListeners();
    });
  }
}
