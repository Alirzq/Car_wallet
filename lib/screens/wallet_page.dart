import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/wallet_controller.dart';
import '../widgets/transaction_list.dart';

class WalletPage extends StatelessWidget {
  final WalletController walletController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dompet')),
      body: Column(
        children: [
          Obx(() => Text('Saldo: Rp${walletController.balance.value}')),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => _showTopUpDialog(),
                child: Text('Top Up'),
              ),
              ElevatedButton(
                onPressed: () => _showExpenseDialog(),
                child: Text('Pengeluaran'),
              ),
            ],
          ),
          Expanded(child: TransactionList()),
        ],
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