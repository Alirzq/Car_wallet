import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/wallet_controller.dart';

class TransactionList extends StatelessWidget {
  final WalletController walletController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
        itemCount: walletController.transactions.length,
        itemBuilder: (context, index) {
          final transaction = walletController.transactions[index];
          return ListTile(
            leading: Icon(
              transaction['isTopUp'] ? Icons.add_circle : Icons.remove_circle,
              color: transaction['isTopUp'] ? Colors.green : Colors.red,
            ),
            title: Text(transaction['label']),
            subtitle: Text(transaction['date'].toString().substring(0, 16)),
            trailing: Text(
              '${transaction['isTopUp'] ? '+' : '-'}Rp${transaction['amount'].toStringAsFixed(2).replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => ',')}',
              style: TextStyle(
                color: transaction['isTopUp'] ? Colors.green : Colors.red,
              ),
            ),
          );
        },
      ),
    );
  }
}