import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:our_wallet/app/data/constant.dart';
import 'package:our_wallet/app/data/typography.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({super.key, required this.message});
  final String? message;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            "$lottiePath/not_found.json",
            width: Get.width * .5,
            height: Get.width * .5,
          ),
          const SizedBox(height: 10),
          Text(
            "Oops, tidak ada data",
            style: textBold,
          ),
          const SizedBox(height: 8),
          Text(
            "$message",
            style: textRegular,
          ),
        ],
      ),
    );
  }
}
