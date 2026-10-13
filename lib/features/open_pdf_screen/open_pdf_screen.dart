import 'dart:io';

import 'package:booknest/core/model/ebook_model.dart';
import 'package:booknest/core/util/helper.dart';
import 'package:booknest/features/open_pdf_screen/bloc/open_pdf_bloc.dart';
import 'package:booknest/features/open_pdf_screen/widget/bottom_sheet_open_pdf.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pdfx/pdfx.dart';

class OpenPdfScreen extends StatefulWidget {
  final EbookModel ebookModel;
  final File ebookFile;
  const OpenPdfScreen({
    super.key,
    required this.ebookFile,
    required this.ebookModel,
  });

  @override
  State<OpenPdfScreen> createState() => _OpenPdfScreenState();
}

late PdfController _pdfController;
TextEditingController _textEditingController = TextEditingController();

class _OpenPdfScreenState extends State<OpenPdfScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OpenPdfBloc, OpenPdfStates>(
      builder: (context, state) {
        final isSnipping = context.read<OpenPdfBloc>().pageSnipping;
        final isHorizontal = context.read<OpenPdfBloc>().isHorizontal;

        return Scaffold(
          backgroundColor: Helper.primaryColor,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Colors.white30,
            title: Text(
              widget.ebookModel.ebookName,
              style: TextStyle(fontFamily: Helper.cinzelFont),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: IconButton(
                  onPressed: () => BottomSheetOpenPdf.openBottomSheetOpenPdf(
                    context: context,
                    pdfController: _pdfController,
                    textEditingController: _textEditingController,
                  ),
                  icon: Icon(Iconsax.setting),
                ),
              ),
            ],
          ),
          body: Stack(
            children: [
              PdfView(
                controller: _pdfController,
                pageSnapping: isSnipping,
                scrollDirection: isHorizontal ? Axis.horizontal : Axis.vertical,
                backgroundDecoration: BoxDecoration(color: Colors.white60),
              ),
              Positioned(
                bottom: 30,
                left: 0,
                right: 0,
                child: PdfPageNumber(
                  controller: _pdfController,
                  builder: (context, loadingState, page, pagesCount) {
                    return Row(
                      mainAxisAlignment: .center,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              topLeft: Radius.circular(10),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            page.toString(),
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: Helper.cinzelFont,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                            border: Border(
                              bottom: BorderSide(color: Colors.black),
                              right: BorderSide(color: Colors.black),
                              top: BorderSide(color: Colors.black),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '${pagesCount ?? 0}',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: Helper.cinzelFont,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _pdfController = PdfController(
      document: PdfDocument.openFile(widget.ebookFile.path),
    );
  }
}
