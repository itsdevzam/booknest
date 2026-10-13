import 'package:flutter/material.dart';

class WhiteDot extends StatelessWidget {
  final int num;
  const WhiteDot({super.key, required this.num});

  @override
  Widget build(BuildContext context) {
    if (num == 1) {
      return Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white38,
          shape: BoxShape.circle,
        ),
      );
    } else {
      return Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white38,
          shape: BoxShape.circle,
        ),
      );
    }
  }
}
