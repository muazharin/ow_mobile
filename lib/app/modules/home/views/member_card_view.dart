import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:our_wallet/app/data/colors.dart';
import 'package:our_wallet/app/data/typography.dart';
import 'package:our_wallet/app/data/widgets/loading_shimmer.dart';
import 'package:our_wallet/app/modules/home/controllers/home_controller.dart';

class MemberCardView extends GetView<HomeController> {
  const MemberCardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (context) {
        if (controller.isLoadingMember) {
          return ListView(
            scrollDirection: Axis.horizontal,
            children: [1, 1, 1, 1, 1, 1, 1, 1].asMap().entries.map<Widget>((e) {
              return Padding(
                padding: EdgeInsets.only(
                  right: e.key == 7 ? 16 : 8,
                  left: e.key == 0 ? 16 : 0,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(48),
                  child: const LoadingShimmer(height: 64, width: 64),
                ),
              );
            }).toList(),
          );
        } else if (controller.isErrorMember) {
          return Container(
            width: Get.width - 32,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Text(
                controller.errorMember,
                style: textRegular,
              ),
            ),
          );
        } else if (controller.listMember.isEmpty) {
          return Container(
            width: Get.width - 32,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Text(
                "Belum ada anggota",
                style: textRegular,
              ),
            ),
          );
        }
        return ListView(
          scrollDirection: Axis.horizontal,
          children: [
            ...controller.listMember.asMap().entries.map<Widget>((e) {
              return Padding(
                padding: EdgeInsets.only(
                  right: e.key == (controller.listMember.length - 1) ? 16 : 8,
                  left: e.key == 0 ? 16 : 0,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(48),
                  child: e.value.userPhoto!.isNotEmpty
                      ? Image.network(
                          e.value.userPhoto!,
                          height: 64,
                          width: 64,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          height: 64,
                          width: 64,
                          color: white,
                          child: Center(
                            child: Text(
                              e.value.userName![0].toUpperCase(),
                              style: textBold.copyWith(
                                color: primary,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                ),
              );
            }),
          ],
        );
      },
    );
  }
}
