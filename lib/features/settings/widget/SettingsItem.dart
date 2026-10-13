import 'package:booknest/core/util/helper.dart';

import 'package:flutter/material.dart';

class SettingsItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback callback;
  const SettingsItem({
    super.key,
    required this.callback,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: callback,
      child: Card.outlined(
        color: Colors.white30,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          child: Row(
            children: [
              Icon(icon, size: 18),
              SizedBox(width: 10),
              Text(title, style: TextStyle(fontFamily: Helper.rubikFont)),
            ],
          ),
        ),
      ),
    );
  }
}
