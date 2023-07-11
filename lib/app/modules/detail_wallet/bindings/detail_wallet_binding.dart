import 'package:get/get.dart';

import '../controllers/detail_wallet_controller.dart';

class DetailWalletBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailWalletController>(
      () => DetailWalletController(),
    );
  }
}
