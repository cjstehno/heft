import 'dart:developer' as dev;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:heft/models/weight_record.dart';
import 'package:hive/hive.dart';

class WeightRecords with ChangeNotifier {
  static const _tag = 'heft.provider.weightrecords';
  static const _weightRecords = 'weight-records';
  final List<WeightRecord> _records = [];

  Future<void> load() async {
    final box = await Hive.openBox<WeightRecord>(_weightRecords);

    _records.clear();
    _records.addAll(box.values);
    _sortRecords();

    dev.log('Loaded ${_records.length} records...', name: _tag);
  }

  List<WeightRecord> get records {
    return _records;
  }

  WeightRecord? get mostRecent {
    return _records.isNotEmpty ? records[0] : null;
  }

  String get csv {
    return records
        .map((rec) => '${rec.timestamp},${rec.weight}')
        .toList()
        .join('\n');
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
    // add to the box
    Hive.openBox<WeightRecord>(_weightRecords).then((box) {
      box.add(record).then((_) {
        // add to cache
        _records.add(record);
        _sortRecords();

        dev.log('Created: $record.', name: _tag);

        notifyListeners();
      });
    });
  }

  void update(final WeightRecord record) {
    Hive.openBox<WeightRecord>(_weightRecords).then((box) {
      // update box
      box.putAt(
        box.values.toList(growable: false).indexWhere((r) => r.id == record.id),
        record,
      );

      // update the local cache
      _records.setAll(
        _records.indexWhere((r) => r.id == record.id),
        [record],
      );
      _sortRecords();

      dev.log('Updated: $record.', name: _tag);

      notifyListeners();
    });
  }

  void remove(final String recordId) {
    Hive.openBox<WeightRecord>(_weightRecords).then((box) {
      // remove it from the box
      final boxIndex = box.values
          .toList(growable: false)
          .indexWhere((r) => r.id == recordId);
      box.deleteAt(boxIndex).then((_) {
        // remove it from the local list
        _records.removeWhere((r) => r.id == recordId);

        dev.log('Deleted: $recordId.', name: _tag);

        notifyListeners();
      });
    });
  }

  void _sortRecords() {
    _records.sort((a, b) => b.timestamp.compareTo(a.timestamp));
  }
}
