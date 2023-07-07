import 'package:get/get.dart';

import '../controllers/auth_check_phone_number_controller.dart';

class AuthCheckPhoneNumberBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthCheckPhoneNumberController>(
      () => AuthCheckPhoneNumberController(),
    );
  }
}
