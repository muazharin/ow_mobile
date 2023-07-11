import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:our_wallet/app/data/constant.dart';
import 'package:our_wallet/app/data/models/auth_model.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:our_wallet/app/data/services.dart';
import 'package:our_wallet/app/data/widgets/snackbar_custom.dart';
import 'package:our_wallet/app/modules/home/controllers/home_controller.dart';
import 'package:our_wallet/app/modules/profile/controllers/profile_controller.dart';

class PersonalDataController extends GetxController {
  var box = GetStorage();
  var authModel = AuthModel();
  var homeC = Get.put(HomeController());
  var profileC = Get.put(ProfileController());

  @override
  void onInit() {
    initializeDateFormatting();
    authModel = profileC.authModel;
    update();
    super.onInit();
  }

  void getImage(ImageSource source) async {
    Get.back();
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
    try {
      final response = await APIService().putFileToken(
        onTap: () => getImage(source),
        path: updatephotouser,
        data: FormData.fromMap({
          "user_id": authModel.userId,
          "user_photo": await MultipartFile.fromFile(image.path),
        }),
      );
      var result = jsonDecode(response.toString());
      if (result['status']) {
        homeC.getOurWallet();
        // getDataProfile();
        profileC.getDataProfile();
        authModel.userPhoto = result['path'];
        update();
        snackbarSuccess(message: "Foto berhasil diubah");
      } else {
        snackbarDanger(message: result['message']);
      }
    } catch (e) {
      snackbarDanger(message: "$e");
    }
  }
}
