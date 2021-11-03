import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimestampCell extends StatelessWidget {
  static const _date = 'M/d/yyyy';
  static const _time = 'H:mm a';

  final DateTime timestamp;

  const TimestampCell(this.timestamp);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      child: Column(
        children: [
          Text(
            DateFormat(_date).format(timestamp),
            style: const TextStyle(fontSize: 16),
          ),
          Text(
            DateFormat(_time).format(timestamp),
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
      padding: const EdgeInsets.only(top: 10),
      alignment: Alignment.centerLeft,
    );
  }
}
