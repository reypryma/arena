import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mightyweb/main.dart';
import 'package:mightyweb/model/MainResponse.dart' as model1;
import 'package:mightyweb/utils/BubbleBotoomBar.dart';
import 'package:mightyweb/utils/constant.dart';
import 'package:nb_utils/nb_utils.dart';

// ignore: must_be_immutable
class BottomNavigationComponent2 extends StatefulWidget {
  static String tag = '/BottomNavigationComponent2';

  @override
  BottomNavigationComponent2State createState() => BottomNavigationComponent2State();
}

class BottomNavigationComponent2State extends State<BottomNavigationComponent2> {
  late List<model1.MenuStyle> mBottomMenuList;
  var currentIndex = 0;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    //
    Iterable mBottom = jsonDecode(getStringAsync(BOTTOMMENU));
    mBottomMenuList = mBottom.map((model) => model1.MenuStyle.fromJson(model)).toList();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return BubbleBottomBar(
      opacity: .2,

      currentIndex: currentIndex,
      backgroundColor: Theme.of(context).cardTheme.color,
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      elevation: 8,
      onTap: (index) {
        setState(() {
          appStore.currentIndex = index;
          appStore.setIndex(index);
          currentIndex = index;
        });
      },
      hasNotch: false,
      hasInk: true,
      inkColor: appStore.primaryColors,
      items: <BubbleBottomBarItem>[
        for (int i = 0; i < appStore.mBottomNavigationList.length; i++)
          tab(mBottomMenuList[i].image!, mBottomMenuList[i].title.toString(), context)],
    );
  }
}
