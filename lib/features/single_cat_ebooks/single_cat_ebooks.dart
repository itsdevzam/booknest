import 'package:booknest/core/model/category_model.dart';
import 'package:booknest/core/util/content_parser.dart';
import 'package:booknest/core/util/helper.dart';
import 'package:booknest/core/widget/EbookItem.dart';
import 'package:booknest/core/widget/WhiteDot.dart';
import 'package:booknest/features/single_cat_ebooks/bloc/single_cat_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modern_animated_loader/flutter_animated_loader.dart';

class SingleCatEbooks extends StatefulWidget {
  final CategoryModel categoryModel;
  const SingleCatEbooks({super.key, required this.categoryModel});
  @override
  _SingleCatEbooksState createState() => _SingleCatEbooksState();
}

class _SingleCatEbooksState extends State<SingleCatEbooks> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Helper().getDeviceHeight(context),
        decoration: BoxDecoration(gradient: Helper.linearGradient),
        child: Stack(
          children: [
            SizedBox(height: MediaQuery.paddingOf(context).top),
            Positioned(top: 130, left: 0, child: WhiteDot(num: 1)),
            Positioned(bottom: 130, right: 0, child: WhiteDot(num: 2)),
            Positioned(
              child: SingleChildScrollView(
                controller: _scrollController,
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
                        textAlign: .center,
                        ContentParser.decodeHtml(widget.categoryModel.name)!,
                        style: TextStyle(
                          fontFamily: Helper.cinzelFont,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    BlocBuilder<SingleCatBloc, SingleCatStates>(
                      builder: (context, state) {
                        if (state is SingleCatLoading) {
                          return SizedBox(
                            height: Helper().getDeviceHeight(context) / 1.5,
                            child: Center(
                              child: FlutterAnimatedLoader.quadSpin(
                                color: Helper.loadingColor,
                                size: 60,
                              ),
                            ),
                          );
                        }

                        if (state is SingleCatError) {
                          return SizedBox(
                            height: Helper().getDeviceHeight(context) / 1.5,
                            child: Center(
                              child: Text(
                                state.errorMessage,
                                style: TextStyle(fontFamily: Helper.rubikFont),
                              ),
                            ),
                          );
                        }

                        if (state is SingleCatLoaded) {
                          return Column(
                            children: [
                              GridView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 1 / 1.3,
                                      crossAxisSpacing: 5,
                                    ),
                                itemBuilder: (context, index) {
                                  return EbookItem(
                                    ebookModel: state.ebookModelList[index],
                                  );
                                },
                                itemCount: state.ebookModelList.length,
                              ),
                              if (state.isLoadMore)
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(30.0),
                                    child: FlutterAnimatedLoader.quadSpin(
                                      color: Helper.loadingColor,
                                      size: 60,
                                    ),
                                  ),
                                ),
                              if (state.noMoreBooks)
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(30.0),
                                    child: Text(
                                      'No More Ebooks Available',
                                      style: TextStyle(
                                        fontFamily: Helper.rubikFont,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          );
                        }

                        return SizedBox(
                          height: Helper().getDeviceHeight(context) / 1.5,
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

  @override
  void initState() {
    super.initState();
    context.read<SingleCatBloc>().add(LoadCatPost(widget.categoryModel.id));
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 300) {
        context.read<SingleCatBloc>().add(LoadCatPost(widget.categoryModel.id));
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
