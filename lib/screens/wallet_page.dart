import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/wallet_controller.dart';
import '../widgets/transaction_list.dart';

class WalletPage extends StatelessWidget {
  final WalletController walletController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Dompet',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Colors.black, // Warna teks AppBar
            ),
          ),
        ),
        backgroundColor: Colors.white, // Warna background AppBar
        elevation: 0, // Menghilangkan shadow bawah AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Color.fromARGB(117, 0, 0, 0),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 41, 41, 41).withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Obx(() => Text(
                        'Saldo: Rp${walletController.balance.value.toStringAsFixed(2).replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => ',')}',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                        textAlign: TextAlign.center,
                      )),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      // Tombol Top Up
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 0, 0, 0),
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            shadowColor: Colors.black.withOpacity(0.5),
                            elevation: 8,
                          ),
                          onPressed: () => _showTopUpDialog(),
                          child: Text('Top Up'),
                        ),
                      ),
                      SizedBox(width: 10),
                      // Tombol Pengeluaran
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 0, 0, 0),
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            shadowColor: Colors.black.withOpacity(0.5),
                            elevation: 8,
                          ),
                          onPressed: () => _showExpenseDialog(),
                          child: Text('Pengeluaran'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
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
