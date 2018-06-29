import 'package:flutter/material.dart';

class DoubleEditingController extends TextEditingController {
  double get doubleValue => parseToDouble(value.text);
}

double parseToDouble(String text) {
  return double.parse(text.replaceAll(",", "."));
}