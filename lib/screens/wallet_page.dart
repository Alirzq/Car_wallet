import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/wallet_controller.dart';
import '../widgets/transaction_list.dart';

class WalletPage extends StatelessWidget {
  final WalletController walletController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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

            GetBuilder<WalletController>(
              builder: (controller) {
                return Text(
                  'Rp ${controller.balance.value.toStringAsFixed(2).replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => ',')}',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                );
              },
            ),

            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _showTopUpDialog(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text('Top Up'),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _showExpenseDialog(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
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
            const SizedBox(height: 10),
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

            GetBuilder<WalletController>(
              builder: (controller) {
                return Expanded(child: TransactionList());
              },
            ),
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
            onPressed: () async {
              if (amountController.text.isNotEmpty) {
                double amount = double.parse(amountController.text);
                bool success = await walletController.topUp(amount);
                Get.back(); 
                if (success) {
                  _showCustomSnackbar(
                    'Top Up Berhasil',
                    'Saldo Anda bertambah Rp${amount.toStringAsFixed(2)}',
                    Colors.green,
                  );
                }
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
            onPressed: () async {
              if (amountController.text.isNotEmpty && labelController.text.isNotEmpty) {
                double amount = double.parse(amountController.text);
                String label = labelController.text;
                bool success = await walletController.addExpense(amount, label);
                Get.back();
                if (success) {
                  _showCustomSnackbar(
                    'Transaksi Berhasil',
                    'Pengeluaran Rp${amount.toStringAsFixed(2)} untuk $label',
                    Colors.blue,
                  );
                } else {
                  _showCustomSnackbar(
                    'Saldo Tidak Mencukupi',
                    'Maaf, saldo Anda tidak cukup untuk melakukan transaksi ini.',
                    Colors.red,
                  );
                }
              }
            },
            child: Text('Tambahkan'),
          ),
        ],
      ),
    );
  }

  void _showCustomSnackbar(String title, String message, Color color) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: color.withOpacity(0.7),
      colorText: Colors.white,
      duration: Duration(seconds: 3),
      margin: EdgeInsets.all(10),
      borderRadius: 10,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }

  void _showSaveItemDialog() {
    TextEditingController amountController = TextEditingController();
    TextEditingController labelController = TextEditingController();
    Get.dialog(
      AlertDialog(
        title: Text('Simpan Item'),
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
              if (amountController.text.isNotEmpty &&
                  labelController.text.isNotEmpty) {
                walletController.saveItem(
                  double.parse(amountController.text),
                  labelController.text,
                );
                Get.back();
              }
            },
            child: Text('Simpan'),
          ),
        ],
      ),
    );
  }
}
