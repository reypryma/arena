import 'package:flutter/material.dart';
import 'package:mightyweb/app_localizations.dart';
import 'package:mightyweb/main.dart';
import 'package:mightyweb/utils/common.dart';
import 'package:mightyweb/utils/constant.dart';
import 'package:nb_utils/nb_utils.dart';

class AppThemeSetUpScreen extends StatefulWidget {
  static String tag = '/AppThemeSetUpScreen';
  final Function? onTap;

  AppThemeSetUpScreen({this.onTap});

  @override
  AppThemeSetUpScreenState createState() => AppThemeSetUpScreenState();
}

class AppThemeSetUpScreenState extends State<AppThemeSetUpScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    var appLocalization = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(appLocalization.translate('lbl_themeStyle')!, style: boldTextStyle(size: 20)),
        16.height,
        Wrap(
          runSpacing: 16,
          spacing: 16,
          children: colorName.map((data) {
            return FittedBox(
              child: itemWidget(
                  data1: data,
                  code: colorName.indexOf(data),
                  onTap: () {
                    setValue(THEME_VARIANT, colorName.indexOf(data));
                    widget.onTap!.call(data);
                    setState(() {});
                  }),
            );
          }).toList(),
        ),
      ],
    ).paddingAll(16);
  }

  Widget itemWidget({required Function onTap, int code = 0, required String data1}) {
    return Container(
      height: 70,
      width: context.width()*0.199,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: boxDecorationWithShadow(borderRadius: radius(8), backgroundColor: hexStringToHexInt(data1)),
            height: 70,
            padding: EdgeInsets.all(32),
          ),
          AnimatedContainer(
            decoration: boxDecorationWithRoundedCorners(
              borderRadius: radius(8),
              backgroundColor: getIntAsync(THEME_VARIANT, defaultValue: 0) == code ? Colors.black38 : Colors.transparent,
            ),
            duration: Duration(milliseconds: 800),
          ),
          Align(
            alignment: Alignment.center,
            child: AnimatedContainer(
              padding: EdgeInsets.all(4),
              duration: Duration(milliseconds: 800),
              child: Icon(Icons.check, size: 18, color: appStore.primaryColors),
              decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: defaultBoxShadow()),
            ).visible(getIntAsync(THEME_VARIANT, defaultValue: 0) == code),
          ),
        ],
      ).onTap(() async {
        onTap.call();
      }),
    );
  }
}
