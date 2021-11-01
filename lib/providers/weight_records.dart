import 'dart:developer' as dev;

import 'package:flutter/foundation.dart';
import 'package:heft/models/weight_record.dart';

class WeightRecords with ChangeNotifier {
  static const _tag = 'penguin.weightrecords';

  final List<WeightRecord> _records = [];

  List<WeightRecord> get records {
    // FIXME: these should be sorted by date descending
    return _records;
  }

  void create(final WeightRecord record) {
    _records.add(record);

    dev.log('Added record: $record', name: _tag);

    notifyListeners();
  }

  void update(final WeightRecord record) {
    final old = _records.firstWhere((r) => r.id == record.id);
    _records.remove(old);
    _records.add(old.copyWith(
      timestamp: record.timestamp,
      weight: record.weight,
    ));

    dev.log('Updated record: $record', name: _tag);

    notifyListeners();
  }

  // FIXME: support delete
  void remove(final WeightRecord record) {
    dev.log('Removed record: $record', name: _tag);
  }
}
