import 'dart:convert';

import 'package:get/get.dart';
import 'package:our_wallet/app/data/constant.dart';
import 'package:our_wallet/app/data/models/category_model.dart';
import 'package:our_wallet/app/data/models/wallet_model.dart';
import 'package:our_wallet/app/data/services.dart';
import 'package:our_wallet/app/data/widgets/loading.dart';
import 'package:our_wallet/app/data/widgets/snackbar_custom.dart';

class CategoryController extends GetxController {
  var arg = Get.arguments;
  var wallet = WalletModel();
  var type = "Kredit";
  var title = "Kategori";
  var list = <CategoryModel>[];
  var isLoading = true;
  var isError = false;
  var error = "";

  @override
  void onInit() {
    wallet = arg['data'];
    type = arg['type'];
    title = arg['title'];
    update();
    getCategory();
    super.onInit();
  }

  void getCategory() async {
    isLoading = true;
    isError = false;
    error = "";
    update();
    try {
      final response = await APIService().getToken(
        onTap: () => getCategory(),
        path: getcategory,
        queryParameters: {
          "page": 1,
          "type": type,
          "wallet_id": wallet.walletId,
        },
      );
      var result = jsonDecode(response.toString());
      print(result);
      if (result['status']) {
        list = result['data']
            .map<CategoryModel>((v) => CategoryModel.fromJson(v))
            .toList();
      }
      update();
    } catch (e) {
      isError = true;
      error = "$e";
      update();
    } finally {
      isLoading = false;
      update();
    }
  }

  void handleDelete(CategoryModel v) async {
    Get.back();
    Get.dialog(const Loading());
    try {
      final response = await APIService().putToken(
        onTap: () => handleDelete(v),
        path: deletecategory,
        queryParameters: {},
        data: {"category_id": v.categoryId},
      );
      var result = jsonDecode(response.toString());
      print(result);
      if (result['status']) {
        Get.back();
        getCategory();
        snackbarSuccess(message: result['message']);
      }
    } catch (e) {
      Get.back();
      snackbarDanger(message: "$e");
    }
  }
}
