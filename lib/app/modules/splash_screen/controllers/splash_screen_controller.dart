import 'dart:async';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:our_wallet/app/routes/app_pages.dart';

class SplashScreenController extends GetxController {
  var box = GetStorage();
  @override
  void onInit() {
    Timer(
      const Duration(milliseconds: 3000),
      () => checkLogin(),
    );
    super.onInit();
  }

  void checkLogin() {
    // box.remove('is_login');
    bool isLogin = box.read('is_login') ?? false;
    String userStatus = box.read('user_status') ?? "";
    if (isLogin && userStatus == "complete") {
      Get.offAllNamed(Routes.MAIN_MENU);
    } else {
      Get.offAllNamed(Routes.AUTH_LOGIN);
    }
  }
}
