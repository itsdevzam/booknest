import 'package:booknest/core/util/helper.dart';
import 'package:booknest/core/widget/universal_dialog.dart';
import 'package:booknest/features/categories/CategoriesScreen.dart';
import 'package:booknest/features/home/HomeScreen.dart';
import 'package:booknest/features/search/SearchScreen.dart';
import 'package:booknest/features/settings/SettingsScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

int index = 0;

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        showDialog(
          context: context,
          builder: (context) => UniversalDialog(
            confirmButtonText: 'Yes',
            otherButtonText: 'No',
            confirmAction: () => SystemNavigator.pop(),
            otherAction: () => Navigator.pop(context),
            title: 'Are you sure you wnat to close the App?',
          ),
        );
        if (didPop) return;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Expanded(
              child: IndexedStack(
                index: index,
                children: [
                  HomeScreen(),
                  SearchScreen(),
                  CategoriesScreen(),
                  SettingsScreen(),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Helper.primaryColor,

                border: Border.all(color: Colors.grey),
              ),
              child: MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: NavigationBar(
                  // maintainBottomViewPadding: true,
                  backgroundColor: Colors.white30,
                  labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
                  onDestinationSelected: (value) => setState(() {
                    index = value;
                  }),
                  selectedIndex: index,
                  destinations: [
                    NavigationDestination(
                      icon: Icon(Iconsax.home, size: 18),
                      label: 'Home',
                    ),
                    NavigationDestination(
                      icon: Icon(Iconsax.search_normal, size: 18),
                      label: 'Search',
                    ),
                    NavigationDestination(
                      icon: Icon(Iconsax.category, size: 18),
                      label: 'Categories',
                    ),
                    NavigationDestination(
                      icon: Icon(Iconsax.setting, size: 18),
                      label: 'Settings',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
