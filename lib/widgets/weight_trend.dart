import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:heft/models/weight_record.dart';
import 'package:heft/providers/weight_records.dart';
import 'package:heft/widgets/recent_trend.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class WeightTrend extends StatelessWidget {
  @override
  Widget build(final BuildContext context) {
    context.watch<WeightRecords>();

    return FutureBuilder(
      future: context.read<WeightRecords>().recordsWithin(90),
      builder: (ctx, snap) {
        if (snap.hasData) {
          final records = snap.data as List<WeightRecord>;
          final mostRecent = records.isNotEmpty ? records.first : null;
          final within90d = records.isNotEmpty ? records.last : null;
          final enabled = mostRecent != null && within90d != null;

          return Column(
            children: [
              RecentTrend(mostRecent, within90d),
              Text(
                enabled
                    ? DateFormat('M/d/yyyy').format(within90d!.timestamp)
                    : '-/-/----',
                style: TextStyle(
                  fontSize: 12,
                  color:
                      enabled ? Colors.black : Theme.of(context).disabledColor,
                  fontStyle: FontStyle.italic,
                ),
              )
            ],
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
