import 'package:flutter/material.dart';
import 'package:mightyweb/app_localizations.dart';
import 'package:mightyweb/component/AppThemeSetUpScreen.dart';
import 'package:mightyweb/component/LoaderSetUpScreen.dart';
import 'package:mightyweb/main.dart';
import 'package:mightyweb/screen/HomeScreen.dart';
import 'package:mightyweb/utils/common.dart';
import 'package:mightyweb/utils/constant.dart';
import 'package:nb_utils/nb_utils.dart';

class SetUpScreen extends StatefulWidget {
  static String tag = '/SetUpScreen';

  @override
  SetUpScreenState createState() => SetUpScreenState();
}

class SetUpScreenState extends State<SetUpScreen> {
  TextEditingController mBaseUrlCont = TextEditingController();

  String mBaseUrl = "";
  String? loaderValue;

  bool? isFullScreen;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    //
    loaderValue = getStringAsync(LOADER_STYLE).isNotEmpty ? getStringAsync(LOADER_STYLE) : 'RotatingPlane';
    mBaseUrl = getStringAsync(URL);
    mBaseUrlCont.text = mBaseUrl;
    isFullScreen = false;
  }

  @override
  void dispose() {
    if (Uri.parse(mBaseUrlCont.text).isAbsolute) {
      setValue(URL, mBaseUrlCont.text);
    } else {
      toast("Enter Valid URL");
    }
    super.dispose();
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
        title: Text(appLocalization.translate('lbl_set_up')!, style: boldTextStyle(color: white, size: 18)),
        leading: IconButton(
          icon: Icon(Icons.chevron_left_sharp, color: white),
          onPressed: () {
            finish(context);
          },
        ),
        elevation: 0,
        actions: [
          IconButton(
              icon: Icon(Icons.done),
              onPressed: () async {
                if (Uri.parse(mBaseUrlCont.text).isAbsolute) {
                  setValue(URL, mBaseUrlCont.text);
                  if (isFullScreen == true) {
                    await setValue(NAVIGATIONSTYLE, NAVIGATION_STYLE_FULL_SCREEN);
                  }
                  Navigator.pop(context);
                  HomeScreen().launch(context);
                } else {
                  toast(appLocalization.translate('error_valid_url'));
                }
              })
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            16.height,
            Text(appLocalization.translate('lbl_baseUrl')!, style: boldTextStyle(size: 20)).paddingLeft(16),
            16.height,
            AppTextField(
                    controller: mBaseUrlCont,
                    textStyle: primaryTextStyle(),
                    decoration: InputDecoration(
                      hintText: appLocalization.translate('hint_enter_base_url'),
                      border: InputBorder.none,
                      filled: true,
                      isDense: true,
                      fillColor: Theme.of(context).cardTheme.color,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 0.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 0.5),
                      ),
                    ),
                    textFieldType: TextFieldType.OTHER)
                .paddingOnly(left: 16, right: 16),
            16.height,
            Row(
              children: [
                CustomTheme(
                  child: Checkbox(
                    focusColor: appStore.primaryColors,
                    activeColor: appStore.primaryColors,
                    value: isFullScreen,
                    onChanged: (bool? value) async {
                      isFullScreen = value;
                      setState(() {});
                    },
                  ),
                ),
                Text("Enable Full Screen", style: secondaryTextStyle(size: 16))
              ],
            ),
            LoaderSetUpScreen(
              onTap: (String a) async {
                loaderValue = a;
                await setValue(IS_FROM_TRY_WEBSITE, true);
                await setValue(LOADER_STYLE, a);
                appStore.setLoader(a);
                setState(() {});
              },
            ),
            AppThemeSetUpScreen(
              onTap: (String a) async {
                await setValue(IS_FROM_TRY_WEBSITE, true);
                await setValue(THEME_STYLE, a);
                appStore.setPrimaryColor(hexStringToHexInt(a));
                setStatusBarColor(appStore.primaryColors, statusBarBrightness: Brightness.light);
                setState(() {});
              },
            )
          ],
        ),
      ),
    );
  }
}
