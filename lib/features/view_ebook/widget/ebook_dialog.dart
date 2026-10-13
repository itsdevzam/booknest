import 'dart:io';

import 'package:booknest/core/model/ebook_model.dart';
import 'package:booknest/core/util/helper.dart';
import 'package:booknest/features/open_pdf_screen/open_pdf_screen.dart';
import 'package:booknest/features/view_ebook/bloc/open_ebook_bloc.dart';
import 'package:booknest/features/view_ebook/widget/EbookTile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class EbookDialog {
  Future<void> showDownloadDialog({
    required BuildContext context,
    required OpenEbookBloc openEbookBloc,
    required EbookModel ebookModel,
  }) async {
    await showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => BlocListener<OpenEbookBloc, OpenEbookStates>(
        bloc: openEbookBloc,
        listener: (context, state) {
          //Auto open ReadDilaog if Download Complete
          if (state is OpenEbookSuccessState) {
            Navigator.pop(context);
            WidgetsBinding.instance.addPostFrameCallback((_) {
              EbookDialog().showReadDialog(
                context: context,
                ebookPdf: state.ebookFile,
                ebookModel: ebookModel,
              );
            });
          }
        },
        child: Container(
          height: Helper().getDeviceHeight(context) / 5,
          decoration: BoxDecoration(
            color: Helper.primaryColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              spacing: 10,
              crossAxisAlignment: .start,
              children: [
                Row(
                  spacing: 20,
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    SizedBox(width: 50),
                    Text(
                      'Downloading',
                      style: TextStyle(
                        fontFamily: Helper.cinzelFont,
                        fontSize: 18,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Iconsax.close_circle, size: 22),
                    ),
                  ],
                ),
                SizedBox(),
                BlocBuilder<OpenEbookBloc, OpenEbookStates>(
                  bloc: openEbookBloc,
                  builder: (context, state) {
                    if (state is OpenEbookInitialState) {
                      return LinearProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(
                          Helper.loadingIndicatorColor,
                        ),
                        backgroundColor: Helper.loadingColor.withAlpha(50),
                      );
                    }

                    if (state is OpenEbookErrorState) {
                      return Center(
                        child: Text(
                          state.errorMessage,
                          style: TextStyle(fontFamily: Helper.rubikFont),
                        ),
                      );
                    }

                    if (state is OpenEbookDownloadingState) {
                      return Column(
                        children: [
                          LinearProgressIndicator(
                            value: state.progress,
                            valueColor: AlwaysStoppedAnimation(
                              Helper.loadingIndicatorColor,
                            ),
                            backgroundColor: Helper.loadingColor.withAlpha(50),
                          ),
                          SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: .spaceBetween,
                            children: [
                              Text(
                                ' ${state.downloadedBytes}/${state.totalBytes}',
                                style: TextStyle(fontFamily: Helper.rubikFont),
                              ),
                              Text(
                                state.downSpeed,
                                style: TextStyle(fontFamily: Helper.rubikFont),
                              ),
                            ],
                          ),
                        ],
                      );
                    }
                    if (state is OpenEbookExtractRarState) {
                      return Column(
                        children: [
                          LinearProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(
                              Helper.loadingIndicatorColor,
                            ),
                            backgroundColor: Helper.loadingColor.withAlpha(50),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Extracting Ebook',
                            style: TextStyle(fontFamily: Helper.rubikFont),
                          ),
                        ],
                      );
                    }

                    if (state is OpenEbookSuccessState) {
                      return Center(
                        child: Text(
                          'Opening',
                          style: TextStyle(fontFamily: Helper.rubikFont),
                        ),
                      );
                    }

                    return Center(
                      child: Text(
                        'Loading...',
                        style: TextStyle(
                          fontFamily: Helper.cinzelFont,
                          fontSize: 16,
                        ),
                      ),
                    );
                  },
                ),

                SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> showReadDialog({
    required BuildContext context,
    required File ebookPdf,
    required EbookModel ebookModel,
  }) async {
    await showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => Container(
        height: Helper().getDeviceHeight(context) / 3,
        decoration: BoxDecoration(
          color: Helper.primaryColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            spacing: 10,
            crossAxisAlignment: .start,
            children: [
              Row(
                spacing: 20,
                mainAxisAlignment: .spaceBetween,
                children: [
                  SizedBox(width: 50),
                  Text(
                    'Open EBook',
                    style: TextStyle(
                      fontFamily: Helper.cinzelFont,
                      fontSize: 18,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Iconsax.close_circle, size: 22),
                  ),
                ],
              ),
              SizedBox(),
              InkWell(
                onTap: () async {
                  Navigator.of(context, rootNavigator: true).pop();

                  Helper().navigate(
                    context,
                    OpenPdfScreen(ebookFile: ebookPdf, ebookModel: ebookModel),
                  );
                },
                child: EbookTile(
                  widget: Text(
                    'Read Now',
                    style: TextStyle(fontFamily: Helper.cinzelFont),
                  ),
                ),
              ),
              InkWell(
                onTap: () => Helper.savePdftoUserDevice(pdfFile: ebookPdf),
                child: EbookTile(
                  widget: Text(
                    'Download',
                    style: TextStyle(fontFamily: Helper.cinzelFont),
                  ),
                ),
              ),
              InkWell(
                onTap: () => Navigator.pop(context),
                child: EbookTile(
                  widget: Text(
                    'Close',
                    style: TextStyle(fontFamily: Helper.cinzelFont),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
