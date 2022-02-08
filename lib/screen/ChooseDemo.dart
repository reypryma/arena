import 'package:flutter/material.dart';
import 'package:mightyweb/app_localizations.dart';
import 'package:mightyweb/main.dart';
import 'package:mightyweb/model/ExampleModel.dart';
import 'package:mightyweb/screen/HomeScreen.dart';
import 'package:mightyweb/utils/AppWidget.dart';
import 'package:mightyweb/utils/constant.dart';
import 'package:nb_utils/nb_utils.dart';

class ChooseDemo extends StatefulWidget {
  static String tag = '/ChooseDemo';

  @override
  ChooseDemoState createState() => ChooseDemoState();
}

class ChooseDemoState extends State<ChooseDemo> {
  String mAppUrl = "";

  int? mSelectIndex;
  int? mSubSelectIndex;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
      mSelectIndex = getIntAsync(DETAIL_PAGE_VARIANT);
      mSubSelectIndex = getIntAsync(DETAIL_PAGE_VARIANT1);
    setState(() {});
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    var appLocalization = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: appStore.primaryColors,
        title: Text(appLocalization.translate('lbl_example')!, style: boldTextStyle(color: white, size: 18)),
        actions: [
          IconButton(
              icon: Icon(Icons.check, color: white),
              onPressed: () async {
                await setValue(IS_FROM_TRY_WEBSITE, true);
                await setValue(URL, mAppUrl);
                await setValue(DETAIL_PAGE_VARIANT, mSelectIndex!);
                await setValue(DETAIL_PAGE_VARIANT1, mSubSelectIndex!);
                Navigator.pop(context);
                HomeScreen().launch(context);
              })
        ],
        leading: IconButton(
          icon: Icon(Icons.chevron_left_sharp, color: white),
          onPressed: () async {
            Navigator.pop(context);
            HomeScreen().launch(context);
          },
        ),
        elevation: 0,
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context);
          HomeScreen().launch(context);
          return true;
        },
        child: SafeArea(
          child: ListView.builder(
            itemCount: mExample.length,
            itemBuilder: (context, i) {
              return ExpansionTile(
                title: Text(
                  mExample[i].title!,
                  style: boldTextStyle(),
                ),
                children: <Widget>[
                  Container(
                      height: 300,
                      margin: EdgeInsets.only(bottom: 16),
                      child: ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.only(left: 16),
                        scrollDirection: Axis.horizontal,
                        itemCount: mExample[i].contents!.length,
                        itemBuilder: (context, index) {
                          ExampleModel data = mExample[i].contents![index];
                          return itemWidget(
                              code: index,
                              title: data.title,
                              img: data.img,
                              index: i,
                              onTap: () async {
                                mSelectIndex = i;
                                mSubSelectIndex = index;
                                mAppUrl = data.url;
                                setState(() {});
                              });
                        },
                      )),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget itemWidget({required Function onTap, String? title, int code = 0, int? index, required String img}) {
    return Container(
      width: context.width() * 0.4,
      margin: EdgeInsets.only(right: 16),
      decoration: boxDecorationWithRoundedCorners(borderRadius: radius(10)),
      child: Stack(
        fit: StackFit.expand,
        children: [
          cachedImage("https://firebasestorage.googleapis.com/v0/b/mighty-web.appspot.com/o/$img?alt=media&token=cd5666c7-906d-411e-af01-c6cfa499f79d").cornerRadiusWithClipRRect(10),
          AnimatedContainer(
            decoration: boxDecorationWithRoundedCorners(borderRadius: radius(10), backgroundColor: (mSelectIndex == index && mSubSelectIndex == code) ? Colors.black12 : Colors.black45),
            duration: Duration(milliseconds: 800),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 800),
            child: Text(title.validate(), style: boldTextStyle(), textAlign: TextAlign.center),
            decoration: BoxDecoration(color: (mSelectIndex == index && mSubSelectIndex == code) ? context.scaffoldBackgroundColor : Colors.white54, borderRadius: radius(defaultRadius)),
            padding: EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
          ).center(),
          Positioned(
            bottom: 8,
            right: 8,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 800),
              padding: EdgeInsets.all(4),
              child: Icon(Icons.check, size: 18, color: appStore.primaryColors),
              decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: defaultBoxShadow()),
            ).visible(mSelectIndex == index && mSubSelectIndex == code),
          ),
        ],
      ),
    ).onTap(() async {
      onTap.call();
    });
  }
}
