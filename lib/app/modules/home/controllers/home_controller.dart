import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:our_wallet/app/data/constant.dart';
import 'package:our_wallet/app/data/jwt.dart';
import 'package:our_wallet/app/data/models/auth_model.dart';
import 'package:our_wallet/app/data/models/member_model.dart';
import 'package:our_wallet/app/data/models/trans_model.dart';
import 'package:our_wallet/app/data/models/wallet_model.dart';
import 'package:our_wallet/app/data/services.dart';

class HomeController extends GetxController {
  var authModel = AuthModel();
  var box = GetStorage();
  var isLoadingWallet = true;
  var isErrorWallet = false;
  var errorWallet = "";
  var isLoadingMember = true;
  var isErrorMember = false;
  var errorMember = "";
  var isLoadingTrans = true;
  var isErrorTrans = false;
  var errorTrans = "";
  var isShow = false;
  var greeting = '';
  var index = 0;
  var list = <WalletModel>[];
  var listMember = <MemberModel>[];
  var listTrans = <TransModel>[];
  var c = NumberFormat("#,##0", "id_ID");
  var cardMenu = [
    {
      "name": "Top Up",
      "icon": "$pngPath/topup.png",
      "route": "",
    },
    {
      "name": "Pay",
      "icon": "$pngPath/payment.png",
      "route": "",
    },
    {
      "name": "Chart",
      "icon": "$pngPath/barchart.png",
      "route": "",
    },
    {
      "name": "Invite",
      "icon": "$pngPath/invitation.png",
      "route": "",
    },
  ];

  @override
  void onInit() {
    authModel = AuthModel.fromJson(parseJwt(box.read('token')));
    greetingCheck();
    getOurWallet();
    super.onInit();
  }

  void greetingCheck() {
    var hour = DateTime.now().hour;
    if (hour <= 12) {
      greeting = 'Pagi';
    } else if ((hour > 12) && (hour <= 15)) {
      greeting = 'Siang';
    } else if ((hour > 15) && (hour < 20)) {
      greeting = 'Sore';
    } else {
      greeting = 'Malam';
    }
    update();
  }

  void show() {
    isShow = !isShow;
    update();
  }

  void swap(int i) {
    index = i;
    update();
    getMemberWallet();
    getTransWallet();
  }

  void getOurWallet() async {
    isLoadingWallet = true;
    isErrorWallet = false;
    errorWallet = "";
    isLoadingMember = true;
    isErrorMember = false;
    errorMember = "";
    isLoadingTrans = true;
    isErrorTrans = false;
    errorTrans = "";
    list = [];
    listMember = [];
    listTrans = [];
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
      isErrorWallet = true;
      errorWallet = unknown;
      isErrorMember = true;
      errorMember = unknown;
      isLoadingMember = false;
      isErrorTrans = true;
      errorTrans = unknown;
      isLoadingTrans = false;
      update();
    } finally {
      getMemberWallet();
      getTransWallet();
      isLoadingWallet = false;
      update();
    }
  }

  void getMemberWallet() async {
    if (list.isNotEmpty) {
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
            "wallet_id": list[index].walletId,
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
    } else {
      isLoadingMember = false;
      update();
    }
  }

  void getTransWallet() async {
    if (list.isNotEmpty) {
      isLoadingTrans = true;
      isErrorTrans = false;
      errorTrans = "";
      update();
      try {
        final response = await APIService().getToken(
          onTap: () => getTransWallet(),
          path: gettransactionwallet,
          queryParameters: {
            "page": 1,
            "wallet_id": list[index].walletId,
          },
        );
        var result = jsonDecode(response.toString());
        if (result['status']) {
          listTrans = result['data']
              .map<TransModel>((v) => TransModel.fromJson(v))
              .toList();
        }
        update();
      } catch (e) {
        isErrorTrans = true;
        errorTrans = "$e";
        update();
      } finally {
        isLoadingTrans = false;
        update();
      }
    } else {
      isLoadingTrans = false;
      update();
    }
  }
}
