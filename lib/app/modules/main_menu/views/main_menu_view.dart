import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/main_menu_controller.dart';

class MainMenuView extends GetView<MainMenuController> {
  const MainMenuView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MainMenuView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'MainMenuView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
