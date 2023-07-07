import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:our_wallet/app/data/constant.dart';

class SvgFile extends StatelessWidget {
  const SvgFile({Key? key, required this.filename}) : super(key: key);
  final String? filename;
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      "$svgPath/${filename!}",
      width: 150,
      height: 150,
    );
  }
}
