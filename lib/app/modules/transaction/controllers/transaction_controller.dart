import 'dart:convert';
import "package:collection/collection.dart";
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:our_wallet/app/data/constant.dart';
import 'package:our_wallet/app/data/jwt.dart';
import 'package:our_wallet/app/data/models/auth_model.dart';
import 'package:our_wallet/app/data/models/trans_model.dart';
import 'package:our_wallet/app/data/services.dart';

class TransactionController extends GetxController {
  var isLoading = true;
  var isError = false;
  var error = "";
  var list = <GroupTrans>[];
  var box = GetStorage();
  var authModel = AuthModel();
  var c = NumberFormat("#,##0", "id_ID");

  @override
  void onInit() {
    authModel = AuthModel.fromJson(parseJwt(box.read('token')));
    update();
    getTransUser();
    super.onInit();
  }

  void getTransUser() async {
    isLoading = true;
    isError = false;
    error = "";
    list = [];
    update();
    try {
      final response = await APIService().getToken(
        onTap: () => getTransUser(),
        path: gettransactionuser,
        queryParameters: {
          "page": 1,
          "user_id": authModel.userId,
        },
      );
      var result = jsonDecode(response.toString());
      if (result['status']) {
        var data = result['data']
            .map<TransModel>((v) => TransModel.fromJson(v))
            .toList();
        groupBy(data, (TransModel transModel) {
          return DateFormat('dd MMM yyyy').format(transModel.transDate!);
        }).forEach((key, value) {
          list.add(GroupTrans(name: key, riwayat: value));
        });
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
}
