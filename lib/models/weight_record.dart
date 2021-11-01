import 'package:hive/hive.dart';

part 'weight_record.g.dart';

@HiveType(typeId: 0)
class WeightRecord {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final DateTime timestamp;

  @HiveField(2)
  final double weight;

  const WeightRecord({
    required this.id,
    required this.timestamp,
    required this.weight,
  });

  @override
  String toString() {
    return 'WeightRecord{id: $id, timestamp: $timestamp, weight: $weight}';
  }

  WeightRecord copyWith({
    String? id,
    DateTime? timestamp,
    double? weight,
  }) =>
      WeightRecord(
        id: id ?? this.id,
        timestamp: timestamp ?? this.timestamp,
        weight: weight ?? this.weight,
      );
}
