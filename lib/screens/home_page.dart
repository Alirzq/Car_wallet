import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'wallet_page.dart';
import 'account_page.dart';
import '../controllers/wallet_controller.dart';
import '../widgets/car_slider.dart';
import '../widgets/custom_navbar.dart'; // Mengimpor CustomNavbar

class HomePage extends StatelessWidget {
  final RxInt _currentIndex = 0.obs;

  final List<Widget> _pages = [
    HomeContent(),
    WalletPage(),
    AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => _pages[_currentIndex.value]),
      bottomNavigationBar: CustomNavbar(
        currentIndex: _currentIndex,
        onItemSelected: (index) => _currentIndex.value = index,
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  final RxInt currentCarIndex = 0.obs;
  final WalletController walletController = Get.find<WalletController>();

  final List<Car> cars = [
    Car(
      name: 'Ferrari 812',
      year: '2020',
      image: 'assets/812.jpg',
      description:
          'Ferrari 812 Superfast memiliki mesin 6,5L V12 dengan tenaga 800 PS dan torsi 718 Nm. Pada 2018, ini adalah mesin naturally aspirated terkuat tanpa turbo atau hybrid. Model 2020 ke atas dilengkapi dengan filter emisi, sedangkan model sebelumnya tidak.',
    ),
    Car(
      name: 'Porsche 911 GT3 RS',
      year: '2019',
      image: 'assets/911GT3RS.jpg',
      description:
          'Porsche 911 GT3 RS adalah versi performa tinggi dari 911, dilengkapi mesin 4.0L naturally aspirated flat-six yang menghasilkan sekitar 520 PS (514 hp). Dirancang untuk trek balap, mobil ini memiliki aerodinamika canggih, sasis ringan, dan suspensi yang disesuaikan untuk handling maksimal. Cocok untuk penggemar performa tinggi, GT3 RS menawarkan pengalaman berkendara yang ekstrem dan presisi.',
    ),
    Car(
      name: 'Audi R8 v10',
      year: '2021',
      image: 'assets/AudiR8v10.jpg',
      description:
          'Audi R8 V10 dilengkapi mesin 5.2L V10 yang menghasilkan sekitar 610 PS (602 hp). Mobil ini menawarkan kombinasi performa tinggi, desain aerodinamis, dan teknologi canggih, memberikan pengalaman berkendara yang sporty dan mewah.',
    ),
    Car(
      name: 'Civic Type R',
      year: '2018',
      image: 'assets/Ek9.jpg',
      description:
          'Honda Civic Type R adalah hatchback sport yang dikenal dengan mesin 2.0L turbocharged inline-4, menghasilkan sekitar 306 PS (302 hp). Dengan pengaturan suspensi yang sporty dan aerodinamika yang ditingkatkan, Civic Type R menawarkan performa tinggi, handling responsif, dan desain agresif, menjadikannya salah satu mobil hot hatch terbaik.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center( 
                  child: Text(
                    'Home',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black, 
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Center( 
                  child: Text(
                    'My Car',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black, 
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                CarSlider(cars: cars, currentCarIndex: currentCarIndex),
                const SizedBox(height: 20),
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
                Obx(() => Column(
                  children: walletController.transactions
                      .take(5)
                      .map((transaction) {
                    return ListTile(
                      title: Text(
                        transaction['label'],
                        style: const TextStyle(
                          fontFamily: 'Roboto',
                          color: Colors.black, 
                          fontWeight: FontWeight.bold, 
                        ),
                      ),
                      trailing: Text(
                        '${transaction['isTopUp'] ? '+' : '-'} Rp ${transaction['amount'].toStringAsFixed(2)}',
                        style: TextStyle(
                          color: transaction['isTopUp'] ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }).toList(),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
