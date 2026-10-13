import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_file_saver/flutter_file_saver.dart';

class Helper {
  //Strings
  static String appName = 'Book Nest';

  //Font
  static String cinzelFont = 'Cinzel';
  static String rubikFont = 'Rubik';

  //Icon
  static String appIcon = 'assets/icon/booknest.png';
  static String appPlaceholder = 'assets/icon/placeholder.png';

  //Urls
  static String ebookDataSource = 'https://vetbooks.ir';

  //Color
  static Color primaryColor = Color(0xffc2e9fb);
  static Color secondaryColor = Color(0xFFa1c4fd);
  static Color loadingColor = Colors.black.withAlpha(150);
  static Color loadingIndicatorColor = const Color(0xFF7FA8E8);

  //Gradient
  static LinearGradient linearGradient = LinearGradient(
    begin: AlignmentGeometry.topLeft,
    colors: [Color(0xFFa1c4fd), Color(0xffc2e9fb)],
  );

  //Device Width
  double getDeviceWidth(BuildContext context) {
    return MediaQuery.sizeOf(context).width;
  }

  //Device Height
  double getDeviceHeight(BuildContext context) {
    return MediaQuery.sizeOf(context).height;
  }

  //Navigator
  Future<void> navigate(
    BuildContext context,
    Widget page, {
    bool canBack = true,
  }) {
    if (canBack) {
      return Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => page),
      );
    } else {
      return Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => page),
      );
    }
  }

  //save file to user location
  static void savePdftoUserDevice({required File pdfFile}) async {
    final fileBytes = await pdfFile.readAsBytes();
    FlutterFileSaver().writeFileAsBytes(
      fileName: pdfFile.uri.pathSegments.last,
      bytes: fileBytes,
    );
  }
}
