import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:our_wallet/app/data/constant.dart';
import 'package:our_wallet/app/data/services.dart';
import 'package:our_wallet/app/data/widgets/loading.dart';
import 'package:our_wallet/app/data/widgets/snackbar_custom.dart';
import 'package:our_wallet/app/routes/app_pages.dart';

class AuthCheckPhoneNumberController extends GetxController {
  var key = GlobalKey<FormState>();
  var phone = TextEditingController();
  var isComplete = false;
  var box = GetStorage();

  void onChange() {
    if (phone.text.isEmpty) {
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
          path: authcheckphonenumber,
          data: {
            "phone": phone.text,
          },
        );
        var result = jsonDecode(response.toString());
        print(result);
        Get.back();
        if (result['status']) {
          Get.toNamed(Routes.AUTH_OTP, arguments: {"phone": phone.text});
        } else {
          if (result['data']['user_status'] == "incomplete") {
            Get.toNamed(
              Routes.AUTH_CREATE_PASSWORD,
              arguments: {
                'isRecreate': false,
                'data': result['data'],
              },
            );
          } else {
            snackbarDanger(message: result["message"]);
          }
        }
      } catch (e) {
        Get.back();
        snackbarDanger(message: "$e");
      }
    }
  }
}
