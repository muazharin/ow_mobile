import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/auth_create_password_controller.dart';

class AuthCreatePasswordView extends GetView<AuthCreatePasswordController> {
  const AuthCreatePasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AuthCreatePasswordView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AuthCreatePasswordView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
