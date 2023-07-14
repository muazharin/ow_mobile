import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:our_wallet/app/data/colors.dart';
import 'package:our_wallet/app/data/typography.dart';
import 'package:our_wallet/app/data/utils.dart';
import 'package:our_wallet/app/data/widgets/button_outlined.dart';
import 'package:our_wallet/app/data/widgets/loading_shimmer.dart';
import 'package:our_wallet/app/data/widgets/profile_menu.dart';
import 'package:our_wallet/app/routes/app_pages.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey4,
      appBar: AppBar(
        backgroundColor: primary,
        elevation: 0,
        title: Text(
          'Profile',
          style: textBold.copyWith(color: white),
        ),
        automaticallyImplyLeading: false,
      ),
      body: RefreshIndicator(
        onRefresh: () async => controller.getDataProfile(),
        child: ListView(
          children: [
            Container(
              color: primary,
              padding: const EdgeInsets.only(bottom: 16),
              child: GetBuilder<ProfileController>(
                builder: (context) {
                  if (controller.isLoading) {
                    return ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(32),
                        child: const LoadingShimmer(
                          width: 56,
                          height: 56,
                        ),
                      ),
                      title: Container(
                        padding: const EdgeInsets.only(right: 150),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                        ),
                        child: const LoadingShimmer(
                          width: 56,
                          height: 8,
                        ),
                      ),
                      subtitle: Container(
                        padding: const EdgeInsets.only(right: 100),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                        ),
                        child: const LoadingShimmer(
                          width: 56,
                          height: 8,
                        ),
                      ),
                    );
                  } else if (controller.isError) {
                    return ListTile(
                      leading: Hero(
                        tag: "image",
                        child: CircleAvatar(
                          backgroundColor: white,
                          radius: 28,
                          child: Text(
                            "X",
                            style: textBold.copyWith(color: primary),
                          ),
                        ),
                      ),
                      title: Text(
                        "Nama tidak ditemukan",
                        style: textRegular,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        "Email tidak ditemukan",
                        style: textRegular,
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }
                  return ListTile(
                    leading: Hero(
                      tag: "image",
                      child: controller.authModel.userPhoto!.isNotEmpty
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(32),
                              child: Image.network(
                                controller.authModel.userPhoto!,
                                width: 56,
                                height: 56,
                                fit: BoxFit.cover,
                              ),
                            )
                          : CircleAvatar(
                              backgroundColor: white,
                              radius: 28,
                              child: Text(
                                controller.authModel.userName![0].toUpperCase(),
                                style: textBold.copyWith(color: primary),
                              ),
                            ),
                    ),
                    title: Text(
                      nameFormat(controller.authModel.userName!),
                      style: textBold.copyWith(color: white),
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      controller.authModel.userEmail!,
                      style: textRegular.copyWith(color: white),
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Informasi",
                        style: textBold.copyWith(fontSize: 12),
                      ),
                      const SizedBox(width: 8),
                      Expanded(child: Divider(color: grey)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ProfileMenu(
                    title: 'Data Diri',
                    onTap: () => Get.toNamed(Routes.PERSONAL_DATA),
                  ),
                  Row(
                    children: [
                      Text(
                        "Lainnya",
                        style: textBold.copyWith(fontSize: 12),
                      ),
                      const SizedBox(width: 8),
                      Expanded(child: Divider(color: grey)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ProfileMenu(
                    title: 'Ubah Password',
                    onTap: () => Get.toNamed(
                      Routes.AUTH_CREATE_PASSWORD,
                      arguments: {'isRecreate': true},
                    ),
                  ),
                  const ProfileMenu(title: 'Butuh Bantuan'),
                  const ProfileMenu(title: 'Tentang Aplikasi'),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        color: grey4,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ButtonOutlined(
              text: "Keluar",
              onTap: () => controller.logout(),
              borderColor: primary,
            ),
            const SizedBox(height: 8),
            Text("Versi 1.0.0", style: textRegular),
            const SizedBox(height: 8),
            Container(
              color: grey4,
              child: Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: textRegular,
                    children: [
                      const TextSpan(text: "Made with "),
                      WidgetSpan(
                          child: Icon(
                        Icons.favorite_border_rounded,
                        color: primary,
                        size: 18,
                      )),
                      const TextSpan(text: " MuazDev"),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
