import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:heft/models/weight_record.dart';

class WeightRecords with ChangeNotifier {
  final List<WeightRecord> _records = [];

  List<WeightRecord> get records {
    return _sort(_records);
  }

  int get count {
    return _records.length;
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
    if (count != 0) {
      final boundary = DateTime.now().subtract(Duration(days: days));
      return records.lastWhere((r) => r.timestamp.isAfter(boundary));
    } else {
      return null;
    }
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

  static List<WeightRecord> _sort(final List<WeightRecord> recs) {
    var working = [...recs];

    working.sort((a, b) {
      return b.timestamp.compareTo(a.timestamp);
    });

    return working;
  }
}
