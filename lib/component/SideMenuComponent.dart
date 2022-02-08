import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mightyweb/app_localizations.dart';
import 'package:mightyweb/component/SubMenuComponent.dart';
import 'package:mightyweb/main.dart';
import 'package:mightyweb/model/MainResponse.dart' as model1;
import 'package:mightyweb/screen/AboutUsScreen.dart';
import 'package:mightyweb/screen/ChooseDemo.dart';
import 'package:mightyweb/screen/SetUpScreen.dart';
import 'package:mightyweb/utils/AppWidget.dart';
import 'package:mightyweb/utils/constant.dart';
import 'package:nb_utils/nb_utils.dart';

class SideMenuComponent extends StatefulWidget {
  final Function? onTap;

  SideMenuComponent({this.onTap});

  @override
  SideMenuComponentState createState() => SideMenuComponentState();
}

class SideMenuComponentState extends State<SideMenuComponent> {
  List<model1.MenuStyle> mMenuList = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    //
    Iterable mMenu = jsonDecode(getStringAsync(BOTTOMMENU));
    mMenuList = mMenu.map((model) => model1.MenuStyle.fromJson(model)).toList();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Widget mDrawerOption(String value, var icon, {Function? onTap}) {
    return SettingItemWidget(
      title: value,
      padding: EdgeInsets.only(top: 6, bottom: 8),
      trailing: Icon(Icons.chevron_right, color: Theme.of(context).iconTheme.color!.withOpacity(0.5)),
      titleTextStyle: primaryTextStyle(),
      leading: Icon(icon),
      onTap: () {
        onTap!.call();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var appLocalization = AppLocalizations.of(context)!;
    return Container(
      color: context.scaffoldBackgroundColor,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.height,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                cachedImage(getStringAsync(APPLOGO), height: 55, width: 55, fit: BoxFit.cover).cornerRadiusWithClipRRect(10),
                10.width,
                Text(getStringAsync(APPNAME), style: boldTextStyle(size: 18)).expand(),
              ],
            ),
            26.height,
            mDrawerOption(appLocalization.translate('lbl_home')!, Icons.home_filled, onTap: () {
              Navigator.pop(context);
              widget.onTap!.call();
            }).visible(EnableHome == true),
            Divider().visible(EnableDemo == true),
            mDrawerOption(appLocalization.translate('lbl_try_demo')!, Icons.settings, onTap: () {
              Navigator.pop(context);
              SetUpScreen().launch(context);
            }).visible(EnableDemo == true),
            Divider().visible(EnableDemo == true),
            mDrawerOption(appLocalization.translate('lbl_example')!, Icons.apps, onTap: () {
              ChooseDemo().launch(context, isNewTask: true);
            }).visible(EnableDemo == true),
            Divider().visible(getStringAsync(IS_SHOW_ABOUT) == "true"),
            mDrawerOption(appLocalization.translate('lbl_about_us')!, Icons.info, onTap: () {
              AboutUsScreen().launch(context, isNewTask: true);
            }).visible(getStringAsync(IS_SHOW_ABOUT) == "true"),
            Divider(),
            SettingItemWidget(
              title: appStore.isDarkModeOn! ? appLocalization.translate('lbl_light_mode')! : appLocalization.translate('lbl_dark_mode')!,
              padding: EdgeInsets.only(top: 6, bottom: 6),
              trailing: Switch(
                value: appStore.isDarkModeOn!,
                onChanged: (s) {
                  appStore.setDarkMode(aIsDarkMode: s);
                  setState(() {});
                },
              ).withHeight(24),
              titleTextStyle: primaryTextStyle(),
              leading: Icon(Icons.brightness_4_rounded),
            ).visible(EnableMode == true),
            Divider().visible(mMenuList.isNotEmpty),
            ListView.builder(
              itemCount: mMenuList.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, i) {
                return SubMenuComponent(mMenuList: mMenuList[i], i: i);
              },
            ),
          ],
        ).paddingAll(16),
      ),
    );
  }
}
