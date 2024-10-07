import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/wallet_controller.dart';
import '../widgets/transaction_list.dart';

class WalletPage extends StatelessWidget {
  final WalletController walletController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Ubah background menjadi putih
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset(
              'assets/porsche_1.png',
              width: 250,
              height: 250,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 30),
            RichText(
              text: const TextSpan(
                style: TextStyle(fontSize: 24, color: Colors.black),
                children: [
                  TextSpan(text: 'Saldo Anda: '),
                  TextSpan(
                    text: 'Rp ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Obx(() => Text(
              'Rp ${walletController.balance.value.toStringAsFixed(2).replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => ',')}',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            )),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _showTopUpDialog(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black, // Warna background hitam
                      foregroundColor: Colors.white, // Warna teks putih
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text('Top Up'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _showExpenseDialog(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black, // Warna background hitam
                      foregroundColor: Colors.white, // Warna teks putih
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text('Pengeluaran'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Transaksi Terakhir',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(child: TransactionList()),
          ],
        ),
      ),
    );
  }

  void _showTopUpDialog() {
    TextEditingController amountController = TextEditingController();
    Get.dialog(
      AlertDialog(
        title: Text('Top Up'),
        content: TextField(
          controller: amountController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(labelText: 'Jumlah'),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              if (amountController.text.isNotEmpty) {
                walletController.topUp(double.parse(amountController.text));
                Get.back();
              }
            },
            child: Text('Top Up'),
          ),
        ],
      ),
    );
  }

  void _showExpenseDialog() {
    TextEditingController amountController = TextEditingController();
    TextEditingController labelController = TextEditingController();
    Get.dialog(
      AlertDialog(
        title: Text('Pengeluaran'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Jumlah'),
            ),
            TextField(
              controller: labelController,
              decoration: InputDecoration(labelText: 'Label'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              if (amountController.text.isNotEmpty && labelController.text.isNotEmpty) {
                walletController.addExpense(double.parse(amountController.text), labelController.text);
                Get.back();
              }
            },
            child: Text('Tambah'),
          ),
        ],
      ),
    );
  }
}
