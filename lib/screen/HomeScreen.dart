import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mightyweb/app_localizations.dart';
import 'package:mightyweb/component/AppBarComponent.dart';
import 'package:mightyweb/component/FloatingComponent.dart';
import 'package:mightyweb/component/SideMenuComponent.dart';
import 'package:mightyweb/main.dart';
import 'package:mightyweb/model/MainResponse.dart';
import 'package:mightyweb/screen/DashboardScreen.dart';
import 'package:mightyweb/utils/AppWidget.dart';
import 'package:mightyweb/utils/admob_utils.dart';
import 'package:mightyweb/utils/common.dart';
import 'package:mightyweb/utils/constant.dart';
import 'package:mightyweb/utils/loader.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share/share.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class HomeScreen extends StatefulWidget {
  static String tag = '/HomeScreen';

  final String? mUrl, title;

  HomeScreen({this.mUrl, this.title});

  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  InAppWebViewController? webViewController;
  ReceivePort _port = ReceivePort();
  InterstitialAd? _interstitialAd;
  PullToRefreshController? pullToRefreshController;

  late List<TabsResponse> mTabList;

  late var _localPath;

  String? mInitialUrl;

  bool isWasConnectionLoss = false;
  bool _permissionReady = false;
  bool mIsPermissionGrant = false;
  bool mIsLocationPermissionGrant = false;

  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
    crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        userAgent: getStringAsync(USER_AGENT),
        mediaPlaybackRequiresUserGesture: false,
        allowFileAccessFromFileURLs: true,
        useOnDownloadStart: true,
        javaScriptCanOpenWindowsAutomatically: true,
        javaScriptEnabled: getStringAsync(IS_JAVASCRIPT_ENABLE) == "true" ? true : false,
        supportZoom: getStringAsync(IS_ZOOM_FUNCTIONALITY) == "true" ? true : false,
        incognito: getStringAsync(IS_COOKIE) == "true" ? true : false),
    android: AndroidInAppWebViewOptions(useHybridComposition: true),
    ios: IOSInAppWebViewOptions(allowsInlineMediaPlayback: true),
  );

  void _getInstanceId() async {
    await Firebase.initializeApp();
    FirebaseInAppMessaging.instance.triggerEvent("");
    FirebaseMessaging.instance.sendMessage();
    FirebaseMessaging.instance.getInitialMessage();
  }

  @override
  void initState() {
    super.initState();
    Iterable mTabs = jsonDecode(getStringAsync(TABS));
    mTabList = mTabs.map((model) => TabsResponse.fromJson(model)).toList();
    _bindBackgroundIsolate();
    _getInstanceId();
    if (getStringAsync(IS_WEBRTC) == "true") {
      checkWebRTCPermission();
    }
    init();
    _createInterstitialAd();
  }

  Future<bool> checkPermission() async {
    if (Platform.isAndroid) {
      final status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        final result = await Permission.storage.request();
        if (result == PermissionStatus.granted) {
          mIsPermissionGrant = true;
          setState(() {});
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }

  @override
  void dispose() {
    _unbindBackgroundIsolate();
    init();
    super.dispose();
  }

  Future<void> init() async {
    if (Platform.isIOS) {
      String? referralCode = getReferralCodeFromNative();
      if (referralCode!.isNotEmpty) {
        if (getStringAsync(NAVIGATIONSTYLE) == NAVIGATION_STYLE_BOTTOM_NAVIGATION) {
          mInitialUrl = widget.mUrl;
        } else {
          mInitialUrl = getStringAsync(URL);
        }
      } else {
        mInitialUrl = referralCode;
      }
    } else {
      Iterable mBottom = jsonDecode(getStringAsync(BOTTOMMENU));
      List<MenuStyle> mBottomMenuList = mBottom.map((model) => MenuStyle.fromJson(model)).toList();

      if (appStore.deepLinkURL.isEmptyOrNull) {
        if (getStringAsync(NAVIGATIONSTYLE) == NAVIGATION_STYLE_BOTTOM_NAVIGATION) {
          if (mBottomMenuList.isNotEmpty && mBottomMenuList != null) {
            mInitialUrl = widget.mUrl;
          } else {
            mInitialUrl = getStringAsync(URL);
          }
        } else if (getStringAsync(NAVIGATIONSTYLE) == NAVIGATION_STYLE_TAB_BAR) {
          log(widget.mUrl);
          if (mTabList.isNotEmpty && mTabList != null) {
            mInitialUrl = widget.mUrl;
            log(mInitialUrl);
          } else {
            mInitialUrl = getStringAsync(URL);
          }
        } else {
          mInitialUrl = getStringAsync(URL);
        }
      } else {
        mInitialUrl = appStore.deepLinkURL!;
      }
    }

    if (webViewController != null) {
      await webViewController!.loadUrl(urlRequest: URLRequest(url: Uri.parse(mInitialUrl!)));
    } else {
      log("sorry");
    }

    FlutterDownloader.registerCallback(downloadCallback);

    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(color: appStore.primaryColors, enabled: getStringAsync(IS_PULL_TO_REFRESH) == "true" ? true : false),
      onRefresh: () async {
        if (Platform.isAndroid) {
          webViewController?.reload();
        } else if (Platform.isIOS) {
          webViewController?.loadUrl(urlRequest: URLRequest(url: await webViewController?.getUrl()));
        }
      },
    );
  }

  @override
  void didUpdateWidget(HomeScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      init();
    });
  }

  adShow() async {
    if (_interstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) => print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createInterstitialAd();
      },
    );
    !getStringAsync(AD_MOB_INTENTIALID).isEmptyOrNull ? _interstitialAd?.show() : SizedBox();
    _interstitialAd = null;
  }

  void _createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: kReleaseMode ? getInterstitialAdUnitId()! : InterstitialAd.testAdUnitId,
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            print('$ad loaded');
            _interstitialAd = ad;
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error.');
            _interstitialAd = null;
          },
        ));
  }

  void _bindBackgroundIsolate() {
    bool isSuccess = IsolateNameServer.registerPortWithName(_port.sendPort, 'downloader_send_port');
    if (!isSuccess) {
      _unbindBackgroundIsolate();
      _bindBackgroundIsolate();
      return;
    }
  }

  void _unbindBackgroundIsolate() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

  static void downloadCallback(String id, DownloadTaskStatus status, int progress) {
    final SendPort send = IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }

  @override
  Widget build(BuildContext context) {
    var appLocalization = AppLocalizations.of(context);
    Future<bool> _exitApp() async {
      if (await webViewController!.canGoBack()) {
        webViewController!.goBack();
        return false;
      } else {
        adShow();

        if(getStringAsync(IS_Exit_POP_UP)=="true"){
          return mConfirmationDialog(() {
            Navigator.of(context).pop(false);
          }, context, appLocalization);
        }
        else{
          exit(0);
        }
      }
    }

    Widget mLoadWeb({String? mURL}) {
      return SafeArea(
        child: Stack(
          children: [
            InAppWebView(
                initialUrlRequest: URLRequest(url: Uri.parse(mURL.isEmptyOrNull ? mInitialUrl.validate() : mURL!)),
                initialOptions: options,
                pullToRefreshController: pullToRefreshController,
                onWebViewCreated: (controller) {
                  webViewController = controller;
                },
                onLoadStart: (controller, url) {
                  log("onLoadStart");
                  if(getStringAsync(IS_LOADER) == "true") appStore.setLoading(true);
                  setState(() {});
                },
                onLoadStop: (controller, url) async {
                  log("onLoadStop");
                  if(getStringAsync(IS_LOADER) == "true") appStore.setLoading(false);
                  pullToRefreshController!.endRefreshing();
                  setState(() {});
                },
                onLoadError: (controller, url, code, message) {
                  log("onLoadError");
                  if(getStringAsync(IS_LOADER) == "true") appStore.setLoading(false);
                  pullToRefreshController!.endRefreshing();
                  setState(() {});
                },
                shouldOverrideUrlLoading: (controller, navigationAction) async {
                  var uri = navigationAction.request.url;
                  var url = navigationAction.request.url.toString();
                  log("URL" + url.toString());

                  if (Platform.isAndroid && url.contains("intent")) {
                    if (url.contains("maps")) {
                      var mNewURL = url.replaceAll("intent://", "https://");
                      if (await canLaunch(mNewURL)) {
                        await launch(mNewURL);
                        return NavigationActionPolicy.CANCEL;
                      }
                    } else {
                      String id = url.substring(url.indexOf('id%3D') + 5, url.indexOf('#Intent'));
                      await StoreRedirect.redirect(androidAppId: id);
                      return NavigationActionPolicy.CANCEL;
                    }
                  } else if (url.contains("linkedin.com") ||
                      url.contains("market://") ||
                      url.contains("whatsapp://") ||
                      url.contains("truecaller://") ||
                      url.contains("pinterest.com") ||
                      url.contains("snapchat.com") ||
                      url.contains("instagram.com") ||
                      url.contains("play.google.com") ||
                      url.contains("mailto:") ||
                      url.contains("tel:") ||
                      url.contains("share=telegram") ||
                      url.contains("messenger.com")) {
                    url = Uri.encodeFull(url);
                    try {
                      if (await canLaunch(url)) {
                        launch(url);
                      } else {
                        launch(url);
                      }
                      return NavigationActionPolicy.CANCEL;
                    } catch (e) {
                      launch(url);
                      return NavigationActionPolicy.CANCEL;
                    }
                  } else if (!["http", "https", "chrome", "data", "javascript", "about"].contains(uri!.scheme)) {
                    if (await canLaunch(url)) {
                      await launch(
                        url,
                      );
                      return NavigationActionPolicy.CANCEL;
                    }
                  }
                  return NavigationActionPolicy.ALLOW;
                },
                onDownloadStart: (controller, url) {
                  checkPermission().then((hasGranted) async {
                    _permissionReady = hasGranted;
                    if (_permissionReady == true) {
                      if (Platform.isIOS) {
                        _localPath = await getApplicationDocumentsDirectory();
                      } else {
                        _localPath = "/storage/emulated/0/Download";
                      }
                      log("local Path" + _localPath);

                      final taskId = await FlutterDownloader.enqueue(
                        url: url.toString(),
                        savedDir: _localPath,
                        showNotification: true,
                        openFileFromNotification: true,
                        requiresStorageNotLow: true,
                      );
                    }
                  });
                },
                androidOnGeolocationPermissionsShowPrompt: (InAppWebViewController controller, String origin) async {
                  await Permission.location.request();
                  return Future.value(GeolocationPermissionShowPromptResponse(origin: origin, allow: true, retain: true));
                },
                androidOnPermissionRequest: (InAppWebViewController controller, String origin, List<String> resources) async {
                  if (resources.length >= 1) {
                  } else {
                    resources.forEach((element) async {
                      if (element.contains("AUDIO_CAPTURE")) {
                        await Permission.microphone.request();
                      }
                      if (element.contains("VIDEO_CAPTURE")) {
                        await Permission.camera.request();
                      }
                    });
                  }
                  return PermissionRequestResponse(resources: resources, action: PermissionRequestResponseAction.GRANT);
                }).visible(isWasConnectionLoss == false),
            //NoInternetConnection().visible(isWasConnectionLoss == true),
            Loaders(name: appStore.loaderValues).center().visible(appStore.isLoading)
          ],
        ),
      );
    }

    Widget mBody() {
      return SafeArea(
        child: Scaffold(
          drawerEdgeDragWidth: 0,
          appBar: getStringAsync(NAVIGATIONSTYLE) != NAVIGATION_STYLE_FULL_SCREEN
              ? PreferredSize(
                  child: AppBarComponent(
                    onTap: (value) {
                      if (value == RIGHT_ICON_RELOAD) {
                        webViewController!.reload();
                      }
                      if (RIGHT_ICON_SHARE == value) {
                        Share.share("test");
                      }
                      if (RIGHT_ICON_CLOSE == value || LEFT_ICON_CLOSE == value) {
                        if(getStringAsync(IS_Exit_POP_UP)=="true"){
                          mConfirmationDialog(() {
                            Navigator.of(context).pop(false);
                          }, context, appLocalization);
                        }
                      }
                      if (LEFT_ICON_BACK_1 == value) {
                        finish(context);
                      }
                      if (LEFT_ICON_BACK_2 == value) {
                        finish(context);
                      }
                      if (LEFT_ICON_HOME == value) {
                        DashBoardScreen().launch(context);
                      }
                    },
                  ),
                  preferredSize: Size.fromHeight(getStringAsync(NAVIGATIONSTYLE) == NAVIGATION_STYLE_TAB_BAR &&  appStore.mTabList.length!=0 ? 100.0 : 60.0))
              : PreferredSize(
                  child: SizedBox(),
                  preferredSize: Size.fromHeight(0.0),
                ),
          floatingActionButton: getStringAsync(IS_FLOATING) == "true" ? FloatingComponent() : SizedBox(),
          drawer: Drawer(
            child: SideMenuComponent(onTap: () {
              mInitialUrl = getStringAsync(URL).isNotEmpty ? getStringAsync(URL) : "https://www.google.com";
              webViewController!.reload();
            }),
          ).visible(getStringAsync(NAVIGATIONSTYLE) == NAVIGATION_STYLE_SIDE_DRAWER),
          body: getStringAsync(NAVIGATIONSTYLE) == NAVIGATION_STYLE_TAB_BAR && mTabList != null &&  appStore.mTabList.length!=0
              ? TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    for (int i = 0; i < mTabList.length; i++) mLoadWeb(mURL: mTabList[i].url),
                  ],
                )
              : mLoadWeb(mURL: mInitialUrl),
          bottomNavigationBar: getStringAsync(NAVIGATIONSTYLE) == NAVIGATION_STYLE_BOTTOM_NAVIGATION
              ? SizedBox()
              : Container(
                  height: 60,
                  child: AdWidget(
                    ad: BannerAd(
                      adUnitId: kReleaseMode ? getStringAsync(AD_MOB_BANNER_ID) : BannerAd.testAdUnitId,
                      size: AdSize.banner,
                      request: AdRequest(),
                      listener: BannerAdListener(),
                    )..load(),
                  ),
                ).visible(getStringAsync(AD_MOB_BANNER_ID).isNotEmpty),
        ),
      );
    }

    return WillPopScope(
      onWillPop: _exitApp,
      child: getStringAsync(NAVIGATIONSTYLE) == NAVIGATION_STYLE_TAB_BAR
          ? DefaultTabController(
              length: appStore.mTabList.length,
              child: mBody(),
            )
          : mBody(),
    );
  }
}
