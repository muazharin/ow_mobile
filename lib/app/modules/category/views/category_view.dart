import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:our_wallet/app/data/colors.dart';
import 'package:our_wallet/app/data/typography.dart';
import 'package:our_wallet/app/data/widgets/empty_screen.dart';
import 'package:our_wallet/app/data/widgets/loading_shimmer.dart';
import 'package:our_wallet/app/data/widgets/option_bottom.dart';
import 'package:our_wallet/app/data/widgets/something_wrong.dart';
import 'package:our_wallet/app/routes/app_pages.dart';

import '../controllers/category_controller.dart';

class CategoryView extends GetView<CategoryController> {
  const CategoryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey4,
      appBar: AppBar(
        backgroundColor: grey4,
        elevation: 0,
        title: Text(
          controller.title,
          style: textBold.copyWith(color: primary),
        ),
        actions: [
          GestureDetector(
            onTap: () => Get.toNamed(
              Routes.ADD_CATEGORY,
              arguments: {
                'data': controller.wallet,
                'type': controller.type,
                'isUpdate': false,
                'title': "Tambah ${controller.title}"
              },
            )!
                .then((_) {
              controller.getCategory();
            }),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Icon(
                Icons.add,
                color: primary,
              ),
            ),
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GetBuilder<CategoryController>(
          builder: (context) {
            if (controller.isLoading) {
              return ListView(
                children: [1, 1, 1, 1, 1, 1, 1, 1, 1, 1].map<Widget>((e) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: const LoadingShimmer(height: 48),
                  );
                }).toList(),
              );
            } else if (controller.isError) {
              return SomethingWrong(
                onTap: () => controller.getCategory(),
              );
            } else if (controller.list.isEmpty) {
              return Center(
                child: EmptyScreen(
                  message:
                      "Anda belum memiliki ${controller.type == 'Kredit' ? 'sumber dana' : 'kategori'}",
                ),
              );
            }
            return ListView(
              children: [
                ...controller.list.asMap().entries.map((e) {
                  var data = e.value;
                  var index = e.key;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () => Get.back(result: data),
                                child: Text(
                                  data.categoryTitle ?? "",
                                  style: textRegular.copyWith(fontSize: 16),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () => Get.bottomSheet(
                                OptionBottom(
                                  list: [
                                    {
                                      "name": "Ubah",
                                      "on_tap": () {
                                        Get.back();
                                        Get.toNamed(
                                          Routes.ADD_CATEGORY,
                                          arguments: {
                                            'category': data,
                                            'isUpdate': true,
                                            'data': controller.wallet,
                                            'type': controller.type,
                                            'title': "Ubah ${controller.title}"
                                          },
                                        )!
                                            .then((_) =>
                                                controller.getCategory());
                                      },
                                    },
                                    {
                                      "name": "Hapus",
                                      "on_tap": () =>
                                          controller.handleDelete(data),
                                    },
                                  ],
                                ),
                              ),
                              child: Icon(
                                Icons.more_horiz_rounded,
                                color: primary,
                              ),
                            )
                          ],
                        ),
                        index != (controller.list.length - 1)
                            ? const Divider()
                            : const SizedBox(),
                      ],
                    ),
                  );
                })
              ],
            );
          },
        ),
      ),
    );
  }
}
