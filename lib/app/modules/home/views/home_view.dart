import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:our_wallet/app/data/colors.dart';
import 'package:our_wallet/app/data/constant.dart';
import 'package:our_wallet/app/data/typography.dart';
import 'package:our_wallet/app/data/utils.dart';
import 'package:our_wallet/app/data/widgets/icon_pad.dart';
import 'package:our_wallet/app/modules/home/views/member_card_view.dart';
import 'package:our_wallet/app/modules/home/views/trans_card_view.dart';
import 'package:our_wallet/app/modules/home/views/wallet_card_view.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey4,
      body: RefreshIndicator(
        onRefresh: () async => controller.onInit(),
        child: GetBuilder<HomeController>(
          builder: (context) {
            return SafeArea(
              child: Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: primary,
                          borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(64),
                          ),
                        ),
                        height: 300,
                        child: ListView(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Selamat ${controller.greeting},',
                                          style: textRegular.copyWith(
                                              color: white),
                                        ),
                                        Text(
                                          controller.authModel.userName != null
                                              ? nameFormat(controller
                                                  .authModel.userName!)
                                              : "",
                                          style: textBold.copyWith(
                                            color: white,
                                            fontSize: 16,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Icon(
                                    Icons.notifications_none_outlined,
                                    size: 24,
                                    color: white,
                                  ),
                                  const SizedBox(width: 8),
                                  CircleAvatar(
                                    radius: 18,
                                    backgroundColor: white,
                                    child: Image.asset(
                                      "$pngPath/ow_logo_1.png",
                                      width: 32,
                                      height: 32,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () => controller.show(),
                                    child: Icon(
                                      controller.isShow
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility_outlined,
                                      color: white,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    controller.isShow
                                        ? "Rp ${controller.list.isNotEmpty ? controller.c.format(controller.list[controller.index].walletMoney) : 0}"
                                        : "***",
                                    style: textBold.copyWith(
                                      color: white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const WalletCardView(),
                            const SizedBox(height: 10),
                            controller.list.length < 2
                                ? const SizedBox()
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: controller.list
                                        .asMap()
                                        .entries
                                        .map<Widget>((e) {
                                      return InkWell(
                                        child: Container(
                                          width: controller.index == e.key
                                              ? 24.0
                                              : 8.0,
                                          height: 8.0,
                                          margin: const EdgeInsets.symmetric(
                                            vertical: 8.0,
                                            horizontal: 2.0,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            shape: BoxShape.rectangle,
                                            color: controller.index == e.key
                                                ? white
                                                : grey4,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                      Expanded(
                        child: ListView(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Text("Anggota", style: textBold),
                            ),
                            const SizedBox(
                              height: 64,
                              child: MemberCardView(),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child:
                                  Text("Transaksi Terakhir", style: textBold),
                            ),
                            const TransCardView(),
                          ],
                        ),
                      ),
                    ],
                  ),
                  controller.list.isEmpty
                      ? const SizedBox()
                      : Container(
                          margin: const EdgeInsets.only(top: 268),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: controller.cardMenu.map<Widget>((e) {
                              return IconPad(
                                onTap: e['onTap'] == null
                                    ? null
                                    : () => e['onTap'](),
                                icon: Image.asset(
                                  "${e['icon']}",
                                  width: 24,
                                  height: 24,
                                  color: primary,
                                ),
                                text: "${e['name']}",
                              );
                            }).toList(),
                          ),
                        ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
