import 'package:flutter/material.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:get/get.dart';

class CustomNavbar extends StatelessWidget {
  final RxInt currentIndex;
  final Function(int) onItemSelected;

  CustomNavbar({required this.currentIndex, required this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => FlashyTabBar(
        selectedIndex: currentIndex.value,
        showElevation: true,
        backgroundColor: Colors.black, // Mengubah warna navbar menjadi hitam
        onItemSelected: onItemSelected,
        items: [
          FlashyTabBarItem(
            icon: Icon(Icons.home, color: Colors.white),
            title: Text(
              'Home',
              style: TextStyle(
                fontWeight: FontWeight.bold, // Membuat font tebal
                color: Colors.white,
              ),
            ),
          ),
          FlashyTabBarItem(
            icon: Icon(Icons.account_balance_wallet, color: Colors.white),
            title: Text(
              'Wallet',
              style: TextStyle(
                fontWeight: FontWeight.bold, // Membuat font tebal
                color: Colors.white,
              ),
            ),
          ),
          FlashyTabBarItem(
            icon: Icon(Icons.person, color: Colors.white),
            title: Text(
              'Account',
              style: TextStyle(
                fontWeight: FontWeight.bold, // Membuat font tebal
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
