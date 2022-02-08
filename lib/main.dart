import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mightyweb/AppTheme.dart';
import 'package:mightyweb/Store/AppStore.dart';
import 'package:mightyweb/app_localizations.dart';
import 'package:mightyweb/model/LanguageModel.dart';
import 'package:mightyweb/screen/DataScreen.dart';
import 'package:mightyweb/utils/common.dart';
import 'package:mightyweb/utils/constant.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'component/NoInternetConnection.dart';

AppStore appStore = AppStore();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HttpOverrides.global = HttpOverridesSkipCertificate();
  await initialize();
  await FlutterDownloader.initialize(debug: true);
  appStore.setDarkMode(aIsDarkMode: getBoolAsync(isDarkModeOnPref));
  appStore.setLanguage(getStringAsync(APP_LANGUAGE, defaultValue: 'en'));

  if (isMobile) {
    MobileAds.instance.initialize();
    await OneSignal.shared.setAppId(getStringAsync(ONESINGLE, defaultValue: mOneSignalID));
    OneSignal.shared.consentGranted(true);
    OneSignal.shared.promptUserForPushNotificationPermission();
  }
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp();

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    setStatusBarColor(appStore.primaryColors, statusBarBrightness: Brightness.light);

    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((e) async {
      appStore.setConnectionState(e);
      if (e == ConnectivityResult.none) {
        log('not connected');
        push(NoInternetConnection());
      } else {
        pop();
        log('connected');
      }
    });
    if (isMobile) {
      OneSignal.shared.setNotificationOpenedHandler((OSNotificationOpenedResult notification) async {
        String? urlString = await notification.notification.additionalData!["ID"];

        if (urlString.validate().isNotEmpty) {
          toast(urlString);
        }
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _connectivitySubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SafeArea(child: appStore.isNetworkAvailable ? DataScreen() : NoInternetConnection()),
        supportedLocales: Language.languagesLocale(),
        navigatorKey: navigatorKey,
        localizationsDelegates: [AppLocalizations.delegate, GlobalMaterialLocalizations.delegate, GlobalWidgetsLocalizations.delegate],
        localeResolutionCallback: (locale, supportedLocales) => locale,
        locale: Locale(getStringAsync(APP_LANGUAGE, defaultValue: 'en')),
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: appStore.isDarkModeOn! ? ThemeMode.dark : ThemeMode.light,
        scrollBehavior: SBehavior(),
      );
    });
  }
}
