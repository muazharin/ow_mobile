import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:our_wallet/app/data/colors.dart';
import 'package:our_wallet/app/data/typography.dart';
import 'package:our_wallet/app/data/utils.dart';
import 'package:our_wallet/app/data/widgets/loading_shimmer.dart';
import 'package:our_wallet/app/modules/home/controllers/home_controller.dart';

class TransCardView extends GetView<HomeController> {
  const TransCardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (context) {
        if (controller.isLoadingTrans) {
          return Column(
            children: [1, 1, 1, 1, 1, 1, 1, 1].asMap().entries.map<Widget>((e) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: LoadingShimmer(
                  height: 64,
                  width: Get.width - 32,
                ),
              );
            }).toList(),
          );
        } else if (controller.isErrorTrans) {
          return Container(
            width: Get.width - 32,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Text(
                controller.errorTrans,
                style: textRegular,
              ),
            ),
          );
        } else if (controller.listTrans.isEmpty) {
          return Container(
            width: Get.width - 32,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Text(
                "Belum ada transaksi",
                style: textRegular,
              ),
            ),
          );
        }
        return Column(
          children: controller.listTrans.asMap().entries.map<Widget>((e) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Container(
                width: Get.width - 32,
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(48),
                    child: e.value.transUser == null
                        ? Image.network(
                            e.value.transUser!.transUserPhoto!,
                            height: 56,
                            width: 56,
                            fit: BoxFit.cover,
                          )
                        : Container(
                            height: 56,
                            width: 56,
                            color: grey4,
                            child: Icon(
                              Icons.person,
                              color: primary,
                            ),
                          ),
                  ),
                  title: e.value.transUser == null
                      ? Text(
                          "${e.value.transWallet!.transWalletName}",
                          style: textRegular,
                          overflow: TextOverflow.ellipsis,
                        )
                      : Text(
                          nameFormat(e.value.transUser!.transUserName!),
                          style: textRegular,
                          overflow: TextOverflow.ellipsis,
                        ),
                  subtitle: Text(
                    DateFormat('dd MMM yyyy').format(e.value.transDate!),
                    style: textRegular.copyWith(
                      color: grey,
                    ),
                  ),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat('HH:mm').format(e.value.transDate!),
                        style: textRegular,
                      ),
                      const SizedBox(height: 4),
                      e.value.transType == "Kredit"
                          ? Text(
                              '+ Rp ${controller.c.format(e.value.transPrice!)}',
                              style: textBold.copyWith(
                                color: success,
                              ),
                            )
                          : Text(
                              '- Rp ${controller.c.format(e.value.transPrice!)}',
                              style: textBold.copyWith(
                                color: warning,
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
