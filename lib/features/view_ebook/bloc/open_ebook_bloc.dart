import 'dart:io';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:booknest/core/model/ebook_model.dart';
import 'package:booknest/core/util/download_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part './open_ebook_events.dart';
part './open_ebook_states.dart';

class OpenEbookBloc extends Bloc<OpenEbookEvents, OpenEbookStates> {
  final DownloadService downloadService;
  bool isDownloading = false;
  int ebookId = 0;
  bool isCancelOnBackPress = false;
  File? ebookFile;

  OpenEbookBloc({required this.downloadService})
    : super(OpenEbookInitialState()) {
    on<OpenEbookClickEvent>((event, emit) async {
      print('Ebook CLick Event');
      try {
        // Check if the ebook is already downloaded.
        final existingFile = await DownloadService.findExistingEbook(
          ebookModel: event.ebookModel,
        );

        if (existingFile != null) {
          ebookFile = existingFile;
          ebookId = event.ebookModel.id;

          emit(OpenEBookReadState(ebookFile: existingFile, ebookId: ebookId));

          return; // No download needed.
        }

        //When user backpress we make cancel true becasue without it file downloading stops
        //but event handler still running await DownloadService.openEbook() so we need
        // check if cancel = true then we dont asisgn same ebook id
        //here we maek cancel false so when user stay on screen we assign updated id
        isCancelOnBackPress = false;

        //if current ebookid not match with given id it start downlaoding again
        if (event.ebookModel.id != ebookId) {
          //to check downloding becasuse if user close dialog droppable never lets run it again.
          //we need use Reopen Event by checking if downloading true
          isDownloading = true;
          emit(OpenEBookDownloadState());
          ebookFile = await DownloadService.openEbook(
            ebookModel: event.ebookModel,
            emit: emit,
          );
          if (isCancelOnBackPress) return;
          ebookId = event.ebookModel.id;
          isDownloading = false;
        } else {
          //if donwlaod already comleted open the file
          if (ebookFile != null) {
            emit(OpenEBookReadState(ebookFile: ebookFile!, ebookId: ebookId));
          } else {
            throw 'Something went wrong';
          }
        }
      } catch (e) {
        emit(OpenEbookErrorState(errorMessage: e.toString()));
      } finally {
        isDownloading = false;
      }
    }, transformer: droppable());
    //if reopen then we again call download from here for more see ViewEBookScreen OpenEBook callback
    on<ReOpenDownloadingDialogEvent>((event, emit) {
      if (isDownloading) {
        emit(OpenEBookDownloadState());
      }
    });
  }
  Future<void> cancelDownload() async {
    ebookId = 0;
    isCancelOnBackPress = true;
    await DownloadService.cancelDownload();
    isDownloading = false;
  }
}
