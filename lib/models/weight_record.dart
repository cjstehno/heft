class WeightRecord {
  final int? id;
  final DateTime timestamp;
  final double weight;

  const WeightRecord({
    required this.id,
    required this.timestamp,
    required this.weight,
  });

  factory WeightRecord.fromMap(final Map<String, dynamic> map) => WeightRecord(
        id: map['id'],
        timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp']),
        weight: map['weight'],
      );

  @override
  String toString() {
    return 'WeightRecord{id: $id, timestamp: $timestamp, weight: $weight}';
  }

  WeightRecord copyWith({
    int? id,
    DateTime? timestamp,
    double? weight,
  }) =>
      WeightRecord(
        id: id ?? this.id,
        timestamp: timestamp ?? this.timestamp,
        weight: weight ?? this.weight,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'timestamp': timestamp.millisecondsSinceEpoch,
        'weight': weight,
      };
}
