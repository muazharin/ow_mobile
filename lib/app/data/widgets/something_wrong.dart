import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:our_wallet/app/data/colors.dart';
import 'package:our_wallet/app/data/constant.dart';
import 'package:our_wallet/app/data/typography.dart';
import 'package:our_wallet/app/data/widgets/button_default.dart';

class SomethingWrong extends StatelessWidget {
  const SomethingWrong({super.key, required this.onTap});
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            "$lottiePath/error.json",
            width: Get.width * .5,
            height: Get.width * .5,
          ),
          const SizedBox(height: 10),
          Text(
            "Oops, terjadi kesalahan",
            style: textBold,
          ),
          const SizedBox(height: 8),
          Text(
            "Silahkan coba beberapa saat lagi",
            style: textRegular,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: ButtonDefault(
              text: "Coba Lagi",
              color: primary,
              onTap: onTap,
            ),
          ),
        ],
      ),
    );
  }
}
