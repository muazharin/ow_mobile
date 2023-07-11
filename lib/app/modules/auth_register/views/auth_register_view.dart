import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:our_wallet/app/data/colors.dart';
import 'package:our_wallet/app/data/typography.dart';
import 'package:our_wallet/app/data/validators.dart';
import 'package:our_wallet/app/data/widgets/button_default.dart';
import 'package:our_wallet/app/data/widgets/input_date.dart';
import 'package:our_wallet/app/data/widgets/input_text.dart';
import 'package:our_wallet/app/data/widgets/svg_file.dart';

import '../controllers/auth_register_controller.dart';

class AuthRegisterView extends GetView<AuthRegisterController> {
  const AuthRegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        title: Text(
          'Formulir Pendaftaran',
          style: textBold,
        ),
        automaticallyImplyLeading: false,
      ),
      body: GetBuilder<AuthRegisterController>(
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: controller.key,
              child: ListView(
                children: [
                  const SizedBox(height: 32),
                  const SvgFile(filename: 'form.svg'),
                  const SizedBox(height: 32),
                  InputText(
                    hintText: "Masukkan Username",
                    controller: controller.username,
                    validator: (v) => valString!(v, "Username"),
                    onChanged: (v) => controller.onChange(),
                  ),
                  const SizedBox(height: 16),
                  InputText(
                    hintText: "Masukkan Email",
                    controller: controller.email,
                    validator: (v) => valEmail!(v, "Email"),
                    onChanged: (v) => controller.onChange(),
                  ),
                  const SizedBox(height: 16),
                  InputText(
                    hintText: "Masukkan No Telp",
                    controller: controller.phone,
                    validator: (v) => valPhone!(v, "No Telp"),
                    onChanged: (v) => controller.onChange(),
                    readOnly: true,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: RadioListTile(
                          contentPadding: EdgeInsets.zero,
                          value: "Pria",
                          title: Text(
                            "Pria",
                            style: textRegular.copyWith(color: black2),
                          ),
                          groupValue: controller.gender,
                          onChanged: (v) => controller.setGender(v!),
                          activeColor: primary,
                        ),
                      ),
                      Expanded(
                        child: RadioListTile(
                          contentPadding: EdgeInsets.zero,
                          value: "Wanita",
                          title: Text(
                            "Wanita",
                            style: textRegular.copyWith(color: black2),
                          ),
                          groupValue: controller.gender,
                          onChanged: (v) => controller.setGender(v!),
                          activeColor: primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  InputDate(
                    hintText: "Masukkan Tgl Lahir",
                    controller: controller.tglLahir,
                    validator: (v) => valString!(v, "Tgl Lahir"),
                    onChanged: (v) => controller.onChange(),
                    onTap: (v) => controller.setDate(v!),
                    isBirthDate: true,
                  ),
                  const SizedBox(height: 16),
                  InputText(
                    hintText: "Masukkan Alamat",
                    controller: controller.address,
                    validator: (v) => valString!(v, "Alamat"),
                    onChanged: (v) => controller.onChange(),
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
