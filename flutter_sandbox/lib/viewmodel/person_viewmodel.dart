import 'package:flutter/material.dart';
import 'package:flutter_sandbox/models/person.dart';

class PersonViewmodel extends ChangeNotifier {
  var _result = '';
  String get result => _result;

  void calcularIMC(Person person) {
    final imc = person.calcularIMC();
    _result = 'IMC: ${imc.toStringAsFixed(2)}';
    notifyListeners();
  }
}


// Mudança
// Exposição
// Tratamento

