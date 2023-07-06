import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:our_wallet/app/data/colors.dart';
import 'package:our_wallet/app/data/constant.dart';
import 'package:our_wallet/app/data/typography.dart';
import 'package:our_wallet/app/data/widgets/icon_pad.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey,
      body: GetBuilder<HomeController>(
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
                      child: Column(
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
                                        style:
                                            textRegular.copyWith(color: white),
                                      ),
                                      Text(
                                        'Muazharin Alfan',
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
                                    "$imgPng/ow_logo_1.png",
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
                                  controller.isShow ? "Rp 1.000.000" : "***",
                                  style: textBold.copyWith(
                                    color: white,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 100,
                            child: Swiper(
                              itemBuilder: (BuildContext context, int index) {
                                if (index == controller.list.length) {
                                  return Container(
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    decoration: BoxDecoration(
                                      color: grey,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    width: Get.width - 32,
                                    height: 100,
                                    child: Center(
                                      child: Icon(
                                        Icons.add,
                                        color: dark,
                                      ),
                                    ),
                                  );
                                }
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
                                          "$imgJpg/card_${index + 1}.jpg",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 32,
                                      top: 8,
                                      bottom: 8,
                                      child: Text(
                                        "Our Wallet",
                                        style: textRegular,
                                      ),
                                    ),
                                    Positioned(
                                      right: 32,
                                      bottom: 8,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.asset(
                                          "$imgJpg/ow_logo_2.jpg",
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
                                          "$imgPng/chip.png",
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
                              itemCount: controller.list.length + 1,
                              itemWidth: Get.width,
                              itemHeight: 100.0,
                              layout: SwiperLayout.DEFAULT,
                            ),
                          ),
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
                                              : grey,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 268),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: controller.cardMenu.map<Widget>((e) {
                      return IconPad(
                        icon: Image.asset(
                          "${e['icon']}",
                          width: 24,
                          height: 24,
                          color: primaryDark,
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
    );
  }
}
