import 'package:flutter/material.dart';
import 'package:our_wallet/app/data/colors.dart';
import 'package:our_wallet/app/data/typography.dart';

class ListPersonalData extends StatefulWidget {
  const ListPersonalData({
    super.key,
    this.name,
    this.data,
    this.isDivide = true,
  });
  final String? name;
  final String? data;
  final bool? isDivide;

  @override
  State<ListPersonalData> createState() => _ListPersonalDataState();
}

class _ListPersonalDataState extends State<ListPersonalData> {
  bool isHit = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  widget.name ?? "",
                  style: textRegular,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Expanded(
                flex: 2,
                child: GestureDetector(
                  onTap: () => setState(() {
                    isHit = !isHit;
                  }),
                  child: Text(
                    widget.data ?? "",
                    style: textRegular,
                    overflow: isHit ? TextOverflow.clip : TextOverflow.ellipsis,
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
            ],
          ),
          widget.isDivide!
              ? Divider(
                  color: grey,
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
