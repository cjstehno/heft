import 'package:flutter/material.dart';

class Trend extends StatelessWidget {
  final double change;
  final bool enabled;

  Trend(this.change, this.enabled);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (enabled && change != 0) _resolveDirection(),
        Text(
          change.abs().toStringAsFixed(1),
          style: TextStyle(
            color: _color(),
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Icon _resolveDirection() {
    return Icon(
      change > 0 ? Icons.arrow_upward : Icons.arrow_downward,
      size: 18,
      color: _color(),
    );
  }

  Color _color(){
    if( enabled ){
      return change > 0 ? Colors.red : Colors.green;
    }
    return Colors.black12;
  }
}
