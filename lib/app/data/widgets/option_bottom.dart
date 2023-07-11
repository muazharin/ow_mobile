import 'package:flutter/material.dart';
import 'package:our_wallet/app/data/colors.dart';
import 'package:our_wallet/app/data/typography.dart';

class OptionBottom extends StatelessWidget {
  const OptionBottom({super.key, required this.list});
  final List list;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                height: 6,
                width: 40,
                color: primary,
              ),
            ),
          ),
          const SizedBox(height: 16),
          ...list.map<Widget>((e) {
            return GestureDetector(
              onTap: e['on_tap'],
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  e['name'],
                  style: textRegular,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
