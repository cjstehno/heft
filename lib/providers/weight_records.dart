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
}
