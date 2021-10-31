import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:heft/models/weight_record.dart';
import 'package:heft/providers/weight_records.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class WeightRecordScreen extends StatefulWidget {
  static const routeName = '/weight-record';

  const WeightRecordScreen({Key? key}) : super(key: key);

  @override
  _WeightRecordScreenState createState() => _WeightRecordScreenState();
}

class _WeightRecordScreenState extends State<WeightRecordScreen> {
  final _form = GlobalKey<FormState>();
  WeightRecord _record = WeightRecord(
    timestamp: DateTime.now(),
    // TODO: should populate from most recent record
    weight: 0,
  );

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weight Record'),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: FutureBuilder(
          future: _prefs(),
          builder: (ctx, snap) {
            if (snap.hasData) {
              final units =
                  _getPrefString(snap.data as SharedPreferences, 'units');
              final wtUnit = units == 'imperial' ? 'pounds' : 'kilograms';
              final wtUnitAbb = units == 'imperial' ? 'lb' : 'kg';

              return Form(
                key: _form,
                child: Column(
                  children: [
                    DateTimeField(
                      decoration: const InputDecoration(
                        labelText: 'Date',
                        hintText: 'When did you weigh in?',
                      ),
                      format: DateFormat('MMM dd yyyy'),
                      initialValue: _record.timestamp,
                      onShowPicker: (context, currentValue) {
                        return showDatePicker(
                          context: context,
                          initialDate: currentValue ?? DateTime.now(),
                          firstDate:
                              DateTime.now().subtract(const Duration(days: 90)),
                          lastDate: DateTime.now(),
                        );
                      },
                      onSaved: (value) =>
                          _record = _record.copyWith(timestamp: value),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Weight ($wtUnitAbb)',
                        hintText: 'How much do you weigh (in $wtUnit)?',
                      ),
                      autofocus: true,
                      validator: (value) => _weightValidator(value, wtUnitAbb!),
                      initialValue:
                          _record.weight == 0 ? '' : _record.weight.toString(),
                      keyboardType: const TextInputType.numberWithOptions(
                        signed: false,
                        decimal: true,
                      ),
                      onSaved: (value) {
                        _record = _record.copyWith(
                          weight: double.parse(value!),
                        );
                      },
                    ),
                  ],
                ),
              );
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
      bottomSheet: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: ElevatedButton(
              child: const Text('Save'),
              onPressed: () => _saveRecord(context.read<WeightRecords>()),
            ),
          ),
        ],
      ),
    );
  }

  String? _weightValidator(final String? value, final String wtUnits) {
    // TODO: use units to determine range
    if (value == null || value.isEmpty || double.tryParse(value!) == null) {
      return 'Weight must be a number between 1 and 1000 $wtUnits';
    }

    return null;
  }

  void _saveRecord(final WeightRecords records){
    if( _form.currentState!.validate()){
      _form.currentState!.save();

      records.save(_record);

      Navigator.of(context).pop();
    }
  }

  // FIXME: should this be pulled into a provider?
  Future<SharedPreferences> _prefs() async {
    return SharedPreferences.getInstance();
  }

  String? _getPrefString(final Object prefs, final String key) {
    return (prefs as SharedPreferences).getString(key);
  }
}
