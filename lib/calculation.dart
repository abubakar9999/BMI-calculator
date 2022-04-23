import 'dart:math';
import 'package:flutter/material.dart';

class Calculation {
  int? age, weight;
  double? height;
  Calculation({this.age, this.height, this.weight});

  getResult() {
    final bmi = weight! / pow(height! / 100, 2);
    print("BMI is $bmi");
    return bmi;
  }
}
