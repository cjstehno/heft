import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:heft/models/weight_record.dart';
import 'package:hive/hive.dart';
import 'dart:developer' as dev;

// TODO: may be able to simplify this by removing the local cache
//  - need to play with hive a bit.

class WeightRecords with ChangeNotifier {
  static const _tag = 'heft.provider.weightrecords';
  static const _weightRecords = 'weight-records';
  final List<WeightRecord> _records = [];

  Future<void> load() async {
    dev.log('loading...');
    final box = await Hive.openBox<WeightRecord>(_weightRecords);
    dev.log('found ${box.values.length} values in box...');
    _records.clear();
    _records.addAll(box.values.toList());
    dev.log('loaded ${_records.length} records...', name: _tag);
  }

  List<WeightRecord> get records {
    return _sort(_records);
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
      return records.lastWhere((r) => r.timestamp.isAfter(boundary));
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
        notifyListeners();
      });
    });
  }

  void update(final WeightRecord record) {
    Hive.openBox<WeightRecord>(_weightRecords).then((box) {
      // update box
      box.putAt(
          box.values
          .toList(growable: false)
          .indexWhere((r) => r.id == record.id),
          record,
      );

      // update the local cache
      _records.setAll(
          _records.indexWhere((r) => r.id == record.id),
          [record],
      );

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

        notifyListeners();
      });
    });
  }

  // FIXME: do on change
  static List<WeightRecord> _sort(final List<WeightRecord> recs) {
    var working = [...recs];

    working.sort((a, b) {
      return b.timestamp.compareTo(a.timestamp);
    });

    return working;
  }
}
