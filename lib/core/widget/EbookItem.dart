import 'package:booknest/core/model/ebook_model.dart';
import 'package:booknest/core/util/helper.dart';
import 'package:booknest/features/view_ebook/ViewEbookScreen.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class EbookItem extends StatelessWidget {
  final bool isHomeScreen;
  final bool isFavItem;
  final EbookModel ebookModel;
  const EbookItem({
    super.key,
    this.isHomeScreen = true,
    this.isFavItem = false,
    required this.ebookModel,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (ebookModel.ebookUrl.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Ebook is not available.',
                style: TextStyle(
                  color: Colors.black,
                  wordSpacing: 2,
                  fontFamily: Helper.rubikFont,
                ),
              ),
              backgroundColor: Helper.primaryColor,
              padding: EdgeInsets.all(15),
              showCloseIcon: true,
              closeIconColor: Colors.black,
            ),
          );
          return;
        }

        Helper().navigate(context, ViewEbookScreen(ebookModel: ebookModel));
      },
      child: Card.outlined(
        color: Colors.white30,
        child: Stack(
          children: [
            Positioned(
              top: 10,
              left: 10,
              right: 10,
              bottom: 10,
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(5),
                child: FadeInImage(
                  placeholder: AssetImage(Helper.appPlaceholder),
                  image: ebookModel.ebookImage.isNotEmpty
                      ? NetworkImage(ebookModel.ebookImage)
                      : AssetImage(Helper.appPlaceholder),
                  fit: BoxFit.cover,
                  imageErrorBuilder: (context, error, stackTrace) =>
                      Image.asset(Helper.appPlaceholder),
                ),
              ),
            ),
            if (!isHomeScreen)
              Positioned(
                right: 8,
                top: 8,
                child: SizedBox(
                  height: 40,
                  width: 40,
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      isFavItem ? Icons.favorite : Iconsax.add,
                      color: Colors.red,
                    ),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.grey.shade100,
                      elevation: 2,
                      side: BorderSide(color: Colors.grey.withAlpha(50)),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
