import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:our_wallet/app/data/constant.dart';
import 'package:our_wallet/app/data/services.dart';
import 'package:our_wallet/app/data/widgets/loading.dart';
import 'package:our_wallet/app/data/widgets/snackbar_custom.dart';
import 'package:our_wallet/app/routes/app_pages.dart';

class AuthCreatePasswordController extends GetxController {
  var key = GlobalKey<FormState>();
  var password = TextEditingController();
  var cPassword = TextEditingController();
  var isComplete = false;
  var box = GetStorage();
  var arg = Get.arguments;
  String? title = "Buat Password";

  @override
  void onInit() {
    if (arg['isRecreate']) {
      title = "Ubah Password";
    }
    super.onInit();
  }

  void onChange() {
    if (password.text.isEmpty || cPassword.text.isEmpty) {
      isComplete = false;
    } else {
      isComplete = true;
    }
    update();
  }

  void handleSubmit() async {
    if (key.currentState!.validate()) {
      Get.dialog(const Loading());
      try {
        final response = await APIService().putToken(
          onTap: () => handleSubmit(),
          path: authcreatepassword,
          data: {'password': password.text},
        );
        var result = jsonDecode(response.toString());
        print(result);
        if (result['status']) {
          box.remove('user_status');
          box.remove('is_login');
          box.remove('token');
          Get.back();
          Get.offAllNamed(Routes.AUTH_LOGIN);
          snackbarSuccess(message: "Berhasil! Silahkan login kembali");
        }
      } catch (e) {
        Get.back();
        snackbarDanger(message: "$e");
      }
    }
  }
}
