import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mightyweb/main.dart';
import 'package:mightyweb/model/MainResponse.dart' as model1;
import 'package:mightyweb/utils/AppWidget.dart';
import 'package:mightyweb/utils/constant.dart';
import 'package:nb_utils/nb_utils.dart';
import '../app_localizations.dart';
import 'DashboardScreen.dart';

class WalkThroughScreen2 extends StatefulWidget {
  static String tag = '/WalkThroughScreen2';

  @override
  WalkThroughScreen2State createState() => WalkThroughScreen2State();
}

class WalkThroughScreen2State extends State<WalkThroughScreen2> {
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
      body: Stack(
        children: [
          Column(
            children: [
              70.height,
              Container(
                height: context.height() * 0.5,
                child: PageView.builder(
                  controller: pageController,
                  scrollDirection: Axis.horizontal,
                  itemCount: mWalkList.length,
                  itemBuilder: (context, index) {
                    return AnimatedContainer(
                      duration: 500.milliseconds,
                      height: index == position ? context.height() * 0.5 : context.height() * 0.45,
                      margin: EdgeInsets.only(left: 16, right: 16),
                      child: cachedImage(mWalkList[position].image, fit: BoxFit.fitHeight, width: context.width()).cornerRadiusWithClipRRect(16),
                    );
                  },
                  onPageChanged: (value) {
                    setState(() {
                      position = value;
                    });
                  },
                ),
              ),
              20.height,
              DotIndicator(pageController: pageController, pages: mWalkList, indicatorColor: appStore.primaryColors),
              16.height,
              Text(mWalkList[position].title!, style: boldTextStyle(size: 20)).paddingOnly(left: 16, right: 16),
              16.height,
              Text(mWalkList[position].subtitle!, style: secondaryTextStyle(), textAlign: TextAlign.center).paddingOnly(left: 16, right: 16),
              16.height,
            ],
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppButton(
                  width: context.width(),
                  height: 60,
                  text: appLocalization.translate('lbl_skip')!,
                  textStyle: boldTextStyle(),
                  shapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  elevation: 0,
                  onTap: () async {
                    await setValue(IS_FIRST_TIME, false);
                    DashBoardScreen().launch(context, isNewTask: true);
                  },
                  color: grey.withOpacity(0.1),
                  hoverColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                ).expand(flex: 1),
                16.width,
                AppButton(
                  width: context.width(),
                  text: position == (mWalkList.length - 1) ? appLocalization.translate('lbl_finish')! : appLocalization.translate('lbl_next')!,
                  height: 60,
                  elevation: 0,
                  shapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  color: appStore.primaryColors,
                  textStyle: boldTextStyle(color: white),
                  onTap: () {
                    setState(() async {
                      if (position < mWalkList.length - 1) {
                        pageController.nextPage(duration: Duration(microseconds: 300), curve: Curves.linear);
                      } else if (position == (mWalkList.length - 1)) {
                        await setValue(IS_FIRST_TIME, false);
                        DashBoardScreen().launch(context, isNewTask: true);
                      }
                    });
                  },
                ).expand(flex: 1),
              ],
            ),
          ),
        ],
      ).withHeight(context.height()),
    );
  }
}
