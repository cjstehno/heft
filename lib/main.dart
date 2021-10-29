import 'package:flutter/material.dart';
import 'package:heft/screens/home_screen.dart';

void main() => runApp(HeftApp());

class HeftApp extends StatelessWidget {

  @override
  Widget build(final BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}