import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:our_wallet/app/data/colors.dart';
import 'package:our_wallet/app/data/constant.dart';
import 'package:our_wallet/app/data/typography.dart';
import 'package:our_wallet/app/data/utils.dart';
import 'package:our_wallet/app/data/widgets/button_default.dart';
import 'package:our_wallet/app/data/widgets/button_outlined.dart';
import 'package:our_wallet/app/data/widgets/option_bottom.dart';
import 'package:our_wallet/app/routes/app_pages.dart';

import '../controllers/detail_wallet_controller.dart';

class DetailWalletView extends GetView<DetailWalletController> {
  const DetailWalletView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey4,
      appBar: AppBar(
        backgroundColor: grey4,
        elevation: 0,
        title: Text(
          'Detail Wallet',
          style: textBold.copyWith(color: primary),
        ),
        actions: [
          GestureDetector(
            onTap: () => Get.bottomSheet(OptionBottom(
              list: [
                {
                  "name": "Ubah",
                  "on_tap": () {
                    Get.back();
                    Get.toNamed(
                      Routes.ADD_WALLET,
                      arguments: {
                        'data': controller.walletModel,
                        'isUpdate': true,
                      },
                    );
                  },
                },
                {
                  "name": "Hapus",
                  "on_tap": () {
                    Get.back();
                    Get.defaultDialog(
                      title: "Hapus",
                      titleStyle: textBold.copyWith(fontSize: 16),
                      middleText: "Anda yakin ingin menghapus wallet ini?",
                      middleTextStyle: textRegular,
                      confirm: ButtonDefault(
                        text: "Ya",
                        color: primary,
                        onTap: () => controller.handleDelete(
                          controller.walletModel.walletId,
                        ),
                      ),
                      cancel: ButtonOutlined(
                        text: "Tidak",
                        onTap: () => Get.back(),
                        borderColor: primary,
                      ),
                    );
                  },
                },
              ],
            )),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Icon(
                Icons.more_vert_rounded,
                color: primary,
              ),
            ),
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: GetBuilder<DetailWalletController>(
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                style: textBold,
                                children: [
                                  TextSpan(
                                      text: controller.walletModel.walletName ??
                                          ""),
                                  const TextSpan(text: " - "),
                                  TextSpan(
                                    text: controller.walletModel.walletIsActive!
                                        ? 'Aktif'
                                        : 'Tidak Aktif',
                                    style: textRegular.copyWith(
                                        color: controller
                                                .walletModel.walletIsActive!
                                            ? successDark
                                            : primary),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              "Rp ${controller.c.format(controller.walletModel.walletMoney ?? '0')}",
                              style: textRegular,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 32),
                              child: Divider(
                                color: grey,
                              ),
                            ),
                            Text(
                              "Dibuat tanggal ${DateFormat('dd MMMM yyyy', 'id_ID').format(controller.walletModel.walletCreatedAt!)}",
                              style:
                                  textBold.copyWith(color: grey, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.horizontal(
                            left: Radius.circular(16),
                          ),
                          child: Image.asset(
                            "$jpgPath/card_${controller.walletModel.walletColor}.jpg",
                            height: 100,
                            width: Get.width,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Text("Anggota", style: textBold),
                const SizedBox(height: 16),
                Wrap(
                  children: controller.listMember.map<Widget>((e) {
                    return Column(
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(28),
                              child: Image.network(
                                e.userPhoto!,
                                width: 56,
                                height: 56,
                                fit: BoxFit.cover,
                              ),
                            ),
                            "${e.userId}" != "${controller.authModel.userId}"
                                ? Positioned(
                                    right: 0,
                                    top: 0,
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: CircleAvatar(
                                        backgroundColor: primary,
                                        radius: 10,
                                        child: Icon(
                                          Icons.clear_rounded,
                                          color: white,
                                          size: 10,
                                        ),
                                      ),
                                    ),
                                  )
                                : const SizedBox()
                          ],
                        ),
                        Text(
                          nameFormat("${e.userName}"),
                          style: textRegular,
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
