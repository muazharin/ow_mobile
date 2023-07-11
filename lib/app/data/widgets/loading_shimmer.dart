import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:our_wallet/app/data/colors.dart';
import 'package:shimmer/shimmer.dart';

class LoadingShimmer extends StatelessWidget {
  const LoadingShimmer({
    super.key,
    this.height,
    this.width,
  });
  final double? height;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: grey2,
      highlightColor: white,
      child: Container(
        height: height ?? 50,
        width: width ?? Get.width,
        decoration: BoxDecoration(
          color: grey4,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
