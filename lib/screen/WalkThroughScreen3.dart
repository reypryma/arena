import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mightyweb/main.dart';
import 'package:mightyweb/utils/AppWidget.dart';
import 'package:mightyweb/utils/constant.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:mightyweb/model/MainResponse.dart' as model1;

import '../app_localizations.dart';
import 'DashboardScreen.dart';

class WalkThroughScreen3 extends StatefulWidget {
  static String tag = '/WalkThroughScreen3';

  @override
  WalkThroughScreen3State createState() => WalkThroughScreen3State();
}

class WalkThroughScreen3State extends State<WalkThroughScreen3> {
  var pageController = PageController();
  int position = 0;
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

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  width: context.width(),
                  height: context.height(),
                  child: PageView.builder(
                    controller: pageController,
                    itemCount: mWalkList.length,
                    itemBuilder: (context, i) {
                      return Stack(
                        children: [
                          cachedImage(mWalkList[i].image,height: context.height(), fit: BoxFit.cover),
                          Container(height: context.height(), color: black.withOpacity(0.4)),
                        ],
                      );
                    },
                    onPageChanged: (value) {
                      setState(() => position = value);
                    },
                  ),
                ),
                Positioned(
                  right: 20,
                  top: 40,
                  child: Text(appLocalization.translate('lbl_skip')!, style: primaryTextStyle(color: white)).onTap(() async {
                    await setValue(IS_FIRST_TIME, false);
                    DashBoardScreen().launch(context, isNewTask: true);
                  }),
                ),
                Positioned(
                  right: 16,
                  left: 16,
                  bottom:16,
                  child: AppButton(
                    width: context.width(),
                    onTap: () async {
                      await setValue(IS_FIRST_TIME, false);
                        DashBoardScreen().launch(context, isNewTask: true);
                    },
                    color: appStore.primaryColors,
                    textColor: Colors.white,
                    text: appLocalization.translate('lbl_get_start')!,
                  ),
                ).visible(position == (mWalkList.length - 1)),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(mWalkList[position].title!, style: boldTextStyle(size: 24, color: white)),
                    16.height,
                    Text(mWalkList[position].subtitle!, style: primaryTextStyle(color: white), textAlign: TextAlign.center),
                    32.height,
                    DotIndicator(pageController: pageController, pages: mWalkList, indicatorColor: white),
                    16.height,
                  ],
                ).paddingOnly(bottom: 70, right: 16, left: 16),
              ],
            ),
          ],
        ),
      ),
    );
  }
}