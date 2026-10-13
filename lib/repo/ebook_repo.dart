import 'dart:convert';
import 'dart:io';
import 'package:booknest/core/model/category_model.dart';
import 'package:booknest/core/model/ebook_model.dart';
import 'package:booknest/core/util/content_parser.dart';
import 'package:booknest/data/ebook_data_source.dart';

class EbookRepo {
  final EbookDataSource ebookDataSource;
  EbookRepo({required this.ebookDataSource});

  Future<List<EbookModel>> fetchEbook({required int page}) async {
    try {
      final res = await ebookDataSource.fetchEbook(page: page);
      if (res.statusCode == 400) {
        throw Exception('No more Ebooks Available');
      } else if (res.statusCode != 200) {
        throw Exception('Something went wrong');
      }
      List<dynamic> jsonData = jsonDecode(res.body);
      List<EbookModel> ebookModelList = jsonData.map((e) {
        //parse some data from html
        final result = ContentParser.parseEbookContent(
          e['content']['rendered'],
        );
        return EbookModel(
          id: e['id'],
          ebookName:
              ContentParser.decodeHtml(e['title']['rendered']) ?? 'Not Found',
          ebookAuthor: result['author'] ?? 'Not Found',
          ebookCatList: ContentParser.categoriesList(e),
          ebookDesc:
              ContentParser.decodeHtml(result['description']!) ?? 'Not Found',
          ebookUrl: result['downloadUrl'] ?? 'Not Found',
          ebookImage: result['imageUrl'] ?? 'Not Found',
        );
      }).toList();
      return ebookModelList;
    } catch (e) {
      if (e is SocketException) {
        throw Exception('No internet connection');
      }
      rethrow;
    }
  }

  Future<List<CategoryModel>> allCatIdwithName() async {
    try {
      final res = await ebookDataSource.allCatIdwithName();
      if (res.statusCode == 400) {
        throw Exception('No more Categories Available');
      } else if (res.statusCode != 200) {
        throw Exception('Something went wrong');
      }
      List<dynamic> jsonData = jsonDecode(res.body);
      List<CategoryModel> catModelList = jsonData.map((e) {
        return CategoryModel(id: e['id'], count: e['count'], name: e['name']);
      }).toList();
      return catModelList;
    } catch (e) {
      if (e is SocketException) {
        throw Exception('No internet connection');
      }
      rethrow;
    }
  }

  Future<List<EbookModel>> singleCatAllPosts({
    required int catId,
    required int page,
  }) async {
    try {
      final res = await ebookDataSource.singleCatAllPosts(
        catId: catId,
        page: page,
      );
      if (res.statusCode == 400) {
        throw Exception('No more Ebooks Available');
      } else if (res.statusCode != 200) {
        throw Exception('Something went wrong');
      }
      List<dynamic> jsonData = jsonDecode(res.body);
      List<EbookModel> ebookModelList = jsonData.map((e) {
        //parse some data from html
        final result = ContentParser.parseEbookContent(
          e['content']['rendered'],
        );
        return EbookModel(
          id: e['id'],
          ebookName: e['title']['rendered'],
          ebookAuthor: result['author'] ?? 'Not Found',
          ebookCatList: ContentParser.categoriesList(e),
          ebookDesc: result['description'] ?? 'Not Found',
          ebookUrl: result['downloadUrl'] ?? 'Not Found',
          ebookImage: result['imageUrl'] ?? 'Not Found',
        );
      }).toList();
      return ebookModelList;
    } catch (e) {
      if (e is SocketException) {
        throw Exception('No internet connection');
      }
      rethrow;
    }
  }

  Future<List<EbookModel>> searchEbook({required String ebookName}) async {
    try {
      final res = await ebookDataSource.searchEbook(ebookName: ebookName);
      if (res.statusCode == 400) {
        throw Exception('No more Ebooks Available');
      } else if (res.statusCode != 200) {
        throw Exception('Something went wrong');
      }
      List<dynamic> jsonData = jsonDecode(res.body);
      List<EbookModel> ebookModelList = jsonData.map((e) {
        //parse some data from html
        final result = ContentParser.parseEbookContent(
          e['content']['rendered'],
        );
        return EbookModel(
          id: e['id'],
          ebookName:
              ContentParser.decodeHtml(e['title']['rendered']) ?? 'Not Found',
          ebookAuthor: result['author'] ?? 'Not Found',
          ebookCatList: ContentParser.categoriesList(e),
          ebookDesc:
              ContentParser.decodeHtml(result['description']!) ?? 'Not Found',
          ebookUrl: result['downloadUrl'] ?? 'Not Found',
          ebookImage: result['imageUrl'] ?? 'Not Found',
        );
      }).toList();
      return ebookModelList;
    } catch (e) {
      if (e is SocketException) {
        throw Exception('No internet connection');
      }
      rethrow;
    }
  }
}
