import 'dart:async';

import 'package:flutter/material.dart';
import 'package:our_wallet/app/data/colors.dart';
import 'package:our_wallet/app/data/typography.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinCode extends StatelessWidget {
  const PinCode(
      {super.key,
      this.controller,
      this.onCompleted,
      this.errorAnimationController});
  final TextEditingController? controller;
  final void Function(String)? onCompleted;
  final StreamController<ErrorAnimationType>? errorAnimationController;
  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      pastedTextStyle: textBold,
      length: 6,
      blinkWhenObscuring: true,
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(5),
          fieldHeight: 48,
          fieldWidth: 48,
          // activeColor: isIncorectOtp ? primaryBlood : primaryWater,
          activeColor: info,
          inactiveColor: grey,
          activeFillColor: white,
          inactiveFillColor: white,
          selectedFillColor: white,
          errorBorderColor: primary,
          selectedColor: info),
      cursorColor: Colors.black,
      animationDuration: const Duration(milliseconds: 300),
      enableActiveFill: true,
      errorAnimationController: errorAnimationController,
      controller: controller,
      keyboardType: TextInputType.number,
      onCompleted: onCompleted,
      onChanged: (String value) {},
    );
  }
}
