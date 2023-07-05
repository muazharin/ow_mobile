import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:our_wallet/app/data/colors.dart';
import 'package:our_wallet/app/data/constant.dart';
import 'package:shimmer/shimmer.dart';

import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: GetBuilder<SplashScreenController>(
        builder: (context) {
          return Center(
            child: Shimmer.fromColors(
              baseColor: Colors.grey[400]!,
              highlightColor: white,
              period: const Duration(seconds: 3),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  "$imgPath/ow_logo_6.png",
                  width: 200,
                  height: 200,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
