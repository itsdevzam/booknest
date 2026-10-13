import 'package:html/parser.dart' as html;

class ContentParser {
  static Map<String, String> parseEbookContent(String content) {
    final document = html.parse(content);

    // Author
    String author = '';
    final strong = document.querySelector('strong');

    if (strong != null) {
      author = strong.text.replaceFirst('by ', '').trim();
    }

    // Image
    String imageUrl = '';
    final image = document.querySelector('img');

    if (image != null) {
      imageUrl = image.attributes['src'] ?? '';
    }

    // Download URL
    String downloadUrl = '';

    for (final link in document.querySelectorAll('a')) {
      final href = link.attributes['href'] ?? '';

      if (href.contains('vetbooks.top')) {
        downloadUrl = href;
        break;
      }
    }

    // Description
    String description = '';

    final paragraphs = document.querySelectorAll('p');

    if (paragraphs.isNotEmpty) {
      final firstParagraph = paragraphs.first;

      // Remove author
      firstParagraph.querySelector('strong')?.remove();

      // Remove image/link containing image
      firstParagraph.querySelector('img')?.parent?.remove();

      // Get remaining text
      description = firstParagraph.text.trim();

      // Remove date from beginning
      description = description
          .replaceFirst(RegExp(r'^[A-Za-z]+\s+\d{4}'), '')
          .trim();
    }

    return {
      'author': author,
      'imageUrl': imageUrl,
      'downloadUrl': downloadUrl,
      'description': description,
    };
  }

  // Get category names from _embedded
  static List<String> categoriesList(Map<String, dynamic> post) {
    final embedded = post['_embedded'];

    if (embedded == null) {
      return [];
    }

    final terms = embedded['wp:term'];

    if (terms == null || terms.isEmpty) {
      return [];
    }

    final categories = terms[0] as List;

    return categories
        .map<String>((category) => decodeHtml(category['name']) ?? 'Not Found')
        .toList();
  }

  static String? decodeHtml(String text) {
    return html.parseFragment(text).text;
  }
}
