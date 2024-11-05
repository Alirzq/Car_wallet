import 'package:get/get.dart';
import '../database/database_service.dart';
import 'package:flutter/material.dart';

class WalletController extends GetxController {
  var transactions = <Map<String, dynamic>>[].obs;
  var savedItems = <Map<String, dynamic>>[].obs;
  var balance = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    loadTransactions();
    loadSavedItems();
  }

  // Fungsi untuk mengambil transaksi dari database
  Future<void> loadTransactions() async {
    final dbTransactions = await DatabaseService.getTransactions();
    transactions.assignAll(dbTransactions);
    _calculateBalance();
  }

  // Hitung total saldo berdasarkan transaksi
  void _calculateBalance() {
    balance.value = transactions.fold(0.0, (total, transaction) {
      final amount = transaction['amount'] as double;
      final isTopUp = transaction['isTopUp'] == 1;
      return total + (isTopUp ? amount : -amount);
    });
  }

  Future<bool> topUp(double amount) async {
    await DatabaseService.addTransaction(amount, 'Top Up', true);
    await loadTransactions();
    return true;
  }

  Future<bool> addExpense(double amount, String label) async {
    if (balance.value >= amount) {
      await DatabaseService.addTransaction(amount, label, false);
      await loadTransactions();
      return true;
    }
    return false;
  }

  Future<void> removeTransaction(int id) async {
    await DatabaseService.removeTransaction(id);
    loadTransactions(); 
  }

  Future<void> loadSavedItems() async {
    final dbSavedItems = await DatabaseService.getSavedItems();
    savedItems.assignAll(dbSavedItems);
  }


  Future<void> saveItem(double amount, String label) async {
    await DatabaseService.saveItem(amount, label);
    await loadSavedItems();
    update(); // Memicu pembaruan UI
  }


  Future<void> removeSavedItem(int id) async {
    await DatabaseService.removeSavedItem(id);
    await loadSavedItems();
    update(); // Memicu pembaruan UI
  }

  bool isItemSaved(double amount, String label) {
    return savedItems.any((item) => 
      item['amount'] == amount && item['label'] == label
    );
  }
}
