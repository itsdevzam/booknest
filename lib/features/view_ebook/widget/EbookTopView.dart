import 'package:booknest/core/model/ebook_model.dart';
import 'package:booknest/core/util/helper.dart';
import 'package:flutter/material.dart';

class EbookTopView extends StatelessWidget {
  final EbookModel ebookModel;
  const EbookTopView({super.key, required this.ebookModel});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          top: 130,
          left: 70,
          child: Container(
            width: 60,
            height: 70,
            decoration: BoxDecoration(
              color: Colors.white30,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          top: 100,
          right: 60,
          child: Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: Colors.white30,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          bottom: -30,
          right: 60,
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white30,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          child: ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white30,
                borderRadius: BorderRadius.circular(10),
              ),
              width: Helper().getDeviceWidth(context) / 2,
              height: Helper().getDeviceHeight(context) / 3.25,
              child: FadeInImage(
                placeholder: AssetImage(Helper.appPlaceholder),
                image: ebookModel.ebookImage.isNotEmpty
                    ? NetworkImage(ebookModel.ebookImage)
                    : AssetImage(Helper.appPlaceholder),
                fit: BoxFit.cover,
                imageErrorBuilder: (context, error, stackTrace) => Column(
                  mainAxisAlignment: .center,
                  spacing: 5,
                  children: [
                    Icon(
                      Icons.error,
                      size: 50,
                      color: Colors.deepOrange.withAlpha(150),
                    ),
                    Text(
                      'Image Not Avialable',
                      style: TextStyle(fontFamily: Helper.rubikFont),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
