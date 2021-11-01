enum BmiCategory {
  underweight,
  healthy,
  overweight,
  obese,
}

extension BmiCategoryExt on BmiCategory {

  String get name {
    switch(this){
      case BmiCategory.underweight:
        return 'Underweight';
      case BmiCategory.healthy:
        return 'Healthy';
      case BmiCategory.overweight:
        return 'Overweight';
      case BmiCategory.obese:
        return 'Obese';
    }
  }
}

class Bmi {
  final double value;
  final BmiCategory category;

  const Bmi(this.value, this.category);
}
