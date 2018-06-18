import 'package:flutter/material.dart';
import 'home_page.dart';

void main() => runApp(new GreenbookApp());

class GreenbookApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Greenbook',
      theme: new ThemeData(
        primarySwatch: Colors.green,
      ),
      home: new GreenbookHomePage(),
    );
  }
}


