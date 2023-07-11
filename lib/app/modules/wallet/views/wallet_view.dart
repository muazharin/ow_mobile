import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:our_wallet/app/data/colors.dart';
import 'package:our_wallet/app/data/constant.dart';
import 'package:our_wallet/app/data/typography.dart';
import 'package:our_wallet/app/data/widgets/button_default.dart';
import 'package:our_wallet/app/data/widgets/button_outlined.dart';
import 'package:our_wallet/app/data/widgets/empty_screen.dart';
import 'package:our_wallet/app/data/widgets/loading_shimmer.dart';
import 'package:our_wallet/app/data/widgets/option_bottom.dart';
import 'package:our_wallet/app/data/widgets/something_wrong.dart';
import 'package:our_wallet/app/modules/home/controllers/home_controller.dart';
import 'package:our_wallet/app/routes/app_pages.dart';

import '../controllers/wallet_controller.dart';

class WalletView extends GetView<WalletController> {
  const WalletView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey4,
      appBar: AppBar(
        backgroundColor: grey4,
        elevation: 0,
        title: Text(
          'Wallet',
          style: textBold.copyWith(color: primary),
        ),
        actions: [
          GestureDetector(
            onTap: () => Get.toNamed(
              Routes.ADD_WALLET,
              arguments: {
                'isUpdate': false,
              },
            )!
                .then((_) {
              controller.getOurWallet();
              controller.homeC.getOurWallet();
            }),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Icon(
                Icons.add_card_outlined,
                color: primary,
              ),
            ),
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: RefreshIndicator(
        onRefresh: () async => controller.getOurWallet(),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: GetBuilder<WalletController>(
            builder: (context) {
              if (controller.isLoading) {
                return ListView(
                  children: [1, 1, 1, 1, 1, 1, 1, 1, 1, 1].map<Widget>((e) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: const LoadingShimmer(height: 100),
                    );
                  }).toList(),
                );
              } else if (controller.isError) {
                return SomethingWrong(
                  onTap: () => controller.getOurWallet(),
                );
              } else if (controller.list.isEmpty) {
                return const Center(
                  child: EmptyScreen(
                    message: "Anda belum memiliki wallet",
                  ),
                );
              }
              return ListView(
                children: controller.list.map<Widget>((e) {
                  return GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.DETAIL_WALLET, arguments: {'data': e})!
                          .then((value) => controller.getOurWallet());
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              "$jpgPath/card_${e.walletColor}.jpg",
                              height: 100,
                              width: Get.width,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            left: 8,
                            top: 8,
                            bottom: 8,
                            child: Text(
                              e.walletName ?? "",
                              style: textRegular,
                            ),
                          ),
                          Positioned(
                            right: 8,
                            top: 8,
                            bottom: 8,
                            child: Text(
                              "Rp ${controller.c.format(e.walletMoney)}",
                              style: textRegular,
                            ),
                          ),
                          Positioned(
                            right: 8,
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
                            left: 8,
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
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ),
      ),
    );
  }
}
