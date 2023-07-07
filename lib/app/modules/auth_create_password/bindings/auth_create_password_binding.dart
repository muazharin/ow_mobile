import 'package:get/get.dart';

import '../controllers/auth_create_password_controller.dart';

class AuthCreatePasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthCreatePasswordController>(
      () => AuthCreatePasswordController(),
    );
  }
}
