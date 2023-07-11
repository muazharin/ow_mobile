import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:our_wallet/app/data/colors.dart';
import 'package:our_wallet/app/data/typography.dart';
import 'package:our_wallet/app/data/widgets/button_default.dart';

class InputDate extends StatefulWidget {
  const InputDate({
    super.key,
    this.controller,
    this.onTap,
    this.validator,
    this.onChanged,
    this.hintText,
    this.isBirthDate = false,
  });
  final TextEditingController? controller;
  final void Function(DateTime? v)? onTap;
  final String? hintText;
  final String? Function(String?)? validator;
  final bool? isBirthDate;
  final void Function(String)? onChanged;

  @override
  State<InputDate> createState() => _InputDateState();
}

class _InputDateState extends State<InputDate> {
  DateTime? date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return TextFormField(
      controller: widget.controller,
      style: textRegular,
      onChanged: widget.onChanged,
      onTap: widget.onTap != null
          ? () {
              Get.dialog(
                Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 16,
                        ),
                        decoration: BoxDecoration(
                          color: white,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: 48,
                              height: 8,
                              decoration: BoxDecoration(
                                color: black,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            const SizedBox(height: 32),
                            Text(
                              widget.hintText!,
                              style: textBold.copyWith(fontSize: 18),
                            ),
                            const SizedBox(height: 28),
                            SizedBox(
                              height: s.height * .2,
                              child: widget.isBirthDate!
                                  ? CupertinoDatePicker(
                                      initialDateTime: DateTime.now(),
                                      minimumDate: DateTime(1900, 1, 1),
                                      maximumDate: DateTime.now(),
                                      maximumYear: DateTime.now().year,
                                      minimumYear: 1900,
                                      mode: CupertinoDatePickerMode.date,
                                      onDateTimeChanged: (v) {
                                        setState(() {
                                          date = v;
                                        });
                                      },
                                    )
                                  : CupertinoDatePicker(
                                      minimumYear: DateTime.now().year,
                                      maximumDate: DateTime(2100, 1, 1),
                                      minimumDate: DateTime.now(),
                                      initialDateTime: DateTime.now(),
                                      mode: CupertinoDatePickerMode.date,
                                      onDateTimeChanged: (v) {
                                        setState(() {
                                          date = v;
                                        });
                                      },
                                    ),
                            ),
                            const SizedBox(height: 16),
                            ButtonDefault(
                              text: "Apply",
                              color: primary,
                              onTap: () {
                                widget.onTap!(date);
                                Get.back();
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          : () {},
      readOnly: true,
      validator: widget.validator,
      decoration: InputDecoration(
        filled: true,
        fillColor: white,
        contentPadding: const EdgeInsets.all(10),
        suffixIcon: const Icon(Icons.calendar_month_outlined),
        hintText: widget.hintText ?? '',
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
