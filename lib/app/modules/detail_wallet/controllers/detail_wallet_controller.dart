import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:our_wallet/app/data/constant.dart';
import 'package:our_wallet/app/data/jwt.dart';
import 'package:our_wallet/app/data/models/auth_model.dart';
import 'package:our_wallet/app/data/models/member_model.dart';
import 'package:our_wallet/app/data/models/wallet_model.dart';
import 'package:our_wallet/app/data/services.dart';
import 'package:our_wallet/app/data/widgets/loading.dart';
import 'package:our_wallet/app/data/widgets/snackbar_custom.dart';
import 'package:our_wallet/app/modules/home/controllers/home_controller.dart';
import 'package:our_wallet/app/routes/app_pages.dart';

class DetailWalletController extends GetxController {
  var box = GetStorage();
  var arg = Get.arguments;
  var authModel = AuthModel();
  var walletModel = WalletModel();
  var c = NumberFormat("#,##0", "id_ID");
  var isLoadingMember = true;
  var isErrorMember = false;
  var errorMember = "";
  var listMember = <MemberModel>[];
  var homeC = Get.put(HomeController());

  @override
  void onInit() {
    initializeDateFormatting();
    walletModel = arg['data'];
    authModel = AuthModel.fromJson(parseJwt(box.read('token')));
    getMemberWallet();
    super.onInit();
  }

  getMemberWallet() async {
    isLoadingMember = true;
    isErrorMember = false;
    errorMember = "";
    update();
    try {
      final response = await APIService().getToken(
        onTap: () => getMemberWallet(),
        path: getmemberwallet,
        queryParameters: {
          "page": 1,
          "wallet_id": walletModel.walletId,
        },
      );
      var result = jsonDecode(response.toString());
      if (result['status']) {
        listMember = result['data']
            .map<MemberModel>((v) => MemberModel.fromJson(v))
            .toList();
      }
      update();
    } catch (e) {
      isErrorMember = true;
      errorMember = "$e";
      update();
    } finally {
      isLoadingMember = false;
      update();
    }
  }

  void getOurWallet() async {
    update();
    try {
      final response = await APIService().getToken(
        onTap: () => getOurWallet(),
        path: getourwallet,
        queryParameters: {"page": 1},
      );
      var result = jsonDecode(response.toString());
      if (result['status']) {
        walletModel = result['data']
            .map<WalletModel>((v) => WalletModel.fromJson(v))
            .toList();
      }
      update();
    } catch (e) {
      print(error);
    }
  }

  void handleDelete(walletId) async {
    Get.back();
    Get.dialog(const Loading());
    try {
      final response = await APIService().putToken(
        onTap: () => handleDelete(walletId),
        path: deletewallet,
        queryParameters: {"wallet_id": walletId},
        data: {},
      );
      var result = jsonDecode(response.toString());
      print(result);
      if (result['status']) {
        Get.back();
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
