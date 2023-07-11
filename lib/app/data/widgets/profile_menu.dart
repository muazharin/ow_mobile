import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:our_wallet/app/data/colors.dart';
import 'package:our_wallet/app/data/typography.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({super.key, required this.title, this.onTap});
  final String? title;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        onTap: onTap ??
            () {
              Get.defaultDialog(
                title: "Perhatian",
                titleStyle: textBold.copyWith(fontSize: 16),
                contentPadding: const EdgeInsets.all(16),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Lottie.asset(
                      "assets/lottie/development.json",
                      width: Get.width * .5,
                      height: Get.width * .5,
                      repeat: false,
                    ),
                    Text(
                      "Oops,",
                      style: textRegular,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "Masih dalam pengembangan",
                      style: textRegular,
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              );
            },
        title: Text(
          title!,
          style: textRegular,
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_rounded,
          color: black,
          size: 16,
        ),
      ),
    );
  }
}
