part of './open_ebook_bloc.dart';

abstract class OpenEbookEvents {}

class OpenEbookClickEvent extends OpenEbookEvents {
  EbookModel ebookModel;
  OpenEbookClickEvent({required this.ebookModel});
}

class ReOpenDownloadingDialogEvent extends OpenEbookEvents {}

class OpenEbookDownloadEvent extends OpenEbookEvents {}

class OpenEbookReadEvent extends OpenEbookEvents {}

class OpenEbookShareEvent extends OpenEbookEvents {}
