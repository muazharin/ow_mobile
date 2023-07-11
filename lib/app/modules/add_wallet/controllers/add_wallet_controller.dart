import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:our_wallet/app/data/constant.dart';
import 'package:our_wallet/app/data/models/wallet_model.dart';
import 'package:our_wallet/app/data/services.dart';
import 'package:our_wallet/app/data/widgets/loading.dart';
import 'package:our_wallet/app/data/widgets/snackbar_custom.dart';
import 'package:our_wallet/app/modules/detail_wallet/controllers/detail_wallet_controller.dart';
import 'package:our_wallet/app/routes/app_pages.dart';

class AddWalletController extends GetxController {
  var list = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  var index = 0;
  var name = TextEditingController();
  var money = TextEditingController();
  var isComplete = false;
  var key = GlobalKey<FormState>();
  final c = NumberFormat("#,##0", "id_ID");
  var arg = Get.arguments;
  var data = WalletModel();
  String? title = "Tambah Wallet";
  String? titleButton = "Tambah";

  @override
  void onInit() {
    if (arg['isUpdate']) {
      data = arg['data'];
      title = "Ubah Wallet";
      titleButton = "Ubah";
      index = (int.parse(data.walletColor!) - 1);
      name.text = data.walletName!;
      money.text = c.format(data.walletMoney);
      isComplete = true;
    }
    update();
    super.onInit();
  }

  void swap(int i) {
    index = i;
    update();
  }

  void onChange() {
    if (name.text.isEmpty || money.text.isEmpty) {
      isComplete = false;
    } else {
      isComplete = true;
    }
    update();
  }

  void handleSubmit() async {
    if (arg['isUpdate']) {
      edit();
    } else {
      add();
    }
  }

  void add() async {
    if (key.currentState!.validate()) {
      Get.dialog(const Loading());
      try {
        final response = await APIService().postToken(
          onTap: () => handleSubmit(),
          path: createwallet,
          data: {
            "name": name.text,
            "money": int.parse(money.text.replaceAll(".", "")),
            "color": list[index].toString(),
          },
        );
        var result = jsonDecode(response.toString());
        print(result);
        if (result['status']) {
          Get.until((route) => Get.currentRoute == Routes.MAIN_MENU);
          snackbarSuccess(message: result['message']);
        }
      } catch (e) {
        Get.back();
        snackbarDanger(message: "$e");
      }
    }
  }

  void edit() async {
    if (key.currentState!.validate()) {
      Get.dialog(const Loading());
      try {
        final response = await APIService().putToken(
          onTap: () => handleSubmit(),
          path: updatewallet,
          data: {
            "name": name.text,
            "money": int.parse(money.text.replaceAll(".", "")),
            "color": list[index].toString(),
            "wallet_id": data.walletId
          },
        );
        var result = jsonDecode(response.toString());
        print(result);
        if (result['status']) {
          Get.until((route) => Get.currentRoute == Routes.MAIN_MENU);
          snackbarSuccess(message: result['message']);
        }
      } catch (e) {
        Get.back();
        snackbarDanger(message: "$e");
      }
    }
  }
}
