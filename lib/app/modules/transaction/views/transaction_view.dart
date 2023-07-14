import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:our_wallet/app/data/colors.dart';
import 'package:our_wallet/app/data/typography.dart';
import 'package:our_wallet/app/data/widgets/empty_screen.dart';
import 'package:our_wallet/app/data/widgets/loading_shimmer.dart';
import 'package:our_wallet/app/data/widgets/something_wrong.dart';
import 'package:our_wallet/app/routes/app_pages.dart';

import '../controllers/transaction_controller.dart';

class TransactionView extends GetView<TransactionController> {
  const TransactionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey4,
      appBar: AppBar(
        backgroundColor: grey4,
        elevation: 0,
        title: Text(
          'Riwayat',
          style: textBold.copyWith(color: primary),
        ),
        automaticallyImplyLeading: false,
      ),
      body: RefreshIndicator(
        onRefresh: () async => controller.getTransUser(),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: GetBuilder<TransactionController>(
            builder: (context) {
              if (controller.isLoading) {
                return ListView(
                  children: [1, 1, 1, 1, 1, 1, 1, 1, 1, 1].map<Widget>((e) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: const LoadingShimmer(height: 100),
                    );
                  }).toList(),
                );
              } else if (controller.isError) {
                return SomethingWrong(
                  onTap: () => controller.getTransUser(),
                );
              } else if (controller.list.isEmpty) {
                return const Center(
                  child: EmptyScreen(
                    message: "Anda belum memiliki transaksi",
                  ),
                );
              }
              return ListView(
                children: [
                  ...controller.list.map(
                    (ex) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(ex.name!, style: textBold),
                          const SizedBox(height: 8),
                          Column(
                            children: [
                              ...ex.riwayat!.map((e) {
                                return InkWell(
                                  onTap: () => Get.toNamed(
                                    Routes.DETAIL_TRANSACTION,
                                    arguments: {"data": e},
                                  ),
                                  child: Container(
                                    width: Get.width,
                                    margin: const EdgeInsets.only(bottom: 8),
                                    decoration: BoxDecoration(
                                      color: white,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: ListTile(
                                      title: Text(
                                        "${e.transWallet!.transWalletName}",
                                        style: textRegular,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      subtitle: Text(
                                        DateFormat('hh:mm a')
                                            .format(e.transDate!),
                                        style: textRegular.copyWith(
                                          color: grey,
                                        ),
                                      ),
                                      trailing: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            DateFormat('dd MMM yyyy')
                                                .format(e.transDate!),
                                            style: textRegular,
                                          ),
                                          const SizedBox(height: 4),
                                          e.transType == "Debit"
                                              ? Text(
                                                  '+ Rp ${controller.c.format(e.transPrice!)}',
                                                  style: textBold.copyWith(
                                                    color: success,
                                                  ),
                                                )
                                              : Text(
                                                  '- Rp ${controller.c.format(e.transPrice!)}',
                                                  style: textBold.copyWith(
                                                    color: warning,
                                                  ),
                                                ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ],
                          )
                        ],
                      );
                    },
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
