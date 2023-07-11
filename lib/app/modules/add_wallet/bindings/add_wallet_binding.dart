import 'package:get/get.dart';

import '../controllers/add_wallet_controller.dart';

class AddWalletBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddWalletController>(
      () => AddWalletController(),
    );
  }
}
