import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WeightTrend extends StatelessWidget {
  const WeightTrend({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: const [
            Icon(
              Icons.arrow_upward,
              size: 18,
              color: Colors.red,
            ),
            Text(
              '5',
              style: TextStyle(
                color: Colors.red,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const Text(
          '10/05/2021',
          style: TextStyle(
            fontSize: 12,
            fontStyle: FontStyle.italic,
          ),
        )
      ],
    );
  }
}
