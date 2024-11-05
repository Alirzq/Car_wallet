import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/wallet_controller.dart';
import 'package:intl/intl.dart'; // Import for date formatting

class TransactionList extends StatelessWidget {
  final WalletController walletController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.separated(
        itemCount: walletController.transactions.length,
        separatorBuilder: (context, index) => SizedBox(height: 12), // Add vertical spacing
        itemBuilder: (context, index) {
          final transaction = walletController.transactions[index];
          final int id = transaction['id'];
          final double amount = (transaction['amount'] is num)
              ? (transaction['amount'] as num).toDouble()
              : 0.0;
          final bool isTopUp = transaction['isTopUp'] == 1;
          
          // Format date to only show date, no time
          String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.parse(transaction['date']));

          return Card(
            color: const Color.fromARGB(255, 224, 224, 224), // Set the card background to white
            elevation: 2, // Add some shadow
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Padding(
              padding: const EdgeInsets.all(12.0), // Add padding inside the card
              child: ListTile(
                contentPadding: EdgeInsets.zero, // Remove default ListTile padding
                leading: CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 255, 255, 255), // Set avatar background to white
                  child: Icon(
                    isTopUp ? Icons.add : Icons.remove,
                    color: isTopUp ? Colors.green : Colors.red,
                  ),
                ),
                title: Text(
                  transaction['label'],
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 4),
                    Text(
                      formattedDate, // Show only the date
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '${isTopUp ? '+' : '-'}Rp${amount.toStringAsFixed(2).replaceAllMapped(
                        RegExp(r'\B(?=(\d{3})+(?!\d))'),
                        (match) => ',')}',
                      style: TextStyle(
                        color: isTopUp ? Colors.green : Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                trailing: Obx(() {
                  bool isSaved = walletController.isItemSaved(amount, transaction['label']);
                  return ElevatedButton(
                    onPressed: () {
                      if (isSaved) {
                        walletController.removeSavedItem(id);
                      } else {
                        walletController.saveItem(amount, transaction['label']);
                      }
                    },
                    child: Text(isSaved ? 'Tersimpan' : 'Simpan', style: TextStyle(fontSize: 14)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isSaved ? Colors.grey : Colors.blue,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  );
                }),
              ),
            ),
          );
        },
      ),
    );
  }
}
