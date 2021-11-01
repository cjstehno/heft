import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:heft/providers/weight_records.dart';
import 'package:heft/widgets/recent_trend.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class WeightTrend extends StatelessWidget {

  @override
  Widget build(final BuildContext context) {
    context.watch<WeightRecords>();

    final weightRecords = context.read<WeightRecords>();
    final mostRecent = weightRecords.mostRecent;
    final within30d = weightRecords.oldestWithin(30);
    final enabled = mostRecent != null && within30d != null;

    return Column(
      children: [
        RecentTrend(mostRecent, within30d,),
        Text(
          enabled
              ? DateFormat('M/d/yyyy').format(within30d!.timestamp)
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
