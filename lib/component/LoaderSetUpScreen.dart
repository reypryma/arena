import 'package:flutter/material.dart';
import 'package:mightyweb/app_localizations.dart';
import 'package:mightyweb/main.dart';
import 'package:mightyweb/utils/constant.dart';
import 'package:mightyweb/utils/loader.dart';
import 'package:nb_utils/nb_utils.dart';

class LoaderSetUpScreen extends StatefulWidget {
  static String tag = '/LoaderSetUpScreen';
  final Function? onTap;

  LoaderSetUpScreen({this.onTap});

  @override
  LoaderSetUpScreenState createState() => LoaderSetUpScreenState();
}

class LoaderSetUpScreenState extends State<LoaderSetUpScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {}

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
        Text(appLocalization.translate('lbl_loaderStyle')!, style: boldTextStyle(size: 20)),
        16.height,
        Wrap(
          runSpacing: 16,
          spacing: 16,
          children: loaderName.map((data) {
            return FittedBox(
              child: itemWidget(data1: data, code: loaderName.indexOf(data), onTap: () async {
                await setValue(LOADER_VARIANT, loaderName.indexOf(data));
                widget.onTap!.call(data);
                setState(() {});
              }, ),
            );
          }).toList(),
        ),
      ],
    ).paddingAll(16);
  }

 Widget itemWidget({required Function onTap, int code = 0, String? data1}) {
    return Container(
      height: 70,
      width: context.width()*0.199,
      decoration: boxDecorationWithShadow(borderRadius: radius(8), backgroundColor: Theme.of(context).cardTheme.color!),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 80,
            decoration: boxDecorationWithShadow(borderRadius: radius(8), backgroundColor: Theme.of(context).cardTheme.color!),
            padding: EdgeInsets.all(16),
            child: Loaders(name: data1),
          ),
          AnimatedContainer(
            decoration: boxDecorationWithRoundedCorners(
              borderRadius: radius(8),
              backgroundColor: getIntAsync(LOADER_VARIANT, defaultValue: 0) == code ? Colors.black38 : Colors.transparent,
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
            ).visible(getIntAsync(LOADER_VARIANT, defaultValue: 0) == code),
          ),
        ],
      ).onTap(() async {
        onTap.call();
      }),
    );
  }
}

