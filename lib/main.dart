import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screens/welcome_page.dart';
import 'controllers/wallet_controller.dart';

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
      initialBinding: BindingsBuilder(() {
        Get.put(WalletController());
      }),
    );
  }
}
