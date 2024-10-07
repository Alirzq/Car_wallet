import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/wallet_controller.dart';
import '../screens/welcome_page.dart';

class AccountPage extends StatelessWidget {
  final WalletController walletController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, 
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 40.0), 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      child: Icon(Icons.person, size: 50),
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Budiono Siregar',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'budionosiregar@gmail.com',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),

            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.grey.shade300,
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade400,
                    blurRadius: 6,
                    spreadRadius: 2,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Obx(() => Text(
                    'Saldo: Rp ${walletController.balance.value.toStringAsFixed(2).replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => ',')}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  )),
            ),
            SizedBox(height: 30, width: 200),
            ElevatedButton(
              onPressed: () {
                // Navigasi ke WelcomePage
                Get.offAll(() => WelcomePage());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 187, 109, 109),  // Warna background merah
                padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 16.0),  // Padding horizontal ditingkatkan untuk lebar tambahan
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),  // Border radius 10
                ),
                minimumSize: const Size(200, 50),  // Lebar minimum ditingkatkan menjadi 200
                elevation: 2,  // Memberikan efek bayangan
              ),
              child: const Text(
                'Logout',
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),  // Warna teks putih
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
