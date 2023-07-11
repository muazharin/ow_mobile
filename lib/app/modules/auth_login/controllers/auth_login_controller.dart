import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:our_wallet/app/data/constant.dart';
import 'package:our_wallet/app/data/services.dart';
import 'package:our_wallet/app/data/widgets/loading.dart';
import 'package:our_wallet/app/data/widgets/snackbar_custom.dart';
import 'package:our_wallet/app/routes/app_pages.dart';

class AuthLoginController extends GetxController {
  var key = GlobalKey<FormState>();
  var username = TextEditingController();
  var password = TextEditingController();
  var box = GetStorage();
  var isComplete = false;

  void onChange() {
    if (username.text.isEmpty || password.text.isEmpty) {
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
        final response = await APIService().post(
          onTap: () => handleSubmit(),
          path: authlogin,
          data: {
            "username": username.text,
            "password": password.text,
          },
        );
        var result = jsonDecode(response.toString());
        print(result);
        if (result['status']) {
          if (result['data']['user_status'] == "incomplete") {
            box.write("token", result['data']['token']);
            Get.back();
            Get.toNamed(
              Routes.AUTH_CREATE_PASSWORD,
              arguments: {'isRecreate': false},
            );
          } else {
            box.write("token", result['data']['token']);
            box.write("is_login", true);
            box.write("user_status", result['data']['user_status']);
            Get.offAllNamed(Routes.MAIN_MENU);
          }
        }
      } catch (e) {
        Get.back();
        snackbarDanger(message: "$e");
      }
    }
  }
}
