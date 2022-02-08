import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mightyweb/main.dart';
import 'package:mightyweb/model/MainResponse.dart';
import 'package:mightyweb/utils/AppWidget.dart';
import 'package:mightyweb/utils/constant.dart';
import 'package:nb_utils/nb_utils.dart';

class TabBarComponent extends StatefulWidget {
  static String tag = '/TabBarComponent';

  @override
  TabBarComponentState createState() => TabBarComponentState();
}

class TabBarComponentState extends State<TabBarComponent> {
  String? mTabBarStyle;
  int? mTabIndex = 0;
  List<TabsResponse> mTabList = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    //
    Iterable mTabs = jsonDecode(getStringAsync(TABS));
    mTabList = mTabs.map((model) => TabsResponse.fromJson(model)).toList();
    mTabBarStyle = getStringAsync(TAB_BAR_STYLE);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Widget mSimpleTabBar() {
    return TabBar(
      indicatorColor: white,
      labelColor: white,
      labelStyle: primaryTextStyle(),
      unselectedLabelStyle: secondaryTextStyle(size: 16),
      tabs: [for (int i = 0; i < mTabList.length; i++) Tab(text: mTabList[i].title)],
    );
  }

  Widget mTabBarWithIcon() {
    return TabBar(
      indicatorColor: white,
      onTap: (value) {
        mTabIndex = value;
        setState(() {});
      },
      tabs: [
        for (int i = 0; i < mTabList.length; i++) Tab(icon: cachedImage(mTabList[i].image, color: mTabIndex == i ? white : Colors.grey.shade500, height: 20, width: 20)),
      ],
    );
  }

  Widget mTabBarWithIconText() {
    return TabBar(
      indicatorColor: white,
      isScrollable: true,
      physics: BouncingScrollPhysics(),
      onTap: (value) {
        mTabIndex = value;
        setState(() {});
      },
      tabs: [
        for (int i = 0; i < mTabList.length; i++)
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                cachedImage(mTabList[i].image, color: mTabIndex == i ? white : Colors.grey.shade500, height: 16, width: 16),
                6.width,
                Text(mTabList[i].title.toString(), maxLines: 1, style: mTabIndex == i ? primaryTextStyle(color: white) : secondaryTextStyle(size: 16, color: Colors.grey.shade500)).center(),
              ],
            ),
          )
      ],
    );
  }

  Widget mLoadTabBar() {
    if (mTabBarStyle == SIMPLE_TAB)
      return mSimpleTabBar();
    else if (mTabBarStyle == TAB_WITH_ICON)
      return mTabBarWithIcon();
    else
      return mTabBarWithIconText();
  }

  @override
  Widget build(BuildContext context) {
    return mLoadTabBar();
  }
}
