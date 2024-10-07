import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screens/welcome_page.dart';
import 'binding/app_binding.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'E-Wallet App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WelcomePage(),
      initialBinding: AppBinding(),
    );
  }
}
