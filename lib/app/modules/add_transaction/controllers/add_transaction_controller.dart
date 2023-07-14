import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:our_wallet/app/data/constant.dart';
import 'package:our_wallet/app/data/models/category_model.dart';
import 'package:our_wallet/app/data/models/wallet_model.dart';
import 'package:our_wallet/app/data/services.dart';
import 'package:our_wallet/app/data/widgets/loading.dart';
import 'package:our_wallet/app/data/widgets/snackbar_custom.dart';
import 'package:our_wallet/app/modules/home/controllers/home_controller.dart';
import 'package:our_wallet/app/modules/transaction/controllers/transaction_controller.dart';
import 'package:our_wallet/app/routes/app_pages.dart';

class AddTransactionController extends GetxController {
  var arg = Get.arguments;
  var wallet = WalletModel();
  var type = "Kredit";
  var title = "Top Up";
  var category = CategoryModel();
  var categoryName = TextEditingController();
  var detail = TextEditingController();
  var price = TextEditingController();
  var key = GlobalKey<FormState>();
  var isComplete = false;
  var files = <File>[];
  var transC = Get.put(TransactionController());
  var homeC = Get.put(HomeController());

  void onChange() {
    if (categoryName.text.isEmpty ||
        detail.text.isEmpty ||
        price.text.isEmpty) {
      isComplete = false;
    } else {
      isComplete = true;
    }
    update();
  }

  @override
  void onInit() {
    wallet = arg['data'];
    type = arg['type'];
    if (type == "Kredit") {
      title = "Belanja";
    } else {
      title = "Top Up";
    }
    update();
    super.onInit();
  }

  void setCategory(v) {
    if (v != null) {
      category = v;
      categoryName.text = v.categoryTitle ?? "";
      update();
    }
  }

  void setFile(List<File> v) {
    files = [];
    files.addAll(v);
    onChange();
  }

  void handleSubmit() async {
    if (key.currentState!.validate()) {
      Get.dialog(const Loading());
      var photos = [];
      for (var e in files) {
        photos.add(await MultipartFile.fromFile(e.path));
      }

      print({
        "trans_wallet_id": wallet.walletId,
        "trans_type": type,
        "trans_category_id": category.categoryId,
        "trans_detail": detail.text,
        "trans_price": int.parse(price.text.replaceAll(".", "")),
        "trans_file": photos
      });
      try {
        final response = await APIService().postFileToken(
          onTap: () => handleSubmit(),
          path: createtransaction,
          data: FormData.fromMap({
            "trans_wallet_id": wallet.walletId,
            "trans_type": type,
            "trans_category_id": category.categoryId,
            "trans_detail": detail.text,
            "trans_price": int.parse(price.text.replaceAll(".", "")),
            "trans_file": photos
          }),
        );
        var result = jsonDecode(response.toString());
        print(result);
        if (result['status']) {
          transC.getTransUser();
          homeC.getOurWallet();
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
