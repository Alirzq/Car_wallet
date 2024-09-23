import 'package:get/get.dart';

class WalletController extends GetxController {
  final RxDouble balance = 0.0.obs;
  final RxList<Map<String, dynamic>> transactions = <Map<String, dynamic>>[].obs;

  void topUp(double amount) {
    balance.value += amount;
    transactions.add({
      'amount': amount,
      'isTopUp': true,
      'label': 'Top Up',
      'date': DateTime.now(),
    });
  }

  void addExpense(double amount, String label) {
    if (balance.value >= amount) {
      balance.value -= amount;
      transactions.add({
        'amount': amount,
        'isTopUp': false,
        'label': label,
        'date': DateTime.now(),
      });
    } else {
      Get.snackbar('Error', 'Saldo tidak mencukupi');
    }
  }
}