part of './open_ebook_bloc.dart';

abstract class OpenEbookStates {}

class OpenEbookInitialState extends OpenEbookStates {}

class OpenEbookExtractRarState extends OpenEbookStates {}

class OpenEbookErrorState extends OpenEbookStates {
  final String errorMessage;
  OpenEbookErrorState({required this.errorMessage});
}

class OpenEbookSuccessState extends OpenEbookStates {
  final File ebookFile;
  final int ebookId;
  OpenEbookSuccessState({required this.ebookFile, required this.ebookId});
}

class OpenEBookDownloadState extends OpenEbookStates {}

class OpenEBookReadState extends OpenEbookStates {
  final File ebookFile;
  final int ebookId;
  OpenEBookReadState({required this.ebookFile, required this.ebookId});
}

class OpenEbookDownloadingState extends OpenEbookStates {
  final double progress;
  final String downloadedBytes;
  final String totalBytes;
  final String downSpeed;

  OpenEbookDownloadingState({
    required this.progress,
    required this.downloadedBytes,
    required this.totalBytes,
    required this.downSpeed,
  });
}
