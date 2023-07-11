import 'package:get/get.dart';
import 'package:our_wallet/app/modules/home/controllers/home_controller.dart';
import 'package:our_wallet/app/modules/profile/controllers/profile_controller.dart';
import 'package:our_wallet/app/modules/transaction/controllers/transaction_controller.dart';
import 'package:our_wallet/app/modules/wallet/controllers/wallet_controller.dart';

import '../controllers/main_menu_controller.dart';

class MainMenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainMenuController>(() => MainMenuController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<WalletController>(() => WalletController());
    Get.lazyPut<TransactionController>(() => TransactionController());
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}
