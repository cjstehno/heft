import 'package:hive/hive.dart';

part 'weight_record.g.dart';

@HiveType(typeId: 0)
class WeightRecord {
  @HiveField(0)
  final DateTime timestamp;

  @HiveField(1)
  final double weight;

  WeightRecord({
    required this.timestamp,
    required this.weight,
  });

  WeightRecord copyWith({
    DateTime? timestamp,
    double? weight,
  }) =>
      WeightRecord(
        timestamp: timestamp ?? this.timestamp,
        weight: weight ?? this.weight,
      );
}
