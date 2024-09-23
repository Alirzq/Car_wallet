import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_page.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Selamat datang di E-Wallet App',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Aplikasi dompet digital untuk mengelola keuangan Anda',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => Get.off(() => HomePage()),
              child: Text('Mulai'),
            ),
          ],
        ),
      ),
    );
  }
}