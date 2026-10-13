import 'package:booknest/core/util/helper.dart';
import 'package:booknest/features/dashboard/DashboardScreen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: Helper.linearGradient),
        child: Center(
          child: Column(
            mainAxisAlignment: .center,
            spacing: 10,
            children: <Widget>[
              Image.asset(Helper.appIcon, width: 150),
              Text(
                Helper.appName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  fontFamily: Helper.cinzelFont,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration(seconds: 3),
      () => Helper().navigate(context, DashboardScreen(), canBack: false),
    );
  }
}
