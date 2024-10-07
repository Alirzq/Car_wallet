import 'package:get/get.dart';
import '../controllers/wallet_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WalletController>(() => WalletController(), fenix: true);
  }
}