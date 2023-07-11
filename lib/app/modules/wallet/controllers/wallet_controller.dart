import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:our_wallet/app/data/constant.dart';
import 'package:our_wallet/app/data/models/wallet_model.dart';
import 'package:our_wallet/app/data/services.dart';
import 'package:our_wallet/app/modules/home/controllers/home_controller.dart';

class WalletController extends GetxController {
  var list = <WalletModel>[];
  var isLoading = true;
  var isError = false;
  var error = '';
  var c = NumberFormat("#,##0", "id_ID");
  var homeC = Get.put(HomeController());

  @override
  void onInit() {
    getOurWallet();
    super.onInit();
  }

  void getOurWallet() async {
    isLoading = true;
    isError = false;
    error = '';
    update();
    try {
      final response = await APIService().getToken(
        onTap: () => getOurWallet(),
        path: getourwallet,
        queryParameters: {"page": 1},
      );
      var result = jsonDecode(response.toString());
      if (result['status']) {
        list = result['data']
            .map<WalletModel>((v) => WalletModel.fromJson(v))
            .toList();
      }
      update();
    } catch (e) {
      isError = true;
      error = "$e";
      debugPrint(error);
      update();
    } finally {
      isLoading = false;
      update();
    }
  }
}
