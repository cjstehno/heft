import 'package:flutter/material.dart';
import 'package:heft/models/weight_record.dart';

class RecentTrend extends StatelessWidget {
  final WeightRecord? latest;
  final WeightRecord? previous;

  const RecentTrend(this.latest, this.previous);

  @override
  Widget build(final BuildContext context) {
    final enabled = latest != null && previous != null;
    final change = enabled ? latest!.weight - previous!.weight : 0.0;

    return Row(
      children: [
        if (enabled && change != 0) _resolveDirection(change),
        Text(
          change.abs().toStringAsFixed(1),
          style: TextStyle(
            color: enabled ? _color(change) : Colors.black12,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Icon _resolveDirection(final double change) {
    return Icon(
      change > 0 ? Icons.arrow_upward : Icons.arrow_downward,
      size: 18,
      color: _color(change),
    );
  }

  Color _color(final double change){
      return change > 0 ? Colors.red : Colors.green;
  }
}
