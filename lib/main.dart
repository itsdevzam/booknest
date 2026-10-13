import 'package:background_downloader/background_downloader.dart';
import 'package:booknest/core/util/download_service.dart';
import 'package:booknest/core/util/helper.dart';
import 'package:booknest/data/ebook_data_source.dart';
import 'package:booknest/features/categories/bloc/cat_bloc.dart';
import 'package:booknest/features/home/bloc/home_bloc.dart';
import 'package:booknest/features/open_pdf_screen/bloc/open_pdf_bloc.dart';
import 'package:booknest/features/search/bloc/search_bloc.dart';
import 'package:booknest/features/single_cat_ebooks/bloc/single_cat_bloc.dart';
import 'package:booknest/features/splash/SplashScreen.dart';
import 'package:booknest/features/view_ebook/bloc/open_ebook_bloc.dart';
import 'package:booknest/repo/ebook_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FileDownloader().start(autoCleanDatabase: true);

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ebookDataSource = EbookDataSource();
    final ebookRepo = EbookRepo(ebookDataSource: ebookDataSource);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeBloc(ebookRepo: ebookRepo)..add(LoadHome()),
        ),
        BlocProvider(create: (context) => SearchBloc(ebookRepo: ebookRepo)),
        BlocProvider(
          create: (context) =>
              CatBloc(ebookRepo: ebookRepo)..add(LoadCatEvent()),
        ),
        BlocProvider(create: (context) => SingleCatBloc(ebookRepo: ebookRepo)),
        BlocProvider(create: (context) => OpenPdfBloc()),
        BlocProvider(
          create: (context) =>
              OpenEbookBloc(downloadService: DownloadService()),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          colorSchemeSeed: Helper.primaryColor,
          useMaterial3: true,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
