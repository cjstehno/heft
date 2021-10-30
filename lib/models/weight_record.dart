import 'package:hive/hive.dart';

part 'weight_record.g.dart';

@HiveType(typeId: 0)
class WeightRecord {
  @HiveField(0)
  final DateTime timestamp;

  @HiveField(1)
  final int weight;

  WeightRecord({
    required this.timestamp,
    required this.weight,
  });
}
