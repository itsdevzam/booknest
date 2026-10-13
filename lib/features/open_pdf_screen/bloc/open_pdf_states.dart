part of './open_pdf_bloc.dart';

abstract class OpenPdfStates {}

class OpenPdfInitialStates extends OpenPdfStates {}

class OpenPdfPageSnippingState extends OpenPdfStates {
  bool pageSnipping;
  OpenPdfPageSnippingState(this.pageSnipping);
}

class OpenPdfPageHorizontalState extends OpenPdfStates {
  bool horizontalState;
  OpenPdfPageHorizontalState(this.horizontalState);
}
