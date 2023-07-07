import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:our_wallet/app/data/colors.dart';
import 'package:our_wallet/app/data/typography.dart';
import 'package:our_wallet/app/data/widgets/pin_code.dart';
import 'package:our_wallet/app/data/widgets/svg_file.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../controllers/auth_otp_controller.dart';

class AuthOtpView extends GetView<AuthOtpController> {
  const AuthOtpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        title: Text(
          'OTP',
          style: textBold,
        ),
        automaticallyImplyLeading: false,
      ),
      body: GetBuilder<AuthOtpController>(
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: [
                const SizedBox(height: 32),
                const SvgFile(filename: 'otp.svg'),
                const SizedBox(height: 32),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: textRegular,
                    children: [
                      const TextSpan(
                          text: "Kode otp telah dikirimkan ke nomor "),
                      TextSpan(
                          text: "${controller.arg['phone']}", style: textBold),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                PinCode(
                  controller: controller.otp,
                  onCompleted: (v) => controller.handleVerify(v),
                  errorAnimationController: controller.errorController,
                ),
                const SizedBox(height: 8),
                Text(
                  '${controller.minutes}:${controller.second}',
                  style: textBold,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: controller.isTimeout
                      ? () => controller.handleSubmit(true)
                      : () {},
                  child: Text(
                    "Kirim Ulang",
                    style: textBold.copyWith(
                      color: controller.isTimeout ? black : black3,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
