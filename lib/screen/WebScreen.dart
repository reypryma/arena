import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mightyweb/screen/DashboardScreen.dart';
import 'package:mightyweb/utils/colors.dart';
import 'package:mightyweb/utils/constant.dart';
import 'package:mightyweb/utils/loader.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';

// ignore: must_be_immutable
class WebScreen extends StatefulWidget {
  static String tag = '/WebScreen';

  String? mInitialUrl;
  String? mHeading;

  WebScreen({this.mInitialUrl, this.mHeading});

  @override
  WebScreenState createState() => WebScreenState();
}

class WebScreenState extends State<WebScreen> {
  String loaderValue = 'Circle';

  bool mIsLoading = false;
  bool isWasConnectionLoss = false;
  bool? _permissionReady;
  bool mIsFirstTime = true;
  bool mIsPermissionGrant = false;

  late var _localPath;

  ReceivePort _port = ReceivePort();

  PullToRefreshController? pullToRefreshController;

  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
          useShouldOverrideUrlLoading: true,
          userAgent: getStringAsync(USER_AGENT),
          mediaPlaybackRequiresUserGesture: false,
          allowFileAccessFromFileURLs: true,
          useOnDownloadStart: true,
          javaScriptEnabled: getStringAsync(IS_JAVASCRIPT_ENABLE) == "true" ? true : false,
          javaScriptCanOpenWindowsAutomatically: true,
          supportZoom: getStringAsync(IS_ZOOM_FUNCTIONALITY) == "true" ? true : false,
          incognito: getStringAsync(IS_COOKIE) == "true" ? true : false),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewController? webViewController;

  @override
  void initState() {
    super.initState();
    init();
    _bindBackgroundIsolate();
  }

  init() async {
    log(widget.mInitialUrl);
    loaderValue = getStringAsync(LOADER_STYLE);
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
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        setState(() {
          isWasConnectionLoss = true;
        });
      } else {
        setState(() {
          isWasConnectionLoss = false;
        });
      }
    });
    appStore.isLoading = true;
    setState(() {});
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
    super.dispose();
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
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        DashBoardScreen().launch(context);
        return true;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: appStore.primaryColors,
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
          leading: IconButton(
            icon: Icon(Icons.chevron_left_sharp, color: white, size: 18),
            onPressed: () {
              Navigator.pop(context);
              DashBoardScreen().launch(context);
            },
          ),
          title: Text(widget.mHeading!, style: boldTextStyle(color: white)),
        ),
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
        body: Stack(
          children: [
            InAppWebView(
              key: webViewKey,
              initialUrlRequest: URLRequest(url: Uri.parse(widget.mInitialUrl == null ?  'https://www.google.com' :widget.mInitialUrl! )),
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
                setState(() {});
                pullToRefreshController!.endRefreshing();
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
                   // url.contains("facebook.com") ||
                    url.contains("twitter.com") ||
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
              onDownloadStart: (controller, url) async {
                checkPermission().then((hasGranted) async {
                  _permissionReady = hasGranted;
                  if (_permissionReady == true) {
                    if (Platform.isIOS) {
                      _localPath = await getApplicationDocumentsDirectory();
                    } else {
                      _localPath = '/storage/emulated/0/Download';
                    }

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
              },
            ).visible(isWasConnectionLoss == false),
            //NoInternetConnection().visible(isWasConnectionLoss == true),
            Loaders(name: appStore.loaderValues).center().visible(mIsLoading)
          ],
        ),
      ),
    );
  }
}
