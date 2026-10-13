import 'package:booknest/core/util/helper.dart';
import 'package:booknest/core/widget/EbookItem.dart';
import 'package:booknest/core/widget/WhiteDot.dart';
import 'package:booknest/features/search/bloc/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modern_animated_loader/flutter_animated_loader.dart';
import 'package:iconsax/iconsax.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(gradient: Helper.linearGradient),
        child: Stack(
          children: [
            Positioned(top: 130, left: 20, child: WhiteDot(num: 1)),
            Positioned(bottom: 130, right: 20, child: WhiteDot(num: 2)),
            Positioned(
              top: MediaQuery.viewPaddingOf(context).top + 10,
              right: 20,
              left: 20,
              child: TextField(
                controller: _textEditingController,
                onChanged: (value) {
                  context.read<SearchBloc>().add(
                    SearchEbook(searchText: _textEditingController.text.trim()),
                  );
                },
                cursorHeight: 20,
                decoration: InputDecoration(
                  suffixIcon: Icon(Iconsax.search_normal),
                  hintStyle: TextStyle(fontSize: 14),
                  hintText: 'Search Ebook',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.viewPaddingOf(context).top + 80,
              bottom: 0,
              right: 0,
              left: 0,
              child: BlocBuilder<SearchBloc, SearchStates>(
                builder: (context, state) {
                  if (state is SearchInitial) {
                    return Center(
                      child: Text(
                        'Start Searching Ebook',
                        style: TextStyle(
                          fontFamily: Helper.cinzelFont,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }

                  if (state is SearchEmpty) {
                    return Center(
                      child: Text(
                        'No Ebook Found',
                        style: TextStyle(
                          fontFamily: Helper.cinzelFont,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }

                  if (state is SearchError) {
                    return Center(
                      child: Text(
                        state.errorMessage,
                        style: TextStyle(fontFamily: Helper.rubikFont),
                      ),
                    );
                  }

                  if (state is SearchLoading) {
                    return Center(
                      child: FlutterAnimatedLoader.quadSpin(
                        color: Helper.loadingColor,
                        size: 60,
                      ),
                    );
                  }

                  if (state is SearchLoaded) {
                    return GridView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1 / 1.3,
                        crossAxisSpacing: 5,
                      ),
                      itemBuilder: (context, index) {
                        // return Text('data');
                        return EbookItem(
                          ebookModel: state.ebookModelList[index],
                        );
                      },
                      itemCount: state.ebookModelList.length,
                    );
                  }

                  return Center(
                    child: Text(
                      'Something went wrong',
                      style: TextStyle(fontFamily: Helper.rubikFont),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
