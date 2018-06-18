import 'package:flutter/material.dart';

class DoubleEditingController extends TextEditingController {
  double get doubleValue => double.parse(value.text);
}