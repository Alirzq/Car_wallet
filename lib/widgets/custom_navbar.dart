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
        backgroundColor: const Color.fromARGB(255, 255, 255, 255), 
        onItemSelected: onItemSelected,
        items: [
          FlashyTabBarItem(
            icon: Icon(Icons.home, color: const Color.fromARGB(255, 0, 0, 0), size: 30), 
            title: Text(
              'Home',
              style: TextStyle(
                fontWeight: FontWeight.bold, 
                color: const Color.fromARGB(255, 0, 0, 0),
              ),
            ),
          ),
          FlashyTabBarItem(
            icon: Icon(Icons.account_balance_wallet, color: Colors.black, size: 30), 
            title: Text(
              'Wallet',
              style: TextStyle(
                fontWeight: FontWeight.bold, // Membuat font tebal
                color: Colors.black,
              ),
            ),
          ),
          FlashyTabBarItem(
            icon: Icon(Icons.person, color: Colors.black, size: 30), // Memperbesar icon
            title: Text(
              'Account',
              style: TextStyle(
                fontWeight: FontWeight.bold, // Membuat font tebal
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
