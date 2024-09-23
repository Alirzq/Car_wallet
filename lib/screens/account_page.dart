import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/wallet_controller.dart';

class AccountPage extends StatelessWidget {
  final WalletController walletController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Akun'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              child: Icon(Icons.person, size: 50),
            ),
            SizedBox(height: 20),
            Text(
              'Nama Pengguna',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('user@email.com'),
            SizedBox(height: 20),
            Obx(() => Text(
                  'Saldo: Rp${walletController.balance.value.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implementasi fungsi logout di sini
                Get.snackbar('Logout', 'Anda telah keluar dari akun');
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}