import 'package:flutter/material.dart';

class CurrentWeight extends StatelessWidget {
  const CurrentWeight({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text(
          '205',
          style: TextStyle(
            fontSize: 44,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '10/20/2021',
          style: TextStyle(
            fontSize: 12,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }
}
