import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:our_wallet/app/data/colors.dart';
import 'package:our_wallet/app/data/typography.dart';
import 'package:our_wallet/app/data/validators.dart';
import 'package:our_wallet/app/data/widgets/button_default.dart';
import 'package:our_wallet/app/data/widgets/input_text.dart';
import 'package:our_wallet/app/data/widgets/svg_file.dart';

import '../controllers/auth_check_phone_number_controller.dart';

class AuthCheckPhoneNumberView extends GetView<AuthCheckPhoneNumberController> {
  const AuthCheckPhoneNumberView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        title: GetBuilder<AuthCheckPhoneNumberController>(
          builder: (context) {
            return Text(
              controller.title ?? "",
              style: textBold,
            );
          },
        ),
        automaticallyImplyLeading: false,
      ),
      body: GetBuilder<AuthCheckPhoneNumberController>(
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: controller.key,
              child: ListView(
                children: [
                  const SizedBox(height: 32),
                  SvgFile(filename: controller.filename ?? "register.svg"),
                  const SizedBox(height: 32),
                  InputText(
                    hintText: "Masukkan Nomor Telepon",
                    controller: controller.phone,
                    keyboardType: TextInputType.number,
                    onChanged: (v) => controller.onChange(),
                    validator: (v) => valPhone!(v, "Nomor Telepon"),
                  ),
                  const SizedBox(height: 16),
                  ButtonDefault(
                    text: "Kirim",
                    color: controller.isComplete ? primary : primaryLight,
                    onTap: controller.isComplete
                        ? () => controller.handleSubmit()
                        : () {},
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          );
        },
      ),
      bottomSheet: Container(
        color: white,
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: textRegular,
                  children: [
                    TextSpan(
                      text: controller.info ?? "Jika sudah memiliki akun? ",
                    ),
                    TextSpan(
                      text: "Masuk",
                      style: textBold.copyWith(color: primary),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Get.back();
                        },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
