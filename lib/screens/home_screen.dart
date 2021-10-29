import 'package:flutter/material.dart';
import 'package:heft/widgets/status_display.dart';
import 'package:heft/widgets/weight_log.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Heft'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // FIXME: open the add record dialog
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // FIXME: open the share dialog
            },
          ),
        ],
      ),
      body: Column(
        children: [
          StatusDisplay(),
          WeightLog(),
        ],
      ),
    );
  }
}
