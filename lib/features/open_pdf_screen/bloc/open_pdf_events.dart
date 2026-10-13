part of './open_pdf_bloc.dart';

abstract class OpenPdfEvents {}

class OpenPdfPageSnipping extends OpenPdfEvents {
  bool isSnipping;
  OpenPdfPageSnipping(this.isSnipping);
}

class OpenPdfPageHorizontal extends OpenPdfEvents {
  bool isHorizontal;
  OpenPdfPageHorizontal(this.isHorizontal);
}
