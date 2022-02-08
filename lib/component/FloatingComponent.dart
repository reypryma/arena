import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:mightyweb/main.dart';
import 'package:mightyweb/model/MainResponse.dart';
import 'package:mightyweb/screen/WebScreen.dart';
import 'package:mightyweb/utils/AppWidget.dart';
import 'package:mightyweb/utils/ExpantableFloating.dart';
import 'package:mightyweb/utils/constant.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class FloatingComponent extends StatefulWidget {
  static String tag = '/FloatingComponent';

  @override
  FloatingComponentState createState() => FloatingComponentState();
}

class FloatingComponentState extends State<FloatingComponent> {
  late List<FloatingButton> mFloatingList;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    //
    Iterable mFloating = jsonDecode(getStringAsync(FLOATING_DATA));
    mFloatingList = mFloating.map((model) => FloatingButton.fromJson(model)).toList();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Widget mCircleWidget() {
    return ExpandableFab(
      distance: 112.0,
      children: [
        for (int i = 0; i < mFloatingList.length; i++)
          ActionButton(
            icon: mFloatingList[i].image,
            onPressed: () {
              if (mFloatingList[i].url!.contains("linkedin.com") ||
                  mFloatingList[i].url!.contains("market://") ||
                  mFloatingList[i].url!.contains("whatsapp://") ||
                  mFloatingList[i].url!.contains("truecaller://") ||
                  // url.contains("facebook.com") ||
                  mFloatingList[i].url!.contains("twitter.com") ||
                  mFloatingList[i].url!.contains("pinterest.com") ||
                  mFloatingList[i].url!.contains("snapchat.com") ||
                  mFloatingList[i].url!.contains("instagram.com") ||
                  mFloatingList[i].url!.contains("play.google.com") ||
                  mFloatingList[i].url!.contains("mailto:") ||
                  mFloatingList[i].url!.contains("tel:") ||
                  mFloatingList[i].url!.contains("share=telegram") ||
                  mFloatingList[i].url!.contains("messenger.com")) {
                // url = Uri.encodeFull(mFloatingList[i].url!);
                try {
                  launch(mFloatingList[i].url!);
                } catch (e) {
                  launch(mFloatingList[i].url!);
                }
              } else {
                WebScreen(mHeading: mFloatingList[i].title, mInitialUrl: mFloatingList[i].url).launch(context, isNewTask: true);
              }
            },
          )
      ],
    );
  }

  Widget mMenuWidget(BuildContext context) {
    return SpeedDial(
      // marginEnd: 18,
      // marginBottom: 20,
      icon: Icons.add,
      activeIcon: Icons.close_sharp,
      child: cachedImage(getStringAsync(FLOATING_LOGO), color: white).paddingAll(16),
      // buttonSize: 52,
      visible: true,
      closeManually: true,
      useRotationAnimation: true,
      renderOverlay: false,
      curve: Curves.bounceIn,
      overlayOpacity: 0.5,
      backgroundColor: appStore.primaryColors,
      foregroundColor: white,
      shape: CircleBorder(),
      children: [
        for (int i = 0; i < appStore.mFABList.length; i++)
          SpeedDialChild(
            child: Material(
              shape: CircleBorder(),
              color: context.scaffoldBackgroundColor,
              clipBehavior: Clip.antiAlias,
              elevation: 4.0,
              child: cachedImage(mFloatingList[i].image, width: 20, height: 20, color: context.iconColor).paddingAll(10),
            ),
            label: mFloatingList[i].title,
            labelStyle: primaryTextStyle(),
            labelBackgroundColor: context.scaffoldBackgroundColor,
            onTap: () {
              if (mFloatingList[i].url!.contains("linkedin.com") ||
                  mFloatingList[i].url!.contains("market://") ||
                  mFloatingList[i].url!.contains("whatsapp://") ||
                  mFloatingList[i].url!.contains("truecaller://") ||
                  // url.contains("facebook.com") ||
                  mFloatingList[i].url!.contains("twitter.com") ||
                  mFloatingList[i].url!.contains("pinterest.com") ||
                  mFloatingList[i].url!.contains("snapchat.com") ||
                  mFloatingList[i].url!.contains("instagram.com") ||
                  mFloatingList[i].url!.contains("play.google.com") ||
                  mFloatingList[i].url!.contains("mailto:") ||
                  mFloatingList[i].url!.contains("tel:") ||
                  mFloatingList[i].url!.contains("share=telegram") ||
                  mFloatingList[i].url!.contains("messenger.com")) {
                try {
                  launch(mFloatingList[i].url!);
                } catch (e) {
                  launch(mFloatingList[i].url!);
                }
              } else {
                WebScreen(mHeading: mFloatingList[i].title, mInitialUrl: mFloatingList[i].url).launch(context, isNewTask: true);
              }
            },
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return getStringAsync(FLOATING_STYLE) == "regular" ? mMenuWidget(context) : mMenuWidget(context);
  }
}
