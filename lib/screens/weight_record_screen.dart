import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeightRecordScreen extends StatefulWidget {
  static const routeName = '/weight-record';

  const WeightRecordScreen({Key? key}) : super(key: key);

  @override
  _WeightRecordScreenState createState() => _WeightRecordScreenState();
}

class _WeightRecordScreenState extends State<WeightRecordScreen> {
  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weight Record'),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _form,
          child: Column(
            children: [
              DateTimeField(
                decoration: const InputDecoration(
                  labelText: 'Date',
                  hintText: 'When did you weigh in?',
                ),
                format: DateFormat('MMM dd yyyy'),
                initialValue: DateTime.now(),
                onShowPicker: (context, currentValue) {
                  return showDatePicker(
                    context: context,
                    initialDate: currentValue ?? DateTime.now(),
                    firstDate:
                        DateTime.now().subtract(const Duration(days: 90)),
                    lastDate: DateTime.now(),
                  );
                },
                onSaved: (value) {
                  // FIXME: save form
                  // _editedItem = _editedItem!.copyWith(frozenOn: value);
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Weight',
                  // FIXME: bring in the configured units.
                  hintText: 'How much do you weigh (in )?',
                ),
                // FIXME: might be nice to bring in the last record weight
                initialValue: '',
                keyboardType: const TextInputType.numberWithOptions(
                  signed: false,
                  decimal: true,
                ),
                onSaved: (value) {
                  // FIXME: save the value
                  // _editedItem = _editedItem!.copyWith(location: value);
                },
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: ElevatedButton(
              child: const Text('Save'),
              onPressed: () {
                // FIXME: save the form
              },
            ),
          ),
        ],
      ),
    );
  }
}
