import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mightyweb/main.dart';
import 'package:mightyweb/model/MainResponse.dart';
import 'package:mightyweb/utils/AppWidget.dart';
import 'package:mightyweb/utils/colors.dart';
import 'package:mightyweb/utils/constant.dart';
import 'package:nb_utils/nb_utils.dart';

import 'DashboardScreen.dart';
import 'WalkThroughScreen1.dart';
import 'WalkThroughScreen2.dart';
import 'WalkThroughScreen3.dart';
import 'package:mightyweb/model/MainResponse.dart' as model1;

class SplashScreen extends StatefulWidget {
  static String tag = '/SplashScreen2';

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  SplashConfiguration splashConfiguration = SplashConfiguration();
  List<model1.Walkthrough> mWalkList = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    setStatusBarColor(appStore.primaryColors, statusBarBrightness: Brightness.light);

    Iterable mMenu = jsonDecode(getStringAsync(WALKTHROUGH));
    mWalkList = mMenu.map((model) => model1.Walkthrough.fromJson(model)).toList();

    await Future.delayed(Duration(seconds: 2));

    if (getStringAsync(IS_WALKTHROUGH) == "true") {
      if (getBoolAsync(IS_FIRST_TIME, defaultValue: true)) {
        if (mWalkList.isNotEmpty) {
          if (getStringAsync(WALK_THROUGH_STYLE) == WALK_THROUGH_1)
            return WalkThroughScreen1().launch(context, isNewTask: true);
          else if (getStringAsync(WALK_THROUGH_STYLE) == WALK_THROUGH_2)
            return WalkThroughScreen2().launch(context, isNewTask: true);
          else
            return WalkThroughScreen3().launch(context, isNewTask: true);
        } else {
          DashBoardScreen().launch(context, isNewTask: true);
        }
      } else {
        DashBoardScreen().launch(context, isNewTask: true);
      }
    } else {
      DashBoardScreen().launch(context, isNewTask: true);
    }
    setState(() {});
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getStringAsync(SPLASH_ENABLE_BACKGROUND) == "true"
          ? Stack(
              alignment: Alignment.center,
              children: [
                cachedImage(getStringAsync(SPLASH_BACKGROUND_URL), fit: BoxFit.cover, width: context.width()),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    getStringAsync(SPLASH_ENABLE_LOGO).validate() != "false"
                        ? cachedImage(getStringAsync(SPLASH_LOGO_URL), fit: BoxFit.cover, height: 120, width: 120).cornerRadiusWithClipRRect(10)
                        : SizedBox(),
                    4.height,
                    getStringAsync(SPLASH_ENABLE_TITLE) != "false"
                        ? Text(getStringAsync(SPLASH_TITLE), style: boldTextStyle(size: 20, color:  getColorFromHex(getStringAsync(SPLASH_TITLE_COLOR), defaultColor: primaryColor1)))
                        : SizedBox(),
                  ],
                ).center(),
              ],
            )
          : Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    getColorFromHex(getStringAsync(SPLASH_FIRST_COLOR), defaultColor: primaryColor1),
                    getColorFromHex(getStringAsync(SPLASH_SECOND_COLOR), defaultColor: primaryColor1),
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  getStringAsync(SPLASH_ENABLE_LOGO) != "false" ? cachedImage(getStringAsync(SPLASH_LOGO_URL), fit: BoxFit.cover, height: 120, width: 120).cornerRadiusWithClipRRect(10) : SizedBox(),
                  getStringAsync(SPLASH_ENABLE_TITLE) != "false"
                      ? Text(getStringAsync(SPLASH_TITLE), style: boldTextStyle(size: 20, color:  getColorFromHex(getStringAsync(SPLASH_TITLE_COLOR), defaultColor: primaryColor1)))
                      : SizedBox(),
                ],
              ).center(),
            ),
    );
  }
}
