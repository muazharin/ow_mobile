import 'package:flutter/material.dart';
import 'package:our_wallet/app/data/colors.dart';
import 'package:our_wallet/app/data/typography.dart';

class ButtonOutlined extends StatelessWidget {
  const ButtonOutlined({
    super.key,
    required this.text,
    this.color,
    required this.onTap,
    required this.borderColor,
  });
  final String? text;
  final Color? color;
  final Color? borderColor;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color ?? Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor ?? primary),
        ),
        child: Center(
          child: Text(
            text!,
            style: textBold.copyWith(
              color: borderColor,
              fontSize: 16,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
