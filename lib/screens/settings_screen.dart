import 'package:flutter/material.dart';
import 'package:heft/models/units.dart';
import 'package:heft/providers/preferences.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = '/settings';

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _form = GlobalKey<FormState>();
  Units _units = Units.imperial;

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: FutureBuilder(
        future: Preferences.load(),
        builder: (ctx, snap) {
          if (snap.hasData) {
            _units = Preferences.fetchUnits(snap.data!) ?? Units.imperial;

            return Container(
              padding: const EdgeInsets.all(10),
              child: Form(
                key: _form,
                child: Column(
                  children: [
                    DropdownButtonFormField<Units>(
                      decoration: const InputDecoration(labelText: 'Units'),
                      value: _units,
                      items: const [
                        DropdownMenuItem(
                          child: Text('Imperial (pounds, inches)'),
                          value: Units.imperial,
                        ),
                        DropdownMenuItem(
                          child: Text('Metric (kilograms, centimeters)'),
                          value: Units.metric,
                        ),
                      ],
                      onChanged: (value) {
                        Preferences.saveUnits(value!);
                        setState(() {
                          _units = value;
                        });
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Height (${_units.heightUnitAbbr})',
                        hintText: 'Your height in ${_units.heightUnit}.',
                      ),
                      initialValue: (Preferences.fetchHeight(snap.data!) ?? 0.0)
                          .toStringAsFixed(2),
                      maxLines: 1,
                      keyboardType: const TextInputType.numberWithOptions(
                        signed: false,
                        decimal: true,
                      ),
                      onChanged: (value) =>
                          Preferences.saveHeight(double.parse(value)),
                    ),
                  ],
                ),
              ),
            );
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
