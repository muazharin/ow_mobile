import 'dart:convert';

import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:our_wallet/app/data/constant.dart';
import 'package:our_wallet/app/data/models/trans_detail_model.dart';
import 'package:our_wallet/app/data/models/trans_model.dart';
import 'package:our_wallet/app/data/services.dart';

class DetailTransactionController extends GetxController {
  var arg = Get.arguments;
  var trans = TransModel();
  var detail = TransDetailModel();
  var isLoading = true;
  var isError = false;
  var error = "";
  var c = NumberFormat("#,##0", "id_ID");

  @override
  void onInit() {
    initializeDateFormatting();
    trans = arg['data'];
    update();
    getDetailTrans();

    super.onInit();
  }

  getDetailTrans() async {
    isLoading = true;
    isError = false;
    error = "";
    update();
    try {
      final response = await APIService().getToken(
        onTap: () => getDetailTrans(),
        path: detailtransaction,
        queryParameters: {
          "trans_id": trans.transId,
        },
      );
      var result = jsonDecode(response.toString());
      if (result['status']) {
        detail = TransDetailModel.fromJson(result['data']);
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
