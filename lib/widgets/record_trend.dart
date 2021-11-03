import 'package:flutter/material.dart';
import 'package:heft/models/weight_record.dart';

class RecordTrend extends StatelessWidget {

  final WeightRecord current;
  final WeightRecord? previous;

  const RecordTrend(this.current, this.previous);

  @override
  Widget build(final BuildContext context) {
    final change = previous != null ?  current.weight - previous!.weight : 0.0;

    return SizedBox(
      width: 75,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if( change < 0) const Icon(
            Icons.arrow_downward,
            color: Colors.green,
          ),
          if( change > 0) const Icon(
            Icons.arrow_upward,
            color: Colors.red,
          ),
          Text(
            change.abs().toStringAsFixed(1),
            style: TextStyle(
              fontSize: 18,
              color: change == 0 ? Colors.black : (change < 0 ? Colors.green : Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
