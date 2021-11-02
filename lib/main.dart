import 'dart:io';

import 'package:flutter/material.dart';
import 'package:heft/models/weight_record.dart';
import 'package:heft/providers/weight_records.dart';
import 'package:heft/screens/home_screen.dart';
import 'package:heft/screens/settings_screen.dart';
import 'package:heft/screens/weight_record_screen.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(WeightRecordAdapter());
  runApp(HeftApp());
}

class HeftApp extends StatelessWidget {
  @override
  Widget build(final BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WeightRecords()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
        routes: {
          SettingsScreen.routeName: (ctx) => SettingsScreen(),
          WeightRecordScreen.routeName: (ctx) => const WeightRecordScreen(),
        },
      ),
    );
  }
}
