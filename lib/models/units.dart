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