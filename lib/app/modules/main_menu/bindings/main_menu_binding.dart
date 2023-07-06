import 'package:get/get.dart';
import 'package:our_wallet/app/modules/home/controllers/home_controller.dart';

import '../controllers/main_menu_controller.dart';

class MainMenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainMenuController>(
      () => MainMenuController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
