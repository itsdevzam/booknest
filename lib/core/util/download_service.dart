import 'dart:io';
import 'package:background_downloader/background_downloader.dart';
import 'package:booknest/core/model/ebook_model.dart';
import 'package:booknest/features/view_ebook/bloc/open_ebook_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_rar/flutter_rar.dart';

class DownloadService {
  static DownloadTask? activeTask;
  static Future<File?> openEbook({
    required EbookModel ebookModel,
    required Emitter<OpenEbookStates> emit,
  }) async {
    final stopwatch = Stopwatch()..start();
    int previousBytes = 0;
    int previousTimeMs = 0;

    try {
      //Initial State

      emit(OpenEbookInitialState());

      activeTask = DownloadTask(
        url: ebookModel.ebookUrl,
        filename: '${cleanFileName(ebookModel.ebookName)}.rar',
      );
      final totalBytes = await activeTask!.expectedFileSize();
      final result = await FileDownloader().download(
        activeTask!,
        onProgress: (progress) {
          final downloadedBytes = (progress * totalBytes).round();
          final currentTimeMs = stopwatch.elapsedMilliseconds;
          final elapsedMs = currentTimeMs - previousTimeMs;
          final bytesDownloaded = downloadedBytes - previousBytes;
          double speedMBps = 0;
          if (elapsedMs > 0 && bytesDownloaded >= 0) {
            speedMBps = bytesDownloaded / (elapsedMs / 1000) / (1024 * 1024);
          }

          //Downloading State
          emit(
            OpenEbookDownloadingState(
              progress: progress,
              downloadedBytes: formatBytes(downloadedBytes),
              totalBytes: formatBytes(totalBytes),
              downSpeed: speedMBps < 1
                  ? '${(speedMBps * 1024).toStringAsFixed(2)} KB/s'
                  : '${speedMBps.toStringAsFixed(2)} MB/s',
            ),
          );
        },
      );

      if (result.status == TaskStatus.complete) {
        final filePath = await activeTask!.filePath();
        final directoryPath = File(filePath).parent.path;
        emit(OpenEbookExtractRarState());
        File? file = await extractRarFile(
          rarFilePath: filePath,
          outputFolder: directoryPath,
        );

        if (file != null) {
          //success state
          emit(OpenEbookSuccessState(ebookFile: file, ebookId: ebookModel.id));
          return file;
        } else {
          throw 'Something went wrong';
        }
      }
      return null;
    } catch (e, stackTrace) {
      print('EBOOK ERROR: $e');
      print('STACK TRACE: $stackTrace');

      rethrow;
    }
  }

  static Future<File?> extractRarFile({
    required String rarFilePath,
    required String outputFolder,
  }) async {
    final result = await FlutterRar.extract(
      rarFilePath: rarFilePath,
      destinationPath: outputFolder,
      password: 'vetbooks.ir',
    );

    if (!result.success) {
      throw 'Ebook Extraction failed: ${result.message}';
    }

    for (final entry in result.entries) {
      if (entry.isDirectory || entry.skipped || entry.extractedPath.isEmpty) {
        continue;
      }
      if (!entry.name.toLowerCase().endsWith('.pdf')) continue;

      final newPath = cleanFileName(
        entry.name,
      ).replaceAll('VetBooks.ir', 'BookNest');
      final renamedFile = await File(
        entry.extractedPath,
      ).rename('$outputFolder/$newPath');

      final rarFile = File(rarFilePath);
      if (await rarFile.exists()) {
        await rarFile.delete();
      }
      return renamedFile;
    }
    return null;
  }

  static String formatBytes(int bytes) {
    if (bytes >= 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(bytes / 1024).toStringAsFixed(1)} KB';
  }

  static String cleanFileName(String name) {
    return name
        .trim()
        .replaceAll(RegExp(r'\s+'), '_')
        .replaceAll(RegExp(r'[^\w.-]'), '');
  }

  static Future<void> cancelDownload() async {
    final task = activeTask;

    if (task != null) {
      await FileDownloader().cancelTaskWithId(task.taskId);
      activeTask = null;
    }
  }

  static Future<File?> findExistingEbook({
    required EbookModel ebookModel,
  }) async {
    final directory = await getApplicationDocumentsDirectory();

    final fileName = cleanFileName(
      ebookModel.ebookName,
    ).replaceAll('.rar', '').replaceAll('.pdf', '');

    final file = File('${directory.path}/${fileName}_BookNest.pdf');

    if (await file.exists()) {
      return file;
    }

    return null;
  }
}
