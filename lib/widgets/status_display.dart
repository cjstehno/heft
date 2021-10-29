import 'package:flutter/material.dart';
import 'package:heft/widgets/bmi_display.dart';
import 'package:heft/widgets/current_weight.dart';
import 'package:heft/widgets/weight_trend.dart';

class StatusDisplay extends StatelessWidget {
  const StatusDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      color: Colors.orange.shade100,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            WeightTrend(),
            Spacer(),
            CurrentWeight(),
            Spacer(),
            BmiDisplay(),
          ],
        ),
      ),
    );
  }
}
