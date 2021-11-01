import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static const _unitsKey = 'user.units';
  static const _heightKey = 'user.height';

  static Future<SharedPreferences> load() async {
    return SharedPreferences.getInstance();
  }

  static void saveUnits(final Units units) {
    SharedPreferences.getInstance()
        .then((prefs) => prefs.setString(_unitsKey, units.value));
  }

  static Units? fetchUnits(final Object prefs) {
    return UnitsExt.of((prefs as SharedPreferences).getString(_unitsKey));
  }

  static void saveHeight(final double height) {
    SharedPreferences.getInstance()
        .then((prefs) => prefs.setDouble(_heightKey, height));
  }

  static double? fetchHeight(final Object prefs) {
    return (prefs as SharedPreferences).getDouble(_heightKey);
  }
}

enum Units {
  imperial,
  metric,
}

extension UnitsExt on Units {
  String get heightUnitAbbr {
    switch (this) {
      case Units.imperial:
        return 'in';
      case Units.metric:
        return 'cm';
    }
  }

  String get heightUnit {
    switch (this) {
      case Units.imperial:
        return 'inches';
      case Units.metric:
        return 'centimeters';
    }
  }

  String get weightUnitAbbr {
    switch (this) {
      case Units.imperial:
        return 'lb';
      case Units.metric:
        return 'kg';
    }
  }

  String get weightUnit {
    switch (this) {
      case Units.imperial:
        return 'pounds';
      case Units.metric:
        return 'kilograms';
    }
  }

  String get value {
    switch (this) {
      case Units.imperial:
        return 'imperial';
      case Units.metric:
        return 'metric';
    }
  }

  static Units? of(final String? value) {
    if (value != null) {
      return value == 'imperial' ? Units.imperial : Units.metric;
    }
    return null;
  }
}
