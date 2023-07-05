import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:our_wallet/app/data/typography.dart';

import '../controllers/main_menu_controller.dart';

class MainMenuView extends GetView<MainMenuController> {
  const MainMenuView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Muazharin Alfan',
              style: textRegular.copyWith(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
