import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mightyweb/component/TabBarComponent.dart';
import 'package:mightyweb/main.dart';
import 'package:mightyweb/model/MainResponse.dart';
import 'package:mightyweb/screen/WebScreen.dart';
import 'package:mightyweb/utils/AppWidget.dart';
import 'package:mightyweb/utils/colors.dart';
import 'package:mightyweb/utils/constant.dart';
import 'package:nb_utils/nb_utils.dart';

class AppBarComponent extends StatefulWidget {
  static String tag = '/AppBarComponent';

  final Function? onTap;

  AppBarComponent({this.onTap});

  @override
  AppBarComponentState createState() => AppBarComponentState();
}

class AppBarComponentState extends State<AppBarComponent> {
  late List<Righticon> mRightIconList = [];
  late List<Lefticon> mLeftIconList = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    //
    Iterable mRight = jsonDecode(getStringAsync(RIGHTICON));
    mRightIconList = mRight.map((model) => Righticon.fromJson(model)).toList();
      
    Iterable mLeft = jsonDecode(getStringAsync(LEFTICON));
    mLeftIconList = mLeft.map((model) => Lefticon.fromJson(model)).toList();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Widget mAppBarLeft() {
    if (getStringAsync(NAVIGATIONSTYLE) == NAVIGATION_STYLE_SIDE_DRAWER) {
      return IconButton(
        icon: Icon(Icons.menu_rounded),
        onPressed: () => Scaffold.of(context).openDrawer(),
      );
    } else if (getStringAsync(NAVIGATIONSTYLE) == NAVIGATION_STYLE_TAB_BAR) {
      return SizedBox();
    } else {

      if (mLeftIconList.isNotEmpty ) {

        return ListView.builder(
          itemCount: mLeftIconList.length,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          padding: EdgeInsets.only(right: 6),
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            Lefticon mLeftIconModel = mLeftIconList[index];
            return setLeftIcon(mLeftIconModel).visible(mLeftIconModel.status == "1").onTap(() {
              if (mLeftIconModel.type == "event") {
                if (mLeftIconModel.value == LEFT_ICON_BACK_1) {
                  widget.onTap!.call(LEFT_ICON_BACK_1);
                } else if (mLeftIconModel.value == LEFT_ICON_BACK_2) {
                  widget.onTap!.call(LEFT_ICON_BACK_2);
                } else if (mLeftIconModel.value == LEFT_ICON_HOME) {
                  widget.onTap!.call(LEFT_ICON_HOME);
                } else if (mLeftIconModel.value == LEFT_ICON_CLOSE) {
                  widget.onTap!.call(LEFT_ICON_CLOSE);
                }
              } else {
                WebScreen(mHeading: mLeftIconModel.title, mInitialUrl: mLeftIconModel.url).launch(context, isNewTask: true);
              }
            });
          },
        );
      }
      else{
        return Container();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: appStore.primaryColors,
      leadingWidth: getStringAsync(NAVIGATIONSTYLE) == NAVIGATION_STYLE_TAB_BAR || getStringAsync(NAVIGATIONSTYLE) == NAVIGATION_STYLE_BOTTOM_NAVIGATION ? 40 : 50,
      centerTitle: getStringAsync(HEADERSTYLE) == HEADER_STYLE_CENTER ? true : false,
      title: getStringAsync(HEADERSTYLE) == HEADER_STYLE_EMPTY ? Text("") : Text(getStringAsync(APPNAME), style: boldTextStyle(color: white, size: 18)),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              getColorFromHex(getStringAsync(GRADIENT1), defaultColor: primaryColor1),
              getColorFromHex(getStringAsync(GRADIENT2), defaultColor: primaryColor1),
            ],
          ),
        ),
      ).visible(getStringAsync(THEME_STYLE) == THEME_STYLE_GRADIENT),
      leading: mAppBarLeft(),
      titleSpacing: 0,
      automaticallyImplyLeading: true,
      bottom: getStringAsync(NAVIGATIONSTYLE) == NAVIGATION_STYLE_TAB_BAR && appStore.mTabList.length!=0
          ? PreferredSize(preferredSize: Size.fromHeight(20.0), child: TabBarComponent())
          : PreferredSize(preferredSize: Size.fromHeight(0.0), child: SizedBox()),
      actions: [
        mRightIconList.isNotEmpty && mRightIconList!=null
            ? ListView.builder(
                itemCount: mRightIconList.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  Righticon mRightIconModel = mRightIconList[index];
                  return setRightIcon(mRightIconModel).visible(mRightIconModel.status == "1").onTap(() {
                    if (mRightIconModel.type == "event") {
                      if (mRightIconModel.value == RIGHT_ICON_RELOAD) {
                        widget.onTap!.call(RIGHT_ICON_RELOAD);
                      } else if (mRightIconModel.value == RIGHT_ICON_SHARE) {
                        widget.onTap!.call(RIGHT_ICON_SHARE);
                      } else if (mRightIconModel.value == RIGHT_ICON_CLOSE) {
                        widget.onTap!.call(RIGHT_ICON_CLOSE);
                      }
                    } else {
                      WebScreen(mHeading: mRightIconModel.title, mInitialUrl: mRightIconModel.url).launch(context, isNewTask: true);
                    }
                  });
                },
              )
            : SizedBox(),
      ],
    );
  }
}
