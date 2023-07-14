import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:our_wallet/app/data/colors.dart';
import 'package:our_wallet/app/data/typography.dart';
import 'package:our_wallet/app/data/widgets/option_bottom.dart';
import 'package:badges/badges.dart' as badges;

class SelectImage extends StatefulWidget {
  const SelectImage({Key? key, this.files}) : super(key: key);
  final void Function(List<File>)? files;
  @override
  State<SelectImage> createState() => _SelectImageState();
}

class _SelectImageState extends State<SelectImage> {
  List<File>? image = [];
  void selectSource() {
    FocusScope.of(context).requestFocus(FocusNode());
    Get.bottomSheet(OptionBottom(
      list: [
        {
          "name": "Kamera",
          "on_tap": () => getImage(ImageSource.camera),
        },
        {
          "name": "Galeri",
          "on_tap": () => getImage(ImageSource.gallery),
        },
      ],
    ));
  }

  void getImage(ImageSource imageSource) async {
    Get.back();
    final XFile? xFile = await ImagePicker().pickImage(source: imageSource);
    if (xFile != null) {
      setState(() {
        var fileImage = File(xFile.path);
        image!.add(fileImage);
        widget.files!(image!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: Get.width,
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: image!.isNotEmpty && image != null
                ? Wrap(
                    children: [
                      ...image!.asMap().entries.map<Widget>((e) {
                        return Padding(
                          padding: const EdgeInsets.all(2),
                          child: Column(
                            children: [
                              badges.Badge(
                                badgeContent: Icon(
                                  Icons.clear,
                                  color: white,
                                  size: 10,
                                ),
                                onTap: () {
                                  setState(() {
                                    image!.removeAt(e.key);
                                    widget.files!(image!);
                                  });
                                },
                                badgeStyle: badges.BadgeStyle(
                                  badgeColor: primary,
                                  elevation: 0,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: SizedBox(
                                    height: 56,
                                    width: 56,
                                    child: Image.file(
                                      e.value,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                      const SizedBox(width: 2),
                      InkWell(
                        onTap: () => selectSource(),
                        child: Container(
                          height: 56,
                          width: 56,
                          margin: const EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: grey),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.add,
                              color: grey,
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                : InkWell(
                    onTap: () => selectSource(),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(0),
                        child: Container(
                          height: 56,
                          width: 56,
                          decoration: BoxDecoration(
                            border: Border.all(color: grey),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.add,
                              color: grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
