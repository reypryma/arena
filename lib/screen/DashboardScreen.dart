import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mightyweb/component/BottomNavigationComponent1.dart';
import 'package:mightyweb/component/BottomNavigationComponent2.dart';
import 'package:mightyweb/component/BottomNavigationComponent3.dart';
import 'package:mightyweb/main.dart';
import 'package:mightyweb/model/MainResponse.dart';
import 'package:mightyweb/utils/constant.dart';
import 'package:nb_utils/nb_utils.dart';

import '../main.dart';
import 'HomeScreen.dart';

class DashBoardScreen extends StatefulWidget {
  static String tag = '/DashBoardScreen';

  final String? url;

  DashBoardScreen({this.url});

  @override
  DashBoardScreenState createState() => DashBoardScreenState();
}

class DashBoardScreenState extends State<DashBoardScreen> {
  late List<MenuStyle> mBottomMenuList;
  List<Widget> widgets = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    setStatusBarColor(appStore.primaryColors, statusBarBrightness: Brightness.light);

    Iterable mBottom = jsonDecode(getStringAsync(BOTTOMMENU));
    mBottomMenuList = mBottom.map((model) => MenuStyle.fromJson(model)).toList();
    if (getStringAsync(NAVIGATIONSTYLE) == NAVIGATION_STYLE_BOTTOM_NAVIGATION && mBottomMenuList.isNotEmpty && mBottomMenuList != null) {
      if (getStringAsync(NAVIGATIONSTYLE) == NAVIGATION_STYLE_BOTTOM_NAVIGATION) {
        for (int i = 0; i < appStore.mBottomNavigationList.length; i++) {
          widgets.add(HomeScreen(mUrl: mBottomMenuList[i].url));
        }
      }
    } else {
      widgets.add(HomeScreen());
    }

    log(appStore.currentIndex);
    setState(() {});
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget mBottomStyle() {
      if (getStringAsync(BOTTOM_NAVIGATION_STYLE) == BOTTOM_NAVIGATION_1)
        return BottomNavigationComponent3();
      else if (getStringAsync(BOTTOM_NAVIGATION_STYLE) == BOTTOM_NAVIGATION2)
        return BottomNavigationComponent2();
      else
        return BottomNavigationComponent1();
  }

  @override
  Widget build(BuildContext context) {
    return getStringAsync(NAVIGATIONSTYLE) == NAVIGATION_STYLE_BOTTOM_NAVIGATION && mBottomMenuList.isNotEmpty && mBottomMenuList != null
        ? SafeArea(
            child: Scaffold(
              backgroundColor: context.scaffoldBackgroundColor,
              bottomNavigationBar: getStringAsync(AD_MOB_BANNER_ID).isEmpty
                  ? mBottomStyle()
                  : Container(
                      height: 106,
                      child: Column(
                        children: [
                          Container(
                            height: 50,
                            child: AdWidget(
                              ad: BannerAd(
                                adUnitId: kReleaseMode ? getStringAsync(AD_MOB_BANNER_ID) : BannerAd.testAdUnitId,
                                size: AdSize.banner,
                                request: AdRequest(),
                                listener: BannerAdListener(),
                              )..load(),
                            ),
                          ),
                          Align(alignment: Alignment.bottomCenter, child: mBottomStyle())
                        ],
                      ),
                    ),
              body: Observer(
                builder: (_) => widgets[appStore.currentIndex],
              ),
            ),
          )
        : HomeScreen();
  }
}
