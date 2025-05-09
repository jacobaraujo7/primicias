class Person {
  double height;
  double weight;

  Person({this.height = 0.0, this.weight = 0.0});

  double calcularIMC() {
    return height / (weight * weight);
  }

  void setHeight(String value) {
    height = double.tryParse(value) ?? 0.0;
  }

  void setWeight(String value) {
    weight = double.tryParse(value) ?? 0.0;
  }
}
