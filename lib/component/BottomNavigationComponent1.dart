import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mightyweb/main.dart';
import 'package:mightyweb/model/MainResponse.dart' as model1;
import 'package:mightyweb/utils/AppWidget.dart';
import 'package:mightyweb/utils/constant.dart';
import 'package:nb_utils/nb_utils.dart';

// ignore: must_be_immutable
class BottomNavigationComponent1 extends StatefulWidget {
  static String tag = '/BottomNavigationComponent1';

  @override
  BottomNavigationComponent1State createState() => BottomNavigationComponent1State();
}

class BottomNavigationComponent1State extends State<BottomNavigationComponent1> {
  late List<model1.MenuStyle> mBottomMenuList;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    //
    if(getStringAsync(BOTTOMMENU).isNotEmpty){
      Iterable mBottom = jsonDecode(getStringAsync(BOTTOMMENU));
      mBottomMenuList = mBottom.map((model) => model1.MenuStyle.fromJson(model)).toList();
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        backgroundColor: context.cardColor,
        type: BottomNavigationBarType.shifting,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        currentIndex: appStore.currentIndex,
        unselectedItemColor: textSecondaryColorGlobal,
        unselectedLabelStyle: secondaryTextStyle(),
        selectedLabelStyle: secondaryTextStyle(color: textPrimaryColorGlobal),
        selectedItemColor: appStore.primaryColors,
        items: [
          for (int i = 0; i < appStore.mBottomNavigationList.length; i++)
            BottomNavigationBarItem(
              icon: cachedImage(mBottomMenuList[i].image, width: 20, height: 20, color: Theme.of(context) .textTheme.subtitle1!.color),
              activeIcon: cachedImage(mBottomMenuList[i].image, width: 20, height: 20, color: appStore.primaryColors),
              label: mBottomMenuList[i].title.toString(),
            )
        ],
        onTap: (index) {
          setState(() {
            appStore.currentIndex = index;
            appStore.setIndex(index);
          });
        });
  }
}
