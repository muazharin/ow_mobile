import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:our_wallet/app/data/utils.dart';
import 'package:our_wallet/app/data/widgets/loading.dart';
import 'package:our_wallet/app/data/widgets/snackbar_custom.dart';
import 'package:our_wallet/app/routes/app_pages.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class AuthOtpController extends GetxController {
  var arg = Get.arguments;
  var auth = FirebaseAuth.instance;
  var verificationsId = "";
  var otp = TextEditingController();
  var errorController = StreamController<ErrorAnimationType>();
  var debouncer = Debouncer(delay: const Duration(milliseconds: 100));
  Timer? countdownTimer;
  Duration myDuration = const Duration(minutes: 2);
  String strDigits(int n) => n.toString().padLeft(2, '0');
  var isTimeout = false;
  var minutes = "02";
  var second = "00";

  @override
  void onInit() {
    debouncer.call(() => handleSubmit(false));
    startTimer();
    super.onInit();
  }

  @override
  void onClose() {
    stopTimer();
    super.onClose();
  }

  void startTimer() {
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  void stopTimer() {
    countdownTimer!.cancel();
  }

  void resetTimer() {
    otp.text = "";
    myDuration = const Duration(minutes: 2);
    update();
  }

  void setCountDown() {
    var reduceSecondsBy = 1;
    var seconds = myDuration.inSeconds - reduceSecondsBy;
    if (seconds < 0) {
      isTimeout = true;
      update();
      stopTimer();
    } else {
      myDuration = Duration(seconds: seconds);
    }
    minutes = strDigits(myDuration.inMinutes.remainder(60));
    second = strDigits(myDuration.inSeconds.remainder(60));
    update();
  }

  void handleSubmit(bool isResend) async {
    if (isResend) {
      Get.dialog(const Loading());
    }
    await auth.verifyPhoneNumber(
      phoneNumber: phoneFormat(arg['phone']),
      verificationCompleted: (credential) async {
        try {
          await auth.signInWithCredential(credential);
        } catch (e) {
          Get.back();
          snackbarDanger(message: "$e");
        }
      },
      verificationFailed: (e) {
        Get.back();
        snackbarDanger(message: "$e");
      },
      codeSent: (verificationId, forceResendingToken) {
        verificationsId = verificationId;
        if (isResend) {
          Get.back();
          resetTimer();
          startTimer();
        }
      },
      codeAutoRetrievalTimeout: (verificationId) {
        verificationsId = verificationId;
      },
      timeout: Duration.zero,
    );
  }

  void handleVerify(String code) async {
    Get.dialog(const Loading());
    stopTimer();
    isTimeout = true;
    update();
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationsId,
      smsCode: code,
    );
    try {
      await auth.signInWithCredential(credential);
      Get.back();
      if (arg['isRecreate']) {
        Get.offNamed(
          Routes.AUTH_CREATE_PASSWORD,
          arguments: {'isRecreate': arg['isRecreate']},
        );
      } else {
        Get.offNamed(Routes.AUTH_REGISTER, arguments: {'phone': arg['phone']});
      }
    } catch (e) {
      Get.back();
      snackbarDanger(message: "$e");
    }
  }
}
