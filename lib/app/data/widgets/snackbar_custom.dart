import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:our_wallet/app/data/colors.dart';
import 'package:our_wallet/app/data/typography.dart';

void snackbarSuccess({
  String? message,
  SnackPosition? snackPosition = SnackPosition.TOP,
}) {
  Get.rawSnackbar(
    backgroundColor: success,
    borderRadius: 12,
    shouldIconPulse: false,
    snackPosition: snackPosition!,
    padding: const EdgeInsets.symmetric(
      vertical: 9,
      horizontal: 12,
    ),
    margin: EdgeInsets.fromLTRB(
      36,
      snackPosition == SnackPosition.TOP ? 48 : 16,
      36,
      snackPosition == SnackPosition.TOP ? 16 : 48,
    ),
    messageText: Text(
      "$message",
      style: textRegular.copyWith(color: white),
    ),
    icon: Icon(
      Icons.check_circle_outline,
      color: white,
      size: 15,
    ),
  );
}

void snackbarWarning({
  String? message,
  SnackPosition? snackPosition = SnackPosition.TOP,
}) {
  Get.rawSnackbar(
    backgroundColor: warning,
    borderRadius: 12,
    shouldIconPulse: false,
    snackPosition: snackPosition!,
    padding: const EdgeInsets.symmetric(
      vertical: 9,
      horizontal: 12,
    ),
    margin: EdgeInsets.fromLTRB(
      36,
      snackPosition == SnackPosition.TOP ? 48 : 16,
      36,
      snackPosition == SnackPosition.BOTTOM ? 16 : 48,
    ),
    messageText: Text(
      "$message",
      style: textRegular.copyWith(color: white),
    ),
    icon: Icon(
      Icons.info_outline_rounded,
      color: white,
      size: 15,
    ),
  );
}

void snackbarDanger({
  String? message,
  SnackPosition? snackPosition = SnackPosition.TOP,
}) {
  Get.rawSnackbar(
    backgroundColor: danger,
    borderRadius: 12,
    shouldIconPulse: false,
    snackPosition: snackPosition!,
    padding: const EdgeInsets.symmetric(
      vertical: 9,
      horizontal: 12,
    ),
    margin: EdgeInsets.fromLTRB(
      36,
      snackPosition == SnackPosition.TOP ? 48 : 16,
      36,
      snackPosition == SnackPosition.BOTTOM ? 16 : 48,
    ),
    messageText: Text(
      "$message",
      style: textRegular.copyWith(color: white),
    ),
    icon: Icon(
      Icons.info_outline_rounded,
      color: white,
      size: 15,
    ),
  );
}
