import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mightyweb/app_localizations.dart';
import 'package:mightyweb/main.dart';
import 'package:mightyweb/model/MainResponse.dart' as model1;
import 'package:mightyweb/screen/DashboardScreen.dart';
import 'package:mightyweb/utils/AppWidget.dart';
import 'package:mightyweb/utils/constant.dart';
import 'package:nb_utils/nb_utils.dart';

class WalkThroughScreen1 extends StatefulWidget {
  static String tag = '/WalkThroughScreen1';

  @override
  WalkThroughScreen1State createState() => WalkThroughScreen1State();
}

class WalkThroughScreen1State extends State<WalkThroughScreen1> {
  var pageController = PageController();
  int selectedIndex = 0;
  List<model1.Walkthrough> mWalkList = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    //
    Iterable mMenu = jsonDecode(getStringAsync(WALKTHROUGH));
    mWalkList = mMenu.map((model) => model1.Walkthrough.fromJson(model)).toList();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    var appLocalization = AppLocalizations.of(context)!;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            PageView(
              children: [
                for (int i = 0; i < appStore.mOnBoardList.length; i++)
                  Container(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        cachedImage(mWalkList[i].image, height: context.height() * 0.45).paddingAll(8),
                        Text(mWalkList[i].title!, style: boldTextStyle(size: 20)),
                        Text(mWalkList[i].subtitle!, textAlign: TextAlign.center, style: secondaryTextStyle()).paddingAll(8),
                      ],
                    ),
                  )
              ],
              controller: pageController,
              onPageChanged: (index) {
                selectedIndex = index;
                setState(() {});
              },
            ),
            AnimatedPositioned(
              duration: Duration(seconds: 1),
              bottom: 20,
              left: 0,
              right: 0,
              child: DotIndicator(
                pages: mWalkList,
                indicatorColor: appStore.primaryColors,
                pageController: pageController,
              ),
            ),
            Positioned(
              child: AnimatedCrossFade(
                firstChild: Container(
                  child: Text(appLocalization.translate('lbl_get_start')!, style: boldTextStyle(color: white)),
                  padding: EdgeInsets.fromLTRB(20, 8, 20, 8),
                  decoration: BoxDecoration(color: appStore.primaryColors, borderRadius: BorderRadius.circular(8)),
                ).onTap(() async {
                  await setValue(IS_FIRST_TIME, false);
                  DashBoardScreen().launch(context, isNewTask: true);
                }),
                secondChild: SizedBox(),
                duration: Duration(milliseconds: 300),
                firstCurve: Curves.easeIn,
                secondCurve: Curves.easeOut,
                crossFadeState: selectedIndex == (mWalkList.length - 1) ? CrossFadeState.showFirst : CrossFadeState.showSecond,
              ),
              bottom: 20,
              right: 20,
            ),
            Positioned(
              child: AnimatedContainer(
                duration: Duration(seconds: 1),
                child: Text(appLocalization.translate('lbl_skip')!, style: boldTextStyle(color: white)),
                padding: EdgeInsets.fromLTRB(20, 8, 20, 8),
                decoration: BoxDecoration(color: appStore.primaryColors, borderRadius: BorderRadius.circular(8)),
              ).onTap(() async {
                await setValue(IS_FIRST_TIME, false);
                DashBoardScreen().launch(context, isNewTask: true);
              }),
              left: 20,
              bottom: 20,
            ),
          ],
        ),
      ),
    );
  }
}
