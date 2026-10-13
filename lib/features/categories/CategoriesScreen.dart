import 'package:booknest/core/util/content_parser.dart';
import 'package:booknest/core/util/helper.dart';
import 'package:booknest/core/widget/WhiteDot.dart';
import 'package:booknest/features/categories/bloc/cat_bloc.dart';
import 'package:booknest/features/single_cat_ebooks/single_cat_ebooks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modern_animated_loader/flutter_animated_loader.dart';
import 'package:iconsax/iconsax.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

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
                        'Categories',
                        style: TextStyle(
                          fontFamily: Helper.cinzelFont,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    BlocBuilder<CatBloc, CatStates>(
                      builder: (context, state) {
                        if (state is CatLoading) {
                          return Padding(
                            padding: EdgeInsets.only(
                              top: Helper().getDeviceHeight(context) / 3.5,
                            ),
                            child: Center(
                              child: FlutterAnimatedLoader.quadSpin(
                                color: Helper.loadingColor,
                                size: 60,
                              ),
                            ),
                          );
                        }
                        if (state is CatError) {
                          return Padding(
                            padding: EdgeInsets.only(
                              top: Helper().getDeviceHeight(context) / 3.5,
                            ),
                            child: Center(
                              child: Text(
                                state.errorMessage,
                                style: TextStyle(fontFamily: Helper.rubikFont),
                              ),
                            ),
                          );
                        }
                        if (state is CatLoaded) {
                          return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            itemBuilder: (context, index) {
                              return InkWell(
                                borderRadius: BorderRadius.circular(10),
                                onTap: () => Helper().navigate(
                                  context,
                                  SingleCatEbooks(
                                    categoryModel: state.catModelList[index],
                                  ),
                                ),
                                child: Card.outlined(
                                  color: Colors.white30,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 15,
                                      horizontal: 15,
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            ContentParser.decodeHtml(
                                              state.catModelList[index].name,
                                            )!,
                                            style: TextStyle(
                                              fontFamily: Helper.rubikFont,
                                              overflow: TextOverflow.fade,
                                            ),
                                          ),
                                        ),

                                        Icon(Iconsax.arrow_right_1, size: 16),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            itemCount: state.catModelList.length,
                          );
                        }
                        return Padding(
                          padding: EdgeInsets.only(
                            top: Helper().getDeviceHeight(context) / 3.5,
                          ),
                          child: Center(
                            child: Text(
                              'Something went wrong',
                              style: TextStyle(fontFamily: Helper.rubikFont),
                            ),
                          ),
                        );
                      },
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
