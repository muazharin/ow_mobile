import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:our_wallet/app/data/colors.dart';
import 'package:our_wallet/app/data/typography.dart';
import 'package:our_wallet/app/data/validators.dart';
import 'package:our_wallet/app/data/widgets/button_default.dart';
import 'package:our_wallet/app/data/widgets/input_text.dart';
import 'package:our_wallet/app/data/widgets/svg_file.dart';

import '../controllers/add_category_controller.dart';

class AddCategoryView extends GetView<AddCategoryController> {
  const AddCategoryView({Key? key}) : super(key: key);
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
        automaticallyImplyLeading: false,
      ),
      body: GetBuilder<AddCategoryController>(
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: controller.key,
              child: ListView(
                children: [
                  const SvgFile(filename: 'category.svg'),
                  const SizedBox(height: 32),
                  InputText(
                    hintText:
                        "Masukkan ${controller.type == 'Kredit' ? 'Kategori' : 'Sumber Dana'}",
                    controller: controller.category,
                    onChanged: (v) => controller.onChange(),
                    validator: (v) => valString!(
                        v,
                        controller.type == 'Kredit'
                            ? 'Kategori'
                            : 'Sumber Dana'),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Rekomendasi:",
                    style: textRegular,
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    children: controller.list.asMap().entries.map<Widget>((e) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8, bottom: 8),
                        child: InkWell(
                          onTap: () => controller.setRec(e.value),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: controller.category.text.toLowerCase() ==
                                        e.value.toLowerCase()
                                    ? primary
                                    : grey,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                e.value,
                                style: textRegular.copyWith(
                                  color:
                                      controller.category.text.toLowerCase() ==
                                              e.value.toLowerCase()
                                          ? primary
                                          : black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                  ButtonDefault(
                    text: "Kirim",
                    color: controller.isComplete ? primary : primaryLight,
                    onTap: controller.isComplete
                        ? () => controller.handleSubmit()
                        : () {},
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
