import 'package:flutter/foundation.dart';
import 'package:heft/models/weight_record.dart';

class WeightRecords with ChangeNotifier {

  final List<WeightRecord> _records = [];

  List<WeightRecord> get records {
    // FIXME: these should be sorted by date descending
    return _records;
  }

  void save(final WeightRecord record){
    _records.add(record);
    notifyListeners();
  }
}