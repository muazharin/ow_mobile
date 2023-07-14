import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:our_wallet/app/data/colors.dart';
import 'package:our_wallet/app/data/models/category_model.dart';
import 'package:our_wallet/app/data/typography.dart';
import 'package:our_wallet/app/data/validators.dart';
import 'package:our_wallet/app/data/widgets/button_default.dart';
import 'package:our_wallet/app/data/widgets/input_select.dart';
import 'package:our_wallet/app/data/widgets/input_text.dart';
import 'package:our_wallet/app/data/widgets/select_image.dart';
import 'package:our_wallet/app/data/widgets/svg_file.dart';
import 'package:our_wallet/app/routes/app_pages.dart';

import '../controllers/add_transaction_controller.dart';

class AddTransactionView extends GetView<AddTransactionController> {
  const AddTransactionView({Key? key}) : super(key: key);
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
      body: GetBuilder<AddTransactionController>(
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: controller.key,
              child: ListView(
                children: [
                  const SizedBox(height: 32),
                  SvgFile(filename: "${controller.type.toLowerCase()}.svg"),
                  const SizedBox(height: 32),
                  InputSelect(
                    hintText: controller.type == "Debit"
                        ? "Pilih Sumber Dana"
                        : "Pilih Kategori",
                    controller: controller.categoryName,
                    onTap: () => Get.toNamed(
                      Routes.CATEGORY,
                      arguments: {
                        "data": controller.wallet,
                        "type": controller.type,
                        "title": controller.type == "Debit"
                            ? "Sumber Dana"
                            : "Kategori",
                      },
                    )!
                        .then((v) => controller.setCategory(v)),
                    onChanged: (v) => controller.onChange(),
                    validator: (v) => valString!(
                      v,
                      controller.type == 'Debit' ? 'Sumber Dana' : 'Kategori',
                    ),
                  ),
                  const SizedBox(height: 8),
                  InputText(
                    hintText: "Masukkan Nominal",
                    controller: controller.price,
                    keyboardType: TextInputType.number,
                    onChanged: (v) => controller.onChange(),
                    validator: (v) => valString!(v, "Nominal"),
                    inputFormatters: [
                      CurrencyTextInputFormatter(
                        name: "",
                        locale: "ID",
                        decimalDigits: 0,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  SelectImage(files: (v) => controller.setFile(v)),
                  const SizedBox(height: 8),
                  InputText(
                    hintText: "Masukkan Keterangan",
                    controller: controller.detail,
                    onChanged: (v) => controller.onChange(),
                    validator: (v) => valString!(v, "Keterangan"),
                    minLines: 4,
                    maxLines: 4,
                  ),
                  const SizedBox(height: 16),
                  ButtonDefault(
                    text: "Kirim",
                    color: controller.isComplete ? primary : primaryLight,
                    onTap: controller.isComplete
                        ? () => controller.handleSubmit()
                        : () {},
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
