import 'package:booknest/core/util/helper.dart';
import 'package:booknest/features/open_pdf_screen/bloc/open_pdf_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pdfx/pdfx.dart';

class BottomSheetOpenPdf {
  static void openBottomSheetOpenPdf({
    required BuildContext context,
    required PdfController pdfController,
    required TextEditingController textEditingController,
  }) async {
    await showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => AnimatedPadding(
        duration: Duration(milliseconds: 100),
        padding: EdgeInsetsGeometry.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Helper.primaryColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 5,
              crossAxisAlignment: .start,
              children: [
                Row(
                  spacing: 20,
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    SizedBox(width: 50),
                    Text(
                      'Settings',
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
                Row(
                  spacing: 10,
                  children: [
                    Text(
                      'Jump To Page: ',
                      style: TextStyle(fontFamily: Helper.cinzelFont),
                    ),
                    Flexible(
                      child: SizedBox(
                        height: 35,
                        child: TextField(
                          controller: textEditingController,
                          keyboardType: TextInputType.number,
                          cursorHeight: 20,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(
                              bottom: 0,
                              left: 5,
                              right: 0,
                              top: 0,
                            ),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.white30,
                      child: IconButton(
                        onPressed: () {
                          if (textEditingController.text.isEmpty) {
                            return;
                          }
                          final int pageNum = int.parse(
                            textEditingController.text,
                          );
                          if (pageNum.isNaN) {
                            return;
                          } else {
                            textEditingController.clear();
                            pdfController.animateToPage(
                              pageNum,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                          }

                          Navigator.pop(context);
                        },
                        icon: Icon(Iconsax.arrow_right_1),
                      ),
                    ),
                  ],
                ),
                SizedBox(),
                BlocBuilder<OpenPdfBloc, OpenPdfStates>(
                  builder: (context, state) {
                    final isSnipping = context.read<OpenPdfBloc>().pageSnipping;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      spacing: 10,
                      children: [
                        Text(
                          'Page Snipping:',
                          style: TextStyle(fontFamily: Helper.cinzelFont),
                        ),
                        Switch(
                          value: isSnipping,
                          onChanged: (value) {
                            context.read<OpenPdfBloc>().add(
                              OpenPdfPageSnipping(value),
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(),
                BlocBuilder<OpenPdfBloc, OpenPdfStates>(
                  builder: (context, state) {
                    final isHorizontal = context
                        .read<OpenPdfBloc>()
                        .isHorizontal;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      spacing: 10,
                      children: [
                        Text(
                          'Page Horizontal:',
                          style: TextStyle(fontFamily: Helper.cinzelFont),
                        ),
                        Switch(
                          value: isHorizontal,
                          onChanged: (value) {
                            context.read<OpenPdfBloc>().add(
                              OpenPdfPageHorizontal(value),
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
