import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:our_wallet/app/data/colors.dart';
import 'package:our_wallet/app/data/constant.dart';
import 'package:our_wallet/app/data/jwt.dart';
import 'package:our_wallet/app/data/models/auth_model.dart';
import 'package:our_wallet/app/data/services.dart';
import 'package:our_wallet/app/data/typography.dart';
import 'package:our_wallet/app/data/widgets/button_default.dart';
import 'package:our_wallet/app/data/widgets/button_outlined.dart';
import 'package:our_wallet/app/routes/app_pages.dart';

class ProfileController extends GetxController {
  var box = GetStorage();
  var authModel = AuthModel();
  var isLoading = true;
  var isError = false;
  var error = '';

  @override
  void onInit() {
    getDataProfile();
    super.onInit();
  }

  void getDataProfile() async {
    isLoading = true;
    isError = false;
    error = '';
    update();
    try {
      final response = await APIService().getToken(
        onTap: () => getDataProfile(),
        path: getprofileuser,
      );
      var result = jsonDecode(response.toString());
      if (result['status']) {
        print(result['status']);
        authModel = AuthModel.fromJson(result['data']);
        update();
      }
    } catch (e) {
      isError = true;
      error = "$e";
      update();
    } finally {
      isLoading = false;
      update();
    }
  }

  void logout() {
    Get.defaultDialog(
      title: "Keluar",
      titleStyle: textBold.copyWith(fontSize: 16),
      middleText: "Anda yakin ingin keluar?",
      middleTextStyle: textRegular,
      confirm: ButtonDefault(
        text: "Ya",
        color: primary,
        onTap: () {
          box.remove('is_login');
          box.remove('user_status');
          box.remove('token');
          Get.offAllNamed(Routes.AUTH_LOGIN);
        },
      ),
      cancel: ButtonOutlined(
        text: "Tidak",
        onTap: () => Get.back(),
        borderColor: primary,
      ),
    );
  }
}
