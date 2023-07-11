import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:our_wallet/app/data/colors.dart';
import 'package:our_wallet/app/data/constant.dart';
import 'package:our_wallet/app/data/typography.dart';
import 'package:our_wallet/app/data/widgets/loading_shimmer.dart';
import 'package:our_wallet/app/modules/home/controllers/home_controller.dart';
import 'package:our_wallet/app/modules/wallet/controllers/wallet_controller.dart';
import 'package:our_wallet/app/routes/app_pages.dart';

class WalletCardView extends GetView<HomeController> {
  const WalletCardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var walletC = Get.put(WalletController());
    return GetBuilder<HomeController>(builder: (context) {
      if (controller.isLoadingWallet) {
        return const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: LoadingShimmer(
            height: 100,
          ),
        );
      } else if (controller.isErrorWallet) {
        return Container(
          height: 100,
          width: Get.width - 32,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
              color: grey4, borderRadius: BorderRadius.circular(16)),
          child: Center(
            child: Text(
              controller.errorWallet,
              style: textRegular,
            ),
          ),
        );
      } else if (controller.list.isEmpty) {
        return GestureDetector(
          onTap: () =>
              Get.toNamed(Routes.ADD_WALLET, arguments: {'isUpdate': false})!
                  .then((_) {
            controller.getOurWallet();
            walletC.getOurWallet();
          }),
          child: Container(
            height: 100,
            width: Get.width - 32,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
                color: grey4, borderRadius: BorderRadius.circular(16)),
            child: const Center(
              child: Icon(Icons.add),
            ),
          ),
        );
      }
      return SizedBox(
        height: 100,
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return Stack(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  width: Get.width - 32,
                  height: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      "$jpgPath/card_${controller.list[index].walletColor}.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  left: 32,
                  top: 8,
                  bottom: 8,
                  child: Text(
                    controller.list[index].walletName ?? "",
                    style: textRegular,
                  ),
                ),
                Positioned(
                  right: 32,
                  bottom: 8,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      "$jpgPath/ow_logo_2.jpg",
                      width: 32,
                      height: 32,
                    ),
                  ),
                ),
                Positioned(
                  left: 32,
                  bottom: 8,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      "$pngPath/chip.png",
                      width: 32,
                      height: 32,
                    ),
                  ),
                ),
              ],
            );
          },
          onIndexChanged: (i) => controller.swap(i),
          physics: controller.list.length < 2
              ? const NeverScrollableScrollPhysics()
              : const ScrollPhysics(),
          itemCount: controller.list.length,
          itemWidth: Get.width,
          itemHeight: 100.0,
          layout: SwiperLayout.DEFAULT,
        ),
      );
    });
  }
}
