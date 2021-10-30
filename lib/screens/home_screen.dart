import 'package:flutter/material.dart';
import 'package:heft/screens/settings_screen.dart';
import 'package:heft/screens/weight_record_screen.dart';
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
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.of(context).pushNamed(SettingsScreen.routeName),
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // FIXME: open the add record dialog
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => Navigator.of(context).pushNamed(WeightRecordScreen.routeName),
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
