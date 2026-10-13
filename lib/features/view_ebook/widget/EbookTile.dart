import 'package:flutter/material.dart';

class EbookTile extends StatelessWidget {
  final Widget widget;
  final bool verticalBorder;
  const EbookTile({
    super.key,
    required this.widget,
    this.verticalBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white30,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey),
        // border: Border(top: BorderSide(color: Colors.grey)),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: verticalBorder ? 20 : 15,
        vertical: verticalBorder ? 10 : 0,
      ),
      child: widget,
    );
  }
}
