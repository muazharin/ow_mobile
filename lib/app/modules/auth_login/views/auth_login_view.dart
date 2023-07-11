import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:our_wallet/app/data/colors.dart';
import 'package:our_wallet/app/data/typography.dart';
import 'package:our_wallet/app/data/validators.dart';
import 'package:our_wallet/app/data/widgets/button_default.dart';
import 'package:our_wallet/app/data/widgets/input_password.dart';
import 'package:our_wallet/app/data/widgets/input_text.dart';
import 'package:our_wallet/app/data/widgets/svg_file.dart';
import 'package:our_wallet/app/routes/app_pages.dart';

import '../controllers/auth_login_controller.dart';

class AuthLoginView extends GetView<AuthLoginController> {
  const AuthLoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        title: Text(
          'Masuk',
          style: textBold,
        ),
        automaticallyImplyLeading: false,
      ),
      body: GetBuilder<AuthLoginController>(
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: controller.key,
              child: ListView(
                // mainAxisSize: MainAxisSize.max,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 32),
                  const SvgFile(filename: "login.svg"),
                  const SizedBox(height: 32),
                  InputText(
                    hintText: "Masukkan Username, Email atau No. Telp",
                    controller: controller.username,
                    validator: (v) =>
                        valString!(v, " Username, Email atau No. Telp"),
                    onChanged: (v) => controller.onChange(),
                  ),
                  const SizedBox(height: 8),
                  InputPassword(
                    hintText: "Masukkan Password",
                    controller: controller.password,
                    validator: (v) => valPassword!(v, "Password"),
                    onChanged: (v) => controller.onChange(),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(
                            Routes.AUTH_CHECK_PHONE_NUMBER,
                            arguments: {'isRecreate': true},
                          );
                        },
                        child: Text(
                          "Lupa Password?",
                          style: textBold.copyWith(color: black3),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ButtonDefault(
                    text: "Masuk",
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
                    const TextSpan(text: "Belum memiliki akun? "),
                    TextSpan(
                      text: "Daftar",
                      style: textBold.copyWith(color: primary),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Get.toNamed(
                            Routes.AUTH_CHECK_PHONE_NUMBER,
                            arguments: {'isRecreate': false},
                          );
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
