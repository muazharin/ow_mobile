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
  var arg = Get.arguments;
  String? title = 'Daftar';
  String? filename = 'register.svg';
  String? info = 'Jika sudah memiliki akun? ';

  @override
  void onInit() {
    if (arg['isRecreate']) {
      title = "Lupa Password";
      filename = "forgot.svg";
      info = "Tekan tombol kembali untuk ";
    }
    update();
    super.onInit();
  }

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
          if (arg['isRecreate']) {
            snackbarDanger(message: "Nomor Anda belum terdaftar");
          } else {
            Get.toNamed(Routes.AUTH_OTP, arguments: {
              "phone": phone.text,
              'isRecreate': arg['isRecreate'],
            });
          }
        } else {
          if (arg['isRecreate']) {
            box.write('token', result['data']['token']);
            Get.toNamed(Routes.AUTH_OTP, arguments: {
              "phone": phone.text,
              'isRecreate': arg['isRecreate'],
            });
          } else {
            snackbarDanger(message: result["message"]);
          }
          // if (result['data']['user_status'] == "incomplete") {
          //   Get.toNamed(
          //     Routes.AUTH_CREATE_PASSWORD,
          //     arguments: {'isRecreate': arg['isRecreate']},
          //   );
          // } else {
          //   if (arg['isRecreate']) {
          //     Get.toNamed(Routes.AUTH_OTP, arguments: {
          //       "phone": phone.text,
          //       'isRecreate': arg['isRecreate'],
          //     });
          //   } else {
          //     snackbarDanger(message: result["message"]);
          //   }
          // }
        }
      } catch (e) {
        Get.back();
        snackbarDanger(message: "$e");
      }
    }
  }
}
