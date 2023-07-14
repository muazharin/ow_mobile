import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:our_wallet/app/data/colors.dart';

import 'package:our_wallet/app/data/typography.dart';
import 'package:our_wallet/app/data/widgets/list_personal_data.dart';
import 'package:our_wallet/app/data/widgets/option_bottom.dart';

import '../controllers/personal_data_controller.dart';

class PersonalDataView extends GetView<PersonalDataController> {
  const PersonalDataView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey4,
      appBar: AppBar(
        backgroundColor: grey4,
        elevation: 0,
        title: Text(
          'Data Diri',
          style: textBold.copyWith(color: primary),
        ),
        automaticallyImplyLeading: false,
      ),
      body: GetBuilder<PersonalDataController>(
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: [
                Center(
                  child: controller.authModel.userPhoto == null
                      ? Hero(
                          tag: "image",
                          child: CircleAvatar(
                            backgroundColor: white,
                            radius: 48,
                            child: Text(
                              "X",
                              style: textBold.copyWith(color: primary),
                            ),
                          ),
                        )
                      : Hero(
                          tag: "image",
                          child: Stack(
                            children: [
                              controller.authModel.userPhoto!.isNotEmpty
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(48),
                                      child: Image.network(
                                        controller.authModel.userPhoto!,
                                        width: 96,
                                        height: 96,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : CircleAvatar(
                                      backgroundColor: primary,
                                      radius: 48,
                                      child: Text(
                                        controller.authModel.userName![0]
                                            .toUpperCase(),
                                        style: textBold.copyWith(
                                            color: white, fontSize: 20),
                                      ),
                                    ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    Get.bottomSheet(
                                      OptionBottom(
                                        list: [
                                          {
                                            "name": "Kamera",
                                            "on_tap": () => controller
                                                .getImage(ImageSource.camera),
                                          },
                                          {
                                            "name": "Galeri",
                                            "on_tap": () => controller
                                                .getImage(ImageSource.gallery),
                                          },
                                        ],
                                      ),
                                    );
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: white,
                                    child: Icon(
                                      Icons.edit,
                                      color: primary,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                ),
                const SizedBox(height: 32),
                ListPersonalData(
                  name: "Username",
                  data: controller.authModel.userName,
                ),
                ListPersonalData(
                  name: "Email",
                  data: controller.authModel.userEmail,
                ),
                ListPersonalData(
                  name: "Nomor Telpon",
                  data: controller.authModel.userPhone,
                ),
                ListPersonalData(
                  name: "Jenis Kelamin",
                  data: controller.authModel.userGender,
                ),
                ListPersonalData(
                  name: "Tanggal Lahir",
                  data: controller.authModel.userTglLahir == null
                      ? ""
                      : DateFormat("dd MMMM yyyy", 'id_ID')
                          .format(controller.authModel.userTglLahir!),
                ),
                ListPersonalData(
                  name: "Alamat",
                  data: controller.authModel.userAddress,
                  isDivide: false,
                ),
              ],
            ),
          );
        },
      ),
      bottomSheet: GetBuilder<PersonalDataController>(
        builder: (context) {
          return Container(
            color: grey4,
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: textRegular.copyWith(color: grey, fontSize: 12),
                      children: [
                        // const TextSpan(text: "Bergabung dengan\n"),
                        TextSpan(
                          text: "Our Wallet\n",
                          style: textBold.copyWith(
                            fontSize: 20,
                            color: primary,
                          ),
                        ),
                        TextSpan(
                          text: controller.authModel.userCreatedAt == null
                              ? ""
                              : "Bergabung sejak ${DateFormat("dd MMMM yyyy", 'id_ID').format(controller.authModel.userCreatedAt!)} ",
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
