import 'package:booknest/core/util/helper.dart';
import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  static const List<Map<String, String>> sections = [
    {
      'title': '1. Educational Purpose',
      'content':
          'BookNest is an educational application designed to help students, teachers, and readers discover and read educational materials. The app is intended for educational and informational purposes only.',
    },
    {
      'title': '2. Content Ownership and Copyright',
      'content':
          'BookNest does not claim ownership of books, documents, trademarks, or other materials belonging to their respective authors, publishers, or copyright holders. All rights remain with their respective owners.',
    },
    {
      'title': '3. Open-Source Project',
      'content':
          'BookNest is an open-source project intended to support learning and educational access. The open-source availability of the application does not mean that third-party books or copyrighted materials are open source or freely licensed.',
    },
    {
      'title': '4. Third-Party Content',
      'content':
          'Some book information, links, or materials may originate from third-party websites or sources. BookNest does not necessarily host, own, endorse, or control such content. Users should review the applicable terms and licenses of the original sources.',
    },
    {
      'title': '5. Copyright Concerns',
      'content':
          'If you are a copyright owner or authorized representative and believe that material accessible through BookNest infringes your rights, please contact the app developer with relevant details so the matter can be reviewed and appropriate action considered.',
    },
    {
      'title': '6. User Responsibility',
      'content':
          'Users are responsible for ensuring that their access to, download of, and use of any material complies with applicable copyright laws, licenses, and the terms of the original source.',
    },
    {
      'title': '7. Privacy',
      'content':
          'BookNest aims to respect users’ privacy. Any personal information collected by the app, if applicable, should be handled according to the app’s actual data practices.',
    },
    {
      'title': '8. Changes to This Policy',
      'content':
          'This Privacy Policy may be updated as BookNest develops. Any revised version will be published in the application.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Helper.primaryColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Helper.primaryColor,
        title: Text(
          'Privacy Policy',
          style: TextStyle(fontFamily: Helper.cinzelFont),
        ),
      ),
      body: Column(
        children: [
          Divider(color: Helper.loadingColor),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  'BookNest Privacy Policy',
                  style: TextStyle(
                    fontFamily: Helper.cinzelFont,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Last updated: October 12, 2026',
                  style: TextStyle(
                    fontFamily: Helper.rubikFont,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
                ...sections.map(
                  (section) => Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          section['title']!,
                          style: TextStyle(
                            fontFamily: Helper.cinzelFont,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          section['content']!,
                          style: TextStyle(
                            fontFamily: Helper.rubikFont,
                            fontSize: 14,
                            height: 1.6,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
