import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:our_wallet/app/data/constant.dart';
import 'package:our_wallet/app/data/services.dart';
import 'package:our_wallet/app/data/widgets/loading.dart';
import 'package:our_wallet/app/data/widgets/snackbar_custom.dart';
import 'package:our_wallet/app/routes/app_pages.dart';

class AuthRegisterController extends GetxController {
  var key = GlobalKey<FormState>();
  var username = TextEditingController();
  var email = TextEditingController();
  var phone = TextEditingController();
  var tglLahir = TextEditingController();
  var address = TextEditingController();
  var gender = Object();
  var isComplete = false;
  var arg = Get.arguments;
  var box = GetStorage();

  @override
  void onInit() {
    gender = "Pria";
    phone.text = arg['phone'];
    super.onInit();
  }

  void onChange() {
    if (username.text.isEmpty ||
        email.text.isEmpty ||
        phone.text.isEmpty ||
        tglLahir.text.isEmpty ||
        address.text.isEmpty) {
      isComplete = false;
    } else {
      isComplete = true;
    }
    update();
  }

  void setDate(DateTime date) {
    tglLahir.text = DateFormat("yyyy-MM-dd").format(date);
    update();
  }

  void setGender(Object v) {
    gender = v;
    update();
  }

  void handleSubmit() async {
    if (key.currentState!.validate()) {
      Get.dialog(const Loading());
      try {
        final response = await APIService().post(
          onTap: () => handleSubmit(),
          path: authregister,
          data: {
            'username': username.value.text,
            'email': email.value.text,
            'phone': phone.value.text,
            'gender': gender.toString(),
            'tgl_lahir': tglLahir.value.text,
            'address': address.value.text,
          },
        );
        var result = jsonDecode(response.toString());
        print(result);
        if (result['status']) {
          box.write('token', result['data']['token']);
          Get.back();
          Get.offNamed(
            Routes.AUTH_CREATE_PASSWORD,
            arguments: {'isRecreate': false},
          );
        }
      } catch (e) {
        Get.back();
        snackbarDanger(message: "$e");
      }
    }
  }
}
