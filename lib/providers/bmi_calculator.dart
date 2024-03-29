import 'dart:math';

import 'package:heft/models/bmi.dart';
import 'package:heft/models/units.dart';
import 'package:heft/providers/preferences.dart';
import 'package:heft/providers/weight_records.dart';

// https://www.cdc.gov/healthyweight/assessing/bmi/adult_bmi/index.html
// fIXME: testing
class BmiCalculator {
  static Future<Bmi?> calculateBmi(final WeightRecords weightRecords) async {
    final prefs = await Preferences.load();
    final units = Preferences.fetchUnits(prefs);
    final ht = Preferences.fetchHeight(prefs);
    final wt = (await weightRecords.mostRecent)?.weight;

    return units != null && ht != null && wt != null
        ? calculate(units, ht, wt)
        : null;
  }

  static Bmi calculate(final Units units, final double ht, final double wt) {
    return units == Units.metric
        ? _calculateMetrics(ht, wt)
        : _calculateImperial(ht, wt);
  }

  static Bmi _calculateImperial(final double htIn, final double wtLb) {
    final value = (wtLb / pow(htIn, 2)) * 703;
    return Bmi(value, _categorize(value));
  }

  static Bmi _calculateMetrics(final double htCm, final double wtKg) {
    final value = wtKg / pow(htCm / 100, 2);
    return Bmi(value, _categorize(value));
  }

  static BmiCategory _categorize(final double value) {
    if (value < 18.5) {
      return BmiCategory.underweight;
    } else if (value < 25.0) {
      return BmiCategory.healthy;
    } else if (value < 30.0) {
      return BmiCategory.overweight;
    } else {
      return BmiCategory.obese;
    }
  }
}
