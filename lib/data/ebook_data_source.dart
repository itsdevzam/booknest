import 'package:booknest/core/util/helper.dart';
import 'package:http/http.dart' as http;

class EbookDataSource {
  //Fetch Homepage Ebooks
  Future<http.Response> fetchEbook({required int page}) async {
    return await http.get(
      Uri.parse(
        '${Helper.ebookDataSource}/wp-json/wp/v2/posts?page=$page&per_page=20&_embed=true',
      ),
    );
  }

  //Single Post Details
  Future<http.Response> singlePostDetail({required String postId}) async {
    return await http.get(
      Uri.parse('${Helper.ebookDataSource}/wp-json/wp/v2/posts/$postId'),
    );
  }

  //Search Ebook
  Future<http.Response> searchEbook({required String ebookName}) async {
    return await http.get(
      Uri.parse(
        '${Helper.ebookDataSource}/wp-json/wp/v2/posts',
      ).replace(queryParameters: {'search': ebookName, '_embed': 'true'}),
    );
  }

  //All Categories Id with Name
  Future<http.Response> allCatIdwithName() async {
    return await http.get(
      Uri.parse(
        '${Helper.ebookDataSource}/wp-json/wp/v2/categories?per_page=100&hide_empty=true',
      ),
    );
  }

  //Single Category All Posts
  Future<http.Response> singleCatAllPosts({
    required int catId,
    required int page,
  }) async {
    return await http.get(
      Uri.parse(
        '${Helper.ebookDataSource}/wp-json/wp/v2/posts?categories=$catId&page=$page&per_page=20&_embed=true',
      ),
    );
  }
}
