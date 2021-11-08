
import 'package:flutter/material.dart';
import 'package:heft/providers/weight_records.dart';
import 'package:heft/screens/home_screen.dart';
import 'package:heft/screens/settings_screen.dart';
import 'package:heft/screens/weight_record_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(HeftApp());

class HeftApp extends StatelessWidget {
  @override
  Widget build(final BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WeightRecords()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.brown,
          ).copyWith(
            secondary: Colors.green,
          ),
          textTheme: const TextTheme(bodyText2: TextStyle(color: Colors.black)),
          disabledColor: Colors.black12,
        ),
        home: HomeScreen(),
        routes: {
          SettingsScreen.routeName: (ctx) => SettingsScreen(),
          WeightRecordScreen.routeName: (ctx) => const WeightRecordScreen(),
        },
      ),
    );
  }
}
