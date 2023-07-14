import 'package:flutter/material.dart';
import 'package:our_wallet/app/data/colors.dart';
import 'package:our_wallet/app/data/typography.dart';

class InputSelect extends StatelessWidget {
  const InputSelect({
    super.key,
    this.controller,
    this.onTap,
    this.validator,
    this.onChanged,
    this.hintText,
  });
  final TextEditingController? controller;
  final void Function()? onTap;
  final String? hintText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: textRegular,
      onTap: onTap,
      onChanged: onChanged,
      readOnly: true,
      validator: validator,
      decoration: InputDecoration(
        filled: true,
        fillColor: white,
        contentPadding: const EdgeInsets.all(10),
        suffixIcon: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: black2,
        ),
        hintText: hintText ?? '',
        hintStyle: textRegular.copyWith(color: black3),
        errorMaxLines: 4,
        errorStyle: textRegular.copyWith(color: primary),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primary),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primary),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primary),
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: grey3),
          borderRadius: BorderRadius.circular(12),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: white),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
