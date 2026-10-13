import 'dart:io';

import 'package:booknest/core/util/helper.dart';
import 'package:booknest/core/widget/WhiteDot.dart';
import 'package:booknest/core/widget/universal_dialog.dart';
import 'package:booknest/features/settings/widget/SettingsItem.dart';
import 'package:booknest/features/settings/widget/privacy_policy.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: Helper.linearGradient),
        child: Stack(
          children: [
            Positioned(top: 130, left: 0, child: WhiteDot(num: 1)),
            Positioned(bottom: 130, right: 0, child: WhiteDot(num: 2)),
            Positioned.fill(
              top: 0,
              left: 0,
              right: 0,
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  top: MediaQuery.viewPaddingOf(context).top + 50,
                  bottom: 20,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    mainAxisAlignment: .center,
                    spacing: 10,
                    children: [
                      Image.asset(Helper.appIcon, height: 150, width: 150),

                      SettingsItem(
                        icon: Icons.delete_forever_outlined,
                        title: 'Clear Cache',
                        callback: () => showDialog(
                          context: context,
                          builder: (context) => UniversalDialog(
                            confirmButtonText: 'Yes',
                            otherButtonText: 'No',
                            confirmAction: () async {
                              final directory =
                                  await getApplicationDocumentsDirectory();
                              await for (final entity in directory.list()) {
                                if (entity is File) {
                                  await entity.delete();
                                }
                              }
                              Navigator.pop(context);
                            },
                            otherAction: () => Navigator.pop(context),
                            title: 'Are you sure?',
                            subTitle:
                                "Delete temporary Ebook data.\n Your downloads will stay safe.",
                          ),
                        ),
                      ),

                      SettingsItem(
                        icon: Iconsax.lock,
                        title: 'Privacy Policy',
                        callback: () =>
                            Helper().navigate(context, PrivacyPolicy()),
                      ),
                      SettingsItem(
                        icon: Iconsax.gift,
                        title: 'Github',
                        callback: () async {
                          if (!await launchUrl(
                            Uri.parse('https://github.com/itsdevzam'),
                          )) {
                            throw Exception('Could not launch url');
                          }
                        },
                      ),

                      SettingsItem(
                        icon: Iconsax.more,
                        title: 'More Apps',
                        callback: () async {
                          if (!await launchUrl(
                            Uri.parse(
                              'https://play.google.com/store/apps/developer?id=DevZam',
                            ),
                          )) {
                            throw Exception('Could not launch url');
                          }
                        },
                      ),
                      SettingsItem(
                        icon: Iconsax.personalcard,
                        title: 'Contact US',
                        callback: () => showDialog(
                          context: context,
                          builder: (context) => UniversalDialog(
                            confirmButtonText: 'Copy Email',
                            otherButtonText: 'Close',
                            confirmAction: () async => await Clipboard.setData(
                              const ClipboardData(text: 'itsdevzam@gmail.com'),
                            ),
                            otherAction: () => Navigator.pop(context),
                            title: 'Contact us',
                            subTitle: 'itsdevzam@gmail.com',
                          ),
                        ),
                      ),
                      SizedBox(),
                      Text(
                        'Made by DevZam',
                        style: TextStyle(fontFamily: Helper.cinzelFont),
                      ),
                      Text(
                        'For Educational Purpose Only',
                        style: TextStyle(fontFamily: Helper.rubikFont),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
