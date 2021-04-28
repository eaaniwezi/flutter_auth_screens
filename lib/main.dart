import 'package:auth_screens/%D1%8D%D0%BA%D1%80%D0%B0%D0%BD%D1%8B/%D1%8D%D0%BA%D1%80%D0%B0%D0%BD_%D0%B2%D1%85%D0%BE%D0%B4%D0%B0.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginScreen(),
    );
  }
}
