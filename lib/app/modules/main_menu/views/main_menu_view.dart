import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:our_wallet/app/data/colors.dart';
import 'package:our_wallet/app/data/typography.dart';
import 'package:our_wallet/app/modules/home/views/home_view.dart';

import '../controllers/main_menu_controller.dart';

class MainMenuView extends GetView<MainMenuController> {
  const MainMenuView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final screen = [
      const HomeView(),
      Container(color: grey),
      Container(color: grey),
      Container(color: grey),
    ];

    return Scaffold(
      backgroundColor: grey,
      body: GetBuilder<MainMenuController>(
        builder: (context) {
          return Container(
            color: white,
            child: IndexedStack(
              index: controller.page,
              children: screen,
            ),
          );
        },
      ),
      bottomNavigationBar: GetBuilder<MainMenuController>(
        builder: (context) {
          return CurvedNavigationBar(
            key: controller.bottomNavigationKey,
            color: white,
            backgroundColor: grey,
            buttonBackgroundColor: primary,
            animationDuration: const Duration(milliseconds: 350),
            height: 56,
            items: [
              Icon(
                Icons.home,
                size: 24,
                color: controller.page == 0 ? white : primary,
              ),
              Icon(
                Icons.history,
                size: 24,
                color: controller.page == 1 ? white : primary,
              ),
              Icon(
                Icons.article_outlined,
                size: 24,
                color: controller.page == 2 ? white : primary,
              ),
              Icon(
                Icons.person_outline_rounded,
                size: 24,
                color: controller.page == 3 ? white : primary,
              ),
            ],
            onTap: (index) => controller.changePage(index),
          );
        },
      ),
    );
  }
}
