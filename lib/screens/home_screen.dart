import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heft/providers/weight_records.dart';
import 'package:heft/screens/weight_record_screen.dart';
import 'package:heft/widgets/app_drawer.dart';
import 'package:heft/widgets/status_display.dart';
import 'package:heft/widgets/weight_log.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/';

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Heft'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              context.read<WeightRecords>().export().then((file) {
                Share.shareFiles(
                  [file.path],
                  mimeTypes: ['text/plain'],
                  subject: 'Weight Records from Heft.',
                ).then((_) => file.delete());
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () =>
                Navigator.of(context).pushNamed(WeightRecordScreen.routeName),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: Container(
        color: Colors.brown.shade50,
        child: Column(
          children: [
            const StatusDisplay(),
            Expanded(
              child: WeightLog(),
            ),
          ],
        ),
      ),
    );
  }
}
