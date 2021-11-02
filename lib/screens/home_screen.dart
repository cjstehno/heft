import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heft/providers/weight_records.dart';
import 'package:heft/screens/settings_screen.dart';
import 'package:heft/screens/weight_record_screen.dart';
import 'package:heft/widgets/status_display.dart';
import 'package:heft/widgets/weight_log.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(final BuildContext context) {
    // FIXME: implement pull to refresh

    return FutureBuilder(
      future: context.read<WeightRecords>().load(),
      builder: (ctx, snap) {
        if (snap.connectionState != ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Heft'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () =>
                      Navigator.of(context).pushNamed(SettingsScreen.routeName),
                ),
                IconButton(
                  icon: const Icon(Icons.share),
                  onPressed: () {
                    // FIXME: write the csv to a file then share that?
                    Share.share(
                      context.read<WeightRecords>().csv,
                      subject: 'Weight Records from Heft.',
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => Navigator.of(context)
                      .pushNamed(WeightRecordScreen.routeName),
                ),
              ],
            ),
            body: Column(
              children: [
                StatusDisplay(),
                Expanded(
                  child: WeightLog(),
                ),
              ],
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
