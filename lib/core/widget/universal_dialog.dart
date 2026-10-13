import 'package:booknest/core/util/helper.dart';
import 'package:flutter/material.dart';

class UniversalDialog extends StatelessWidget {
  final String title, subTitle, confirmButtonText, otherButtonText;
  final VoidCallback confirmAction, otherAction;
  const UniversalDialog({
    super.key,
    required this.confirmButtonText,
    required this.otherButtonText,
    this.subTitle = '',
    required this.confirmAction,
    required this.otherAction,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height:
            Helper().getDeviceHeight(context) / (subTitle.isEmpty ? 5 : 4.5),
        decoration: BoxDecoration(
          color: Helper.primaryColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            spacing: 10,
            // mainAxisAlignment: .center,
            children: [
              SizedBox(height: 20),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: Helper.cinzelFont,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subTitle.isEmpty
                  ? SizedBox()
                  : Text(
                      subTitle,
                      style: TextStyle(
                        fontFamily: Helper.rubikFont,
                        fontSize: 16,
                      ),
                    ),
              Row(
                mainAxisAlignment: .center,
                children: [
                  ElevatedButton(
                    onPressed: confirmAction,
                    child: Text(confirmButtonText),
                  ),
                  SizedBox(width: 30),
                  OutlinedButton(
                    onPressed: otherAction,
                    child: Text(otherButtonText),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
