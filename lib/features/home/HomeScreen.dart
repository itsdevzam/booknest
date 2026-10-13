import 'package:booknest/core/util/helper.dart';
import 'package:booknest/core/widget/EbookItem.dart';
import 'package:booknest/core/widget/WhiteDot.dart';
import 'package:booknest/features/home/bloc/home_bloc.dart';
import 'package:flutter_modern_animated_loader/flutter_animated_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final ScrollController _scrollController = ScrollController();

class _HomeScreenState extends State<HomeScreen> {
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
                        Helper.appName,
                        style: TextStyle(
                          fontFamily: Helper.cinzelFont,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    BlocBuilder<HomeBloc, HomeStates>(
                      builder: (context, state) {
                        if (state is HomeLoading) {
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

                        if (state is HomeError) {
                          return SizedBox(
                            height: Helper().getDeviceHeight(context) / 1.5,
                            child: Center(
                              child: Text(
                                state.error,
                                style: TextStyle(fontFamily: Helper.rubikFont),
                              ),
                            ),
                          );
                        }

                        if (state is HomeLoaded) {
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
                                      'No more Ebooks Available',
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
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 300) {
        context.read<HomeBloc>().add(LoadHome());
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
