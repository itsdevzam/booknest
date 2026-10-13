import 'package:booknest/core/util/helper.dart';
import 'package:booknest/core/widget/WhiteDot.dart';
import 'package:flutter/material.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: Helper.linearGradient),
        height: Helper().getDeviceHeight(context),
        child: Stack(
          children: [
            Positioned(top: 130, left: 0, child: WhiteDot(num: 1)),
            Positioned(bottom: 130, right: 0, child: WhiteDot(num: 2)),
            Positioned(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  top: MediaQuery.viewPaddingOf(context).top,
                  bottom: 20,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 20,
                      ),
                      child: Text(
                        'Favourites',
                        style: TextStyle(
                          fontFamily: Helper.cinzelFont,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1 / 1.3,
                        crossAxisSpacing: 5,
                      ),
                      itemBuilder: (context, index) {
                        return Text('data');
                        // return EbookItem(isFavItem: true);
                      },
                      itemCount: 4,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
