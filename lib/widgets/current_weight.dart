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
      mostRecent.weight.toStringAsFixed(2),
      style: const TextStyle(
        fontSize: 42,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
