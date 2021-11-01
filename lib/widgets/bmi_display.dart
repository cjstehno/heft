import 'package:flutter/material.dart';
import 'package:heft/providers/bmi_calculator.dart';
import 'package:heft/providers/weight_records.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BmiDisplay extends StatelessWidget {
  const BmiDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.watch<WeightRecords>();

    final mostRecent = context.read<WeightRecords>().mostRecent;

    return FutureBuilder(
      future: SharedPreferences.getInstance(),
      builder: (ctx, snap) {
        if (snap.hasData) {
          final bmi = BmiCalculator.calculate(
            _getPrefString(snap.data!, 'units') ?? 'imperial',
            double.parse(_getPrefString(snap.data!, 'height') ?? '0.0'),
            mostRecent.weight,
          );

          return Column(
            children: [
              Text(
                bmi.value.toStringAsFixed(1),
                style: TextStyle(
                  color: _selectColor(bmi.category),
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                bmi.category.name,
                style: TextStyle(
                  color: _selectColor(bmi.category),
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  Color _selectColor(final BmiCategory category) {
    switch (category) {
      case BmiCategory.underweight:
        return Colors.red;
      case BmiCategory.healthy:
        return Colors.green;
      case BmiCategory.overweight:
        return Colors.orange;
      case BmiCategory.obese:
        return Colors.red;
    }
  }

  // FIXME: might be useful to have a provider or helper class for these
  String? _getPrefString(final Object prefs, final String key) {
    return (prefs as SharedPreferences).getString(key);
  }
}
