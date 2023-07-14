import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:our_wallet/app/data/constant.dart';
import 'package:our_wallet/app/data/models/category_model.dart';
import 'package:our_wallet/app/data/models/wallet_model.dart';
import 'package:our_wallet/app/data/services.dart';
import 'package:our_wallet/app/data/widgets/loading.dart';
import 'package:our_wallet/app/data/widgets/snackbar_custom.dart';
import 'package:our_wallet/app/routes/app_pages.dart';

class AddCategoryController extends GetxController {
  var arg = Get.arguments;
  var wallet = WalletModel();
  var isUpdate = false;
  var type = "Kredit";
  var title = "Add Kategori";
  var key = GlobalKey<FormState>();
  var category = TextEditingController();
  var data = CategoryModel();
  var list = [];
  var isComplete = false;
  var kredit = [
    'Makanan',
    'Minuman',
    'Pakaian',
    'Jajan',
    'Tagihan',
    'BBM',
    'Skincare',
    'Foya-foya',
    'Lifestyle',
    'Lainnya',
  ];
  var debit = [
    'Gaji',
    'Project',
    'Saham',
    'Rekening',
    'Bisnis',
    'Dana tak terduga',
    'Pasangan',
    'Orang tua',
    'Rejeki Anak Sholeh(ah)',
    'Lainnya',
  ];

  @override
  void onInit() {
    wallet = arg['data'];
    type = arg['type'];
    title = arg['title'];
    isUpdate = arg['isUpdate'];
    list = debit;
    if (type == 'Kredit') {
      list = kredit;
    }
    if (isUpdate) {
      data = arg['category'];
      category.text = data.categoryTitle ?? "";
    }
    update();

    super.onInit();
  }

  void onChange() {
    if (category.text.isEmpty) {
      isComplete = false;
    } else {
      isComplete = true;
    }
    update();
  }

  void setRec(v) {
    category.text = v;
    onChange();
  }

  void handleSubmit() async {
    if (key.currentState!.validate()) {
      if (isUpdate) {
        handleUpdate();
      } else {
        Get.dialog(const Loading());
        try {
          final response = await APIService().postToken(
            onTap: () => handleSubmit(),
            path: createcategory,
            data: {
              "category_title": category.text,
              "category_type": type,
              "category_wallet_id": "${wallet.walletId}",
            },
          );
          var result = jsonDecode(response.toString());
          print(result);
          if (result['status']) {
            Get.until((route) => Get.currentRoute == Routes.CATEGORY);
            snackbarSuccess(message: result['message']);
          }
        } catch (e) {
          Get.back();
          snackbarDanger(message: "$e");
        }
      }
    }
  }

  void handleUpdate() async {
    if (key.currentState!.validate()) {
      Get.dialog(const Loading());
      try {
        final response = await APIService().putToken(
          onTap: () => handleUpdate(),
          path: updatecategory,
          data: {
            "category_id": data.categoryId,
            "category_title": category.text,
          },
        );
        var result = jsonDecode(response.toString());
        print(result);
        if (result['status']) {
          Get.until((route) => Get.currentRoute == Routes.CATEGORY);
          snackbarSuccess(message: result['message']);
        }
      } catch (e) {
        Get.back();
        snackbarDanger(message: "$e");
      }
    }
  }
}
