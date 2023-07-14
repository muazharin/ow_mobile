import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:our_wallet/app/data/colors.dart';
import 'package:our_wallet/app/data/constant.dart';
import 'package:our_wallet/app/data/typography.dart';
import 'package:our_wallet/app/data/widgets/something_wrong.dart';

import '../controllers/detail_transaction_controller.dart';

class DetailTransactionView extends GetView<DetailTransactionController> {
  const DetailTransactionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey4,
      appBar: AppBar(
        backgroundColor: grey4,
        elevation: 0,
        title: Text(
          'Detail Transaksi',
          style: textBold.copyWith(color: primary),
        ),
        automaticallyImplyLeading: false,
      ),
      body: GetBuilder<DetailTransactionController>(
        builder: (context) {
          if (controller.isLoading) {
            return Center(child: CircularProgressIndicator(color: primary));
          } else if (controller.isError) {
            return SomethingWrong(
              onTap: () => controller.getDetailTrans(),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.detail.transType == "Kredit"
                                ? "Kategori:"
                                : "Sumber Dana:",
                            style: textBold,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            controller.detail.transCategory ?? "",
                            style: textRegular,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Detail:",
                            style: textBold,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            controller.detail.transDetail ?? "",
                            style: textRegular,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Nominal:",
                            style: textBold,
                          ),
                          const SizedBox(height: 4),
                          controller.detail.transType == "Kredit"
                              ? Text(
                                  "- Rp ${controller.c.format(controller.detail.transPrice)}",
                                  style: textRegular.copyWith(color: warning),
                                )
                              : Text(
                                  "+ Rp ${controller.c.format(controller.detail.transPrice)}",
                                  style:
                                      textRegular.copyWith(color: successDark),
                                ),
                          const SizedBox(height: 8),
                          Text(
                            "Tanggal Transaksi:",
                            style: textBold,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            DateFormat("EEEE, dd MMMM yyyy - HH:mm", "id_ID")
                                .format(controller.detail.transDate!),
                            style: textRegular,
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.horizontal(
                              left: Radius.circular(16),
                            ),
                            child: Image.asset(
                              "$jpgPath/card_${controller.detail.transWallet!.transWalletColor}.jpg",
                              height: 200,
                              width: Get.width,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            right: 16,
                            top: 16,
                            bottom: 8,
                            child: Text(
                              controller.detail.transWallet!.transWalletName!,
                              style: textRegular,
                            ),
                          ),
                          Positioned(
                            right: 16,
                            bottom: 16,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                "$jpgPath/ow_logo_2.jpg",
                                width: 32,
                                height: 32,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 16,
                            bottom: 16,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                "$pngPath/chip.png",
                                width: 32,
                                height: 32,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Text(
                  "Dilakukan Oleh:",
                  style: textBold,
                ),
                const SizedBox(height: 4),
                controller.detail.transUser == null
                    ? const SizedBox()
                    : ListTile(
                        contentPadding: const EdgeInsets.all(0),
                        leading: ClipOval(
                          child: Image.network(
                            controller.detail.transUser!.transUserPhoto!,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(
                          controller.detail.transUser!.transUserName!,
                          style: textRegular,
                        ),
                        subtitle: Text(
                          controller.detail.transUser!.transUserEmail!,
                          style: textRegular,
                        ),
                        trailing: InkWell(
                          onTap: () {},
                          child: Icon(
                            Icons.call_made_rounded,
                            color: primary,
                          ),
                        ),
                      ),
                const SizedBox(height: 8),
                Text(
                  "Bukti Transaksi:",
                  style: textBold,
                ),
                const SizedBox(height: 4),
                Wrap(
                  children: [
                    ...controller.detail.transFile!.map((e) {
                      return Container(
                        margin: const EdgeInsets.only(right: 8, bottom: 8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            e.transFileImage!,
                            height: 56,
                            width: 56,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    })
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
