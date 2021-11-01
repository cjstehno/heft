import 'package:flutter/material.dart';
import 'package:heft/providers/weight_records.dart';
import 'package:provider/provider.dart';

class CurrentWeight extends StatelessWidget {
  const CurrentWeight({Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    context.watch<WeightRecords>();

    final mostRecent = context.read<WeightRecords>().mostRecent;

    return Text(
      mostRecent != null ? mostRecent.weight.toStringAsFixed(1) : '0.0',
      style: _style(mostRecent != null),
    );
  }

  TextStyle _style(final bool enabled) {
    return TextStyle(
      fontSize: 42,
      color: enabled ? Colors.black : Colors.black12,
      fontWeight: FontWeight.bold,
    );
  }
}
