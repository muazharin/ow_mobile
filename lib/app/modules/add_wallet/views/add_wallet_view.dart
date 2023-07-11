import 'package:card_swiper/card_swiper.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:our_wallet/app/data/colors.dart';
import 'package:our_wallet/app/data/constant.dart';
import 'package:our_wallet/app/data/typography.dart';
import 'package:our_wallet/app/data/validators.dart';
import 'package:our_wallet/app/data/widgets/button_default.dart';
import 'package:our_wallet/app/data/widgets/input_text.dart';

import '../controllers/add_wallet_controller.dart';

class AddWalletView extends GetView<AddWalletController> {
  const AddWalletView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey4,
      appBar: AppBar(
        backgroundColor: grey4,
        elevation: 0,
        title: Text(
          controller.title ?? 'Tambah Wallet',
          style: textBold.copyWith(color: primary),
        ),
        automaticallyImplyLeading: false,
      ),
      body: GetBuilder<AddWalletController>(
        builder: (context) {
          return Form(
            key: controller.key,
            child: ListView(
              children: [
                const SizedBox(height: 32),
                SizedBox(
                  height: 100,
                  child: Swiper(
                    itemBuilder: (BuildContext context, int index) {
                      return Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                            width: Get.width - 32,
                            height: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.asset(
                                "$jpgPath/card_${index + 1}.jpg",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 32,
                            top: 8,
                            bottom: 8,
                            child: Text(
                              controller.name.text,
                              style: textRegular,
                            ),
                          ),
                          Positioned(
                            right: 32,
                            top: 8,
                            bottom: 8,
                            child: Text(
                              controller.money.text.isEmpty
                                  ? ""
                                  : "Rp ${controller.money.text}",
                              style: textRegular,
                            ),
                          ),
                          Positioned(
                            right: 32,
                            bottom: 8,
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
                            left: 32,
                            bottom: 8,
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
                      );
                    },
                    index: controller.index,
                    onIndexChanged: (i) => controller.swap(i),
                    physics: const ScrollPhysics(),
                    itemCount: controller.list.length,
                    itemWidth: Get.width,
                    itemHeight: 100.0,
                    layout: SwiperLayout.DEFAULT,
                  ),
                ),
                const SizedBox(height: 16),
                controller.list.length < 2
                    ? const SizedBox()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:
                            controller.list.asMap().entries.map<Widget>((e) {
                          return InkWell(
                            child: Container(
                              width: controller.index == e.key ? 24.0 : 8.0,
                              height: 8.0,
                              margin: const EdgeInsets.symmetric(
                                vertical: 8.0,
                                horizontal: 2.0,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                shape: BoxShape.rectangle,
                                color:
                                    controller.index == e.key ? primary : grey,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      InputText(
                        hintText: "Masukkan Nama Wallet",
                        controller: controller.name,
                        validator: (v) => valString!(v, "Nama Wallet"),
                        onChanged: (v) => controller.onChange(),
                      ),
                      const SizedBox(height: 8),
                      InputText(
                        hintText: "Masukkan Nominal Awal",
                        controller: controller.money,
                        validator: (v) => valString!(v, "Nominal Awal"),
                        onChanged: (v) => controller.onChange(),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          CurrencyTextInputFormatter(
                            name: "",
                            locale: "ID",
                            decimalDigits: 0,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      ButtonDefault(
                        text: controller.titleButton ?? "Tambah",
                        color: controller.isComplete ? primary : primaryLight,
                        onTap: controller.isComplete
                            ? () => controller.handleSubmit()
                            : () {},
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
