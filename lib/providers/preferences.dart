import 'package:heft/models/units.dart';
import 'package:shared_preferences/shared_preferences.dart';

// fIXME: testing
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
