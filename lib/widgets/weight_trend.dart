import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:heft/providers/weight_records.dart';
import 'package:heft/widgets/trend.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class WeightTrend extends StatelessWidget {

  @override
  Widget build(final BuildContext context) {
    context.watch<WeightRecords>();

    final weightRecords = context.read<WeightRecords>();
    final records = weightRecords.records;
    final enabled = weightRecords.count > 1;
    final change = enabled ? records[0].weight - records[1].weight : 0.0;

    return Column(
      children: [
        Trend(change, enabled),
        Text(
          enabled
              ? DateFormat('M/d/yyyy').format(records[1].timestamp)
              : '-/-/----',
          style: TextStyle(
            fontSize: 12,
            color: enabled ? Colors.black : Colors.black12,
            fontStyle: FontStyle.italic,
          ),
        )
      ],
    );
  }
}
