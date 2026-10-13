import 'package:booknest/core/model/ebook_model.dart';
import 'package:booknest/core/util/helper.dart';
import 'package:booknest/features/view_ebook/bloc/open_ebook_bloc.dart';
import 'package:booknest/features/view_ebook/widget/EbookTile.dart';
import 'package:booknest/features/view_ebook/widget/EbookTopView.dart';
import 'package:booknest/features/view_ebook/widget/ebook_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewEbookScreen extends StatelessWidget {
  final EbookModel ebookModel;
  const ViewEbookScreen({super.key, required this.ebookModel});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          await context.read<OpenEbookBloc>().cancelDownload();
        }
      },
      child: BlocListener<OpenEbookBloc, OpenEbookStates>(
        listener: (context, state) {
          final currentBloc = context.read<OpenEbookBloc>();
          if (state is OpenEBookReadState) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              EbookDialog().showReadDialog(
                context: context,
                ebookPdf: state.ebookFile,
                ebookModel: ebookModel,
              );
            });
          }
          if (state is OpenEBookDownloadState) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              EbookDialog().showDownloadDialog(
                context: context,
                openEbookBloc: currentBloc,
                ebookModel: ebookModel,
              );
            });
          }
        },
        child: Scaffold(
          body: Container(
            decoration: BoxDecoration(gradient: Helper.linearGradient),
            child: Column(
              children: [
                Expanded(flex: 4, child: EbookTopView(ebookModel: ebookModel)),
                Expanded(
                  flex: 6,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      crossAxisAlignment: .center,
                      spacing: 15,
                      children: [
                        EbookTile(
                          widget: Text(
                            ebookModel.ebookName,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontFamily: Helper.rubikFont,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        EbookTile(
                          widget: Text(
                            'Author: ${ebookModel.ebookAuthor}',
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: Helper.rubikFont,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Expanded(
                          child: EbookTile(
                            verticalBorder: false,
                            widget: SingleChildScrollView(
                              child: Text(
                                ebookModel.ebookDesc,

                                style: TextStyle(
                                  fontFamily: Helper.rubikFont,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ),
                        EbookTile(
                          widget: Text(ebookModel.ebookCatList.join(', ')),
                        ),
                        InkWell(
                          onTap: () {
                            //if downloading active then we cant use opendowndilaog from OpenEbookClickEvent event
                            //due to dropabble that why we use ReOpenDownloadingDialogEvent when download active
                            final bloc = context.read<OpenEbookBloc>();
                            if (bloc.isDownloading) {
                              bloc.add(ReOpenDownloadingDialogEvent());
                            } else {
                              bloc.add(
                                OpenEbookClickEvent(ebookModel: ebookModel),
                              );
                            }
                          },

                          child: SizedBox(
                            width: Helper().getDeviceWidth(context) / 2,
                            child: EbookTile(
                              widget: Row(
                                mainAxisAlignment: .center,
                                children: [
                                  Text(
                                    'Open EBook',
                                    style: TextStyle(
                                      fontFamily: Helper.cinzelFont,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Icon(Icons.open_in_new, size: 20),
                                ],
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 50),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
