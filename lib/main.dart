import 'package:flutter/material.dart';
import 'package:flutter_intergration_test/login_screen.dart';

void main() {
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    ),
    home: LoginScreen(),
  ));
}
