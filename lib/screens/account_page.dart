import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/wallet_controller.dart';

class AccountPage extends StatelessWidget {
  final WalletController walletController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 40.0),
          child: MediaQuery.of(context).size.width > 600
              ? Row(
                  // Tablet Layout
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Profile Card
                    Expanded(
                      flex: 2,
                      child: _buildProfileCard(),
                    ),
                    SizedBox(
                      width: 20,
                      height: 20,
                    ),
                    // Saved Items Section
                    Expanded(
                      flex: 3,
                      child: _buildSavedItems(),
                    ),
                  ],
                )
              : Column(
                  // Smartphone Layout
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Profile Card
                    _buildProfileCard(),
                    SizedBox(height: 30),
                    // Saved Items Section
                    _buildSavedItems(),
                  ],
                ),
        ),
      ),
    );
  }

// Profile Card Widget
  Widget _buildProfileCard() {
    return Card(
      color: Colors.white, // Ubah warna latar belakang menjadi putih
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.blueAccent,
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Budiono Siregar',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'budionosiregar@gmail.com',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Saved Items Widget
  Widget _buildSavedItems() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Item Tersimpan',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 1),
        Obx(
          () => ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: walletController.savedItems.length,
            itemBuilder: (context, index) {
              final item = walletController.savedItems[index];
              return Card(
                color: Colors.white,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: Icon(
                    Icons.save,
                    color: Colors.blue,
                    size: 30,
                  ),
                  title: Text(
                    item['label'],
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'Rp ${item['amount'].toStringAsFixed(2).replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => ',')}',
                    style: TextStyle(fontSize: 14),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () =>
                        _showDeleteConfirmation(context, item['id']),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // Delete Confirmation Dialog
  void _showDeleteConfirmation(BuildContext context, int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi'),
          content: Text('Apakah Anda yakin ingin menghapus item ini?'),
          actions: <Widget>[
            TextButton(
              child: Text('Tidak'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Ya'),
              onPressed: () {
                walletController.removeSavedItem(id);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
