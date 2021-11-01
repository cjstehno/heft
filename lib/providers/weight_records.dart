import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:heft/models/weight_record.dart';

class WeightRecords with ChangeNotifier {
  static const _tag = 'penguin.weightrecords';

  final List<WeightRecord> _records = [];

  List<WeightRecord> get records {
    return _sort(_records);
  }

  WeightRecord get mostRecent {
    return records[0];
  }

  void create(final WeightRecord record) {
    _records.add(record);

    notifyListeners();
  }

  void update(final WeightRecord record) {
    final old = _records.firstWhere((r) => r.id == record.id);
    _records.remove(old);
    _records.add(old.copyWith(
      timestamp: record.timestamp,
      weight: record.weight,
    ));

    notifyListeners();
  }

  void remove(final String recordId) {
    _records.removeWhere((r) => r.id == recordId);

    notifyListeners();
  }

  static List<WeightRecord> _sort(final List<WeightRecord> recs){
    var working = [...recs];

    working.sort((a,b) {
      return b.timestamp.compareTo(a.timestamp);
    });

    return working;
  }
}
