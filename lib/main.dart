import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screens/welcome_page.dart';
import 'controllers/wallet_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(WalletController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Car-Wallet App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WelcomePage(),
    );
  }
}
