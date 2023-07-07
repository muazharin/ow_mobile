import 'package:flutter/material.dart';
import 'package:our_wallet/app/data/colors.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: CircularProgressIndicator(color: primary),
      ),
    );
  }
}
