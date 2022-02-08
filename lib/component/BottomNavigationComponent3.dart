import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mightyweb/main.dart';
import 'package:mightyweb/model/MainResponse.dart' as model1;
import 'package:mightyweb/utils/AppWidget.dart';
import 'package:mightyweb/utils/constant.dart';
import 'package:nb_utils/nb_utils.dart';

// ignore: must_be_immutable
class BottomNavigationComponent3 extends StatefulWidget {
  static String tag = '/BottomNavigationComponent3';

  @override
  BottomNavigationComponent3State createState() => BottomNavigationComponent3State();
}

class BottomNavigationComponent3State extends State<BottomNavigationComponent3> {
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

  Widget tabItem(var pos, var icon) {
    return GestureDetector(
      onTap: () {
        setState(() {
          appStore.currentIndex = pos;
          appStore.setIndex(pos);
          currentIndex = pos;
        });
      },
      child: Container(
        width: 36,
        height: 36,
        alignment: Alignment.center,
        decoration: currentIndex == pos ? BoxDecoration(shape: BoxShape.circle, color: appStore.primaryColors.withOpacity(0.3)) : BoxDecoration(),
        child: cachedImage(
          icon,
          width: 20,
          height: 20,
          color: currentIndex == pos ? appStore.primaryColors : Theme.of(context).textTheme.subtitle1!.color,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.only(left: 16, right: 16,top:10,bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          for (int i = 0; i < mBottomMenuList.length; i++)
            tabItem(i, mBottomMenuList[i].image),
        ],
      ),
    );
  }
}
