import 'dart:async';

import 'package:get/get.dart';
import 'package:our_wallet/app/routes/app_pages.dart';

class SplashScreenController extends GetxController {
  var isLoading = true;

  @override
  void onInit() {
    Timer(
      const Duration(milliseconds: 3000),
      () {
        isLoading = false;
        update();
        Get.offAllNamed(Routes.MAIN_MENU);
      },
    );
    super.onInit();
  }
}
