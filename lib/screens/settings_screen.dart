import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = '/settings';

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  static const _genderKey = 'gender';
  static const _unitsKey = 'units';
  static const _heightKey = 'height';
  final _form = GlobalKey<FormState>();
  String? _units;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: FutureBuilder(
        future: _prefs(),
        builder: (ctx, snap) {
          if (snap.hasData) {
            _units = _getPrefString(snap.data!, _unitsKey);

            return Container(
              padding: const EdgeInsets.all(10),
              child: Form(
                key: _form,
                child: Column(
                  children: [
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(labelText: 'Gender'),
                      value: _getPrefString(snap.data!, _genderKey),
                      items: const [
                        DropdownMenuItem(
                          child: Text('Female'),
                          value: 'female',
                        ),
                        DropdownMenuItem(
                          child: Text('Male'),
                          value: 'male',
                        ),
                      ],
                      onChanged: (value) => _setPrefString(_genderKey, value!),
                    ),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(labelText: 'Units'),
                      value: _getPrefString(snap.data!, _unitsKey),
                      items: const [
                        DropdownMenuItem(
                          child: Text('Imperial (pounds, inches)'),
                          value: 'imperial',
                        ),
                        DropdownMenuItem(
                          child: Text('Metric (kilograms, centimeters)'),
                          value: 'metric',
                        ),
                      ],
                      onChanged: (value) {
                        _setPrefString(_unitsKey, value!);
                        setState(() {
                          _units = value;
                        });
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Height (${_units == 'imperial' ? 'in' : 'cm'})',
                        hintText:
                            'Your height in ${_units == 'imperial' ? 'inches' : 'centimeters'}.',
                      ),
                      initialValue: _getPrefString(snap.data!, _heightKey),
                      maxLines: 1,
                      keyboardType: const TextInputType.numberWithOptions(
                        signed: false, decimal: true,
                      ),
                      onChanged: (value) => _setPrefString(_heightKey, value),
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

  Future<SharedPreferences> _prefs() async {
    return SharedPreferences.getInstance();
  }

  void _setPrefString(final String key, final String value) {
    SharedPreferences.getInstance()
        .then((prefs) => prefs.setString(key, value));
  }

  String? _getPrefString(final Object prefs, final String key) {
    return (prefs as SharedPreferences).getString(key);
  }
}
