import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:our_wallet/app/data/colors.dart';
import 'package:our_wallet/app/data/typography.dart';
import 'package:our_wallet/app/data/validators.dart';
import 'package:our_wallet/app/data/widgets/button_default.dart';
import 'package:our_wallet/app/data/widgets/input_password.dart';
import 'package:our_wallet/app/data/widgets/svg_file.dart';

import '../controllers/auth_create_password_controller.dart';

class AuthCreatePasswordView extends GetView<AuthCreatePasswordController> {
  const AuthCreatePasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        title: GetBuilder<AuthCreatePasswordController>(
          builder: (context) {
            return Text(
              controller.title ?? 'Buat Password',
              style: textBold,
            );
          },
        ),
        automaticallyImplyLeading: false,
      ),
      body: GetBuilder<AuthCreatePasswordController>(
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: controller.key,
              child: ListView(
                children: [
                  const SizedBox(height: 32),
                  const SvgFile(filename: 'create.svg'),
                  const SizedBox(height: 32),
                  InputPassword(
                    hintText: "Masukkan Password",
                    controller: controller.password,
                    validator: (v) => valPassword!(v, "Password"),
                    onChanged: (v) => controller.onChange(),
                  ),
                  const SizedBox(height: 16),
                  InputPassword(
                    hintText: "Masukkan Konfirmasi Password",
                    controller: controller.cPassword,
                    validator: (v) => valCPassword!(
                      v,
                      "Konfirmasi Password",
                      controller.password.text,
                    ),
                    onChanged: (v) => controller.onChange(),
                  ),
                  const SizedBox(height: 16),
                  ButtonDefault(
                    text: "Kirim",
                    color: controller.isComplete ? primary : primaryLight,
                    onTap: controller.isComplete
                        ? () => controller.handleSubmit()
                        : () {},
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
