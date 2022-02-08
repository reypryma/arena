class MainResponse {
  Appconfiguration? appconfiguration;
  Admob? admob;
  Progressbar? progressbar;
  Theme? theme;
  About? about;
  OnesignalConfiguration? onesignalConfiguration;
  List<MenuStyle>? menuStyle;
  HeaderIcon? headerIcon;
  List<Walkthrough>? walkthrough;
  List<FloatingButton>? floatingButton;
  List<UserAgentResponse>? userAgentResponse;
  List<TabsResponse>? tabs;
  SplashConfiguration? splashConfiguration;
  ExitPopUpModel? exitPopupConfiguration;

  MainResponse(
      {this.appconfiguration,
      this.admob,
      this.progressbar,
      this.theme,
      this.about,
      this.onesignalConfiguration,
      this.menuStyle,
      this.headerIcon,
      this.walkthrough,
      this.floatingButton,
      this.userAgentResponse,
      this.tabs,
      this.splashConfiguration,
      this.exitPopupConfiguration});

  MainResponse.fromJson(Map<String, dynamic> json) {
    appconfiguration = json['appconfiguration'] != null ? new Appconfiguration.fromJson(json['appconfiguration']) : null;
    admob = json['admob'] != null ? new Admob.fromJson(json['admob']) : null;
    progressbar = json['progressbar'] != null ? new Progressbar.fromJson(json['progressbar']) : null;
    theme = json['theme'] != null ? new Theme.fromJson(json['theme']) : null;
    about = json['about'] != null ? new About.fromJson(json['about']) : null;
    onesignalConfiguration = json['onesignal_configuration'] != null ? new OnesignalConfiguration.fromJson(json['onesignal_configuration']) : null;
    if (json['menu_style'] != null) {
      menuStyle = [];
      json['menu_style'].forEach((v) {
        menuStyle!.add(new MenuStyle.fromJson(v));
      });
    }
    headerIcon = json['header_icon'] != null ? new HeaderIcon.fromJson(json['header_icon']) : null;
    if (json['walkthrough'] != null) {
      walkthrough = [];
      json['walkthrough'].forEach((v) {
        walkthrough!.add(new Walkthrough.fromJson(v));
      });
    }
    if (json['floating_button'] != null) {
      floatingButton = [];
      json['floating_button'].forEach((v) {
        floatingButton!.add(new FloatingButton.fromJson(v));
      });
    }
    if (json['user_agent'] != null) {
      userAgentResponse = [];
      json['user_agent'].forEach((v) {
        userAgentResponse!.add(new UserAgentResponse.fromJson(v));
      });
    }
    if (json['tabs'] != null) {
      tabs = [];
      json['tabs'].forEach((v) {
        tabs!.add(new TabsResponse.fromJson(v));
      });
    }
    splashConfiguration = json['splash_configuration'] != null ? new SplashConfiguration.fromJson(json['splash_configuration']) : null;
    exitPopupConfiguration = json['exitpopup_configuration'] != null ? new ExitPopUpModel.fromJson(json['exitpopup_configuration']) : null;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.appconfiguration != null) {
      data['appconfiguration'] = this.appconfiguration!.toJson();
    }
    if (this.admob != null) {
      data['admob'] = this.admob!.toJson();
    }
    if (this.progressbar != null) {
      data['progressbar'] = this.progressbar!.toJson();
    }
    if (this.theme != null) {
      data['theme'] = this.theme!.toJson();
    }
    if (this.about != null) {
      data['about'] = this.about!.toJson();
    }
    if (this.onesignalConfiguration != null) {
      data['onesignal_configuration'] = this.onesignalConfiguration!.toJson();
    }
    if (this.menuStyle != null) {
      data['menu_style'] = this.menuStyle!.map((v) => v.toJson()).toList();
    }
    if (this.headerIcon != null) {
      data['header_icon'] = this.headerIcon!.toJson();
    }
    if (this.walkthrough != null) {
      data['walkthrough'] = this.walkthrough!.map((v) => v.toJson()).toList();
    }
    if (this.floatingButton != null) {
      data['floating_button'] = this.floatingButton!.map((v) => v.toJson()).toList();
    }
    if (this.userAgentResponse != null) {
      data['user_agent'] = this.userAgentResponse!.map((v) => v.toJson()).toList();
    }
    if (this.tabs != null) {
      data['tabs'] = this.tabs!.map((v) => v.toJson()).toList();
    }
    if (this.splashConfiguration != null) {
      data['splash_configuration'] = this.splashConfiguration!.toJson();
    }
    if (this.exitPopupConfiguration != null) {
      data['exitpopup_configuration'] = this.exitPopupConfiguration!.toJson();
    }
    return data;
  }
}

class Appconfiguration {
  String? appName;
  String? url;
  String? appLanuguage;
  String? isJavascriptEnable;
  String? isSplashScreen;
  String? isZoomFunctionality;
  String? navigationStyle;
  String? headerStyle;
  String? appLogo;
  String? isWalkthrough;
  String? isWebrtc;
  String? isFloatingButton;
  String? floatingButtonStyle;
  String? floatingButton;
  String? isPullRefresh;
  String? tabStyle;
  String? isCookieEnable;
  String? bottomNavigation;
  String? walkthroughStyle;
  String? isExitPopupScreen;

  Appconfiguration(
      {this.appName,
      this.url,
      this.appLanuguage,
      this.isJavascriptEnable,
      this.isSplashScreen,
      this.isZoomFunctionality,
      this.navigationStyle,
      this.headerStyle,
      this.appLogo,
      this.isWalkthrough,
      this.isWebrtc,
      this.isFloatingButton,
      this.floatingButtonStyle,
      this.floatingButton,
      this.isPullRefresh,
      this.tabStyle,
      this.isCookieEnable,
      this.bottomNavigation,
      this.walkthroughStyle,
      this.isExitPopupScreen,});

  Appconfiguration.fromJson(Map<String, dynamic> json) {
    appName = json['app_name'];
    url = json['url'];
    appLanuguage = json['appLanuguage'];
    isJavascriptEnable = json['isJavascriptEnable'];
    isSplashScreen = json['isSplashScreen'];
    isZoomFunctionality = json['isZoomFunctionality'];
    navigationStyle = json['navigationStyle'];
    headerStyle = json['header_style'];
    appLogo = json['app_logo'];
    isWalkthrough = json['is_walkthrough'];
    isWebrtc = json['is_webrtc'];
    isFloatingButton = json['is_floating_button'];
    floatingButtonStyle = json['floating_button_style'];
    floatingButton = json['floating_button'];
    isPullRefresh = json['is_pull_refresh'];
    tabStyle = json['tab_style'];
    isCookieEnable = json['clear_cookie'];
    bottomNavigation = json['bottom_navigation'];
    walkthroughStyle = json['walkthrough_style'];
    isExitPopupScreen = json['isExitPopupScreen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['app_name'] = this.appName;
    data['url'] = this.url;
    data['appLanuguage'] = this.appLanuguage;
    data['isJavascriptEnable'] = this.isJavascriptEnable;
    data['isSplashScreen'] = this.isSplashScreen;
    data['isZoomFunctionality'] = this.isZoomFunctionality;
    data['navigationStyle'] = this.navigationStyle;
    data['header_style'] = this.headerStyle;
    data['is_walkthrough'] = this.isWalkthrough;
    data['is_webrtc'] = this.isWebrtc;
    if (this.appLogo != null) {
      data['app_logo'] = this.appLogo;
    }
    data['is_floating_button'] = this.isFloatingButton;
    if(this.floatingButtonStyle!=null){
      data['floating_button_style'] = this.floatingButtonStyle;
    }
    if(this.floatingButton!=null){
      data['floating_button'] = this.floatingButton;
    }
    if (this.isPullRefresh != null) {
      data['is_pull_refresh'] = this.isPullRefresh;
    }
    if (this.tabStyle != null) {
      data['tab_style'] = this.tabStyle;
    }
    if (this.isCookieEnable != null) {
      data['isCookieEnable'] = this.isCookieEnable;
    }
    if (this.bottomNavigation != null) {
      data['bottom_navigation'] = this.bottomNavigation;
    }
    if (this.walkthroughStyle != null) {
      data['walkthrough_style'] = this.walkthroughStyle;
    }
    if (this.isExitPopupScreen != null) {
      data['isExitPopupScreen'] = this.isExitPopupScreen;
    }
    return data;
  }
}

class Admob {
  String? admobBannerID;
  String? admobIntentialID;
  String? admobBannerIDIOS;
  String? admobIntentialIDIOS;

  Admob({this.admobBannerID, this.admobIntentialID, this.admobBannerIDIOS, this.admobIntentialIDIOS});

  Admob.fromJson(Map<String, dynamic> json) {
    admobBannerID = json['admobBannerID'];
    admobIntentialID = json['admobIntentialID'];
    admobBannerIDIOS = json['admobBannerIDIOS'];
    admobIntentialIDIOS = json['admobIntentialIDIOS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['admobBannerID'] = this.admobBannerID;
    data['admobIntentialID'] = this.admobIntentialID;
    data['admobBannerIDIOS'] = this.admobBannerIDIOS;
    data['admobIntentialIDIOS'] = this.admobIntentialIDIOS;
    return data;
  }
}

class Progressbar {
  String? loaderStyle;
  String? isProgressbar;

  Progressbar({this.loaderStyle,this.isProgressbar});

  Progressbar.fromJson(Map<String, dynamic> json) {
    loaderStyle = json['loaderStyle'];
    isProgressbar = json['is_progressbar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['loaderStyle'] = this.loaderStyle;
    if(this.isProgressbar !=null){
      data['is_progressbar'] = this.isProgressbar;
    }
    return data;
  }
}

class Theme {
  String? themeStyle;
  String? customColor;
  String? gradientColor1;
  String? gradientColor2;

  Theme({this.themeStyle, this.customColor, this.gradientColor1, this.gradientColor2});

  Theme.fromJson(Map<String, dynamic> json) {
    themeStyle = json['themeStyle'];
    customColor = json['customColor'];
    gradientColor1 = json['gradientColor1'];
    gradientColor2 = json['gradientColor2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['themeStyle'] = this.themeStyle;
    data['customColor'] = this.customColor;
    data['gradientColor1'] = this.gradientColor1;
    data['gradientColor2'] = this.gradientColor2;
    return data;
  }
}

class About {
  String? whatsAppNumber;
  String? instagramUrl;
  String? twitterUrl;
  String? facebookUrl;
  String? callNumber;
  String? snapchat;
  String? skype;
  String? messenger;
  String? youtube;
  String? isShowAbout;
  String? copyright;
  String? description;

  About({this.whatsAppNumber, this.instagramUrl, this.twitterUrl, this.facebookUrl, this.callNumber, this.snapchat, this.skype, this.messenger, this.youtube, this.isShowAbout,this.copyright,this.description});

  About.fromJson(Map<String, dynamic> json) {
    whatsAppNumber = json['whatsAppNumber'];
    instagramUrl = json['instagramUrl'];
    twitterUrl = json['twitterUrl'];
    facebookUrl = json['facebookUrl'];
    callNumber = json['callNumber'];
    snapchat = json['snapchat'];
    skype = json['skype'];
    messenger = json['messenger'];
    youtube = json['youtube'];
    isShowAbout = json['isShowAbout'];
    copyright = json['copyright'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['whatsAppNumber'] = this.whatsAppNumber;
    data['instagramUrl'] = this.instagramUrl;
    data['twitterUrl'] = this.twitterUrl;
    data['facebookUrl'] = this.facebookUrl;
    data['callNumber'] = this.callNumber;
    data['snapchat'] = this.snapchat;
    data['skype'] = this.skype;
    data['messenger'] = this.messenger;
    data['youtube'] = this.youtube;
    data['isShowAbout'] = this.isShowAbout;
    data['copyright'] = this.copyright;
    data['description'] = this.description;
    return data;
  }
}

class OnesignalConfiguration {
  String? appId;
  String? restApiKey;

  OnesignalConfiguration({this.appId, this.restApiKey});

  OnesignalConfiguration.fromJson(Map<String, dynamic> json) {
    appId = json['app_id'];
    restApiKey = json['rest_api_key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['app_id'] = this.appId;
    data['rest_api_key'] = this.restApiKey;
    return data;
  }
}

class MenuStyle {
  String? id;
  String? title;
  String? type;
  String? image;
  String? url;
  String? status;
  String? parentId;
  List<MenuStyle>? children;

  MenuStyle({this.id, this.title, this.type, this.image, this.url, this.status, this.parentId, this.children});

  MenuStyle.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    type = json['type'];
    image = json['image'];
    url = json['url'];
    status = json['status'];
    parentId = json['parent_id'];
    if (json['children'] != null) {
      children = [];
      json['children'].forEach((v) {
        children!.add(new MenuStyle.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['type'] = this.type;
    data['image'] = this.image;
    data['url'] = this.url;
    data['status'] = this.status;
    data['parent_id'] = this.parentId;
    if (this.children != null) {
      data['children'] = this.children!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ExitPopUpModel {
  String? title;
  String? positiveText;
  String? negativeText;
  String? enableImage;
  String? exitImageUrl;

  ExitPopUpModel(
      {this.title,
        this.positiveText,
        this.negativeText,
        this.enableImage,
        this.exitImageUrl});

  ExitPopUpModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    positiveText = json['positive_text'];
    negativeText = json['negative_text'];
    enableImage = json['enable_image'];
    exitImageUrl = json['exit_image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['positive_text'] = this.positiveText;
    data['negative_text'] = this.negativeText;
    data['enable_image'] = this.enableImage;
    data['exit_image_url'] = this.exitImageUrl;
    return data;
  }
}

class HeaderIcon {
  List<Lefticon>? lefticon;
  List<Righticon>? righticon;

  HeaderIcon({this.lefticon, this.righticon});

  HeaderIcon.fromJson(Map<String, dynamic> json) {
    if (json['lefticon'] != null) {
      lefticon = [];
      json['lefticon'].forEach((v) {
        lefticon!.add(new Lefticon.fromJson(v));
      });
    }
    if (json['righticon'] != null) {
      righticon = [];
      json['righticon'].forEach((v) {
        righticon!.add(new Righticon.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.lefticon != null) {
      data['lefticon'] = this.lefticon!.map((v) => v.toJson()).toList();
    }
    if (this.righticon != null) {
      data['righticon'] = this.righticon!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Lefticon {
  String? id;
  String? title;
  String? value;
  String? image;
  String? type;
  String? url;
  String? status;
  String? createdAt;
  String? updatedAt;

  Lefticon({this.id, this.title, this.value, this.image, this.type, this.url, this.status, this.createdAt, this.updatedAt});

  Lefticon.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    value = json['value'];
    image = json['image'];
    type = json['type'];
    url = json['url'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['value'] = this.value;
    data['image'] = this.image;
    data['type'] = this.type;
    data['url'] = this.url;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Righticon {
  String? id;
  String? title;
  String? value;
  String? image;
  String? type;
  String? url;
  String? status;
  String? createdAt;
  String? updatedAt;

  Righticon({this.id, this.title, this.value, this.image, this.type, this.url, this.status, this.createdAt, this.updatedAt});

  Righticon.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    value = json['value'];
    image = json['image'];
    type = json['type'];
    url = json['url'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['value'] = this.value;
    data['image'] = this.image;
    data['type'] = this.type;
    data['url'] = this.url;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Walkthrough {
  String? id;
  String? title;
  String? subtitle;
  String? image;
  String? status;

  Walkthrough({this.id, this.title, this.subtitle, this.image, this.status});

  Walkthrough.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    subtitle = json['subtitle'];
    image = json['image'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['subtitle'] = this.subtitle;
    data['image'] = this.image;
    data['status'] = this.status;
    return data;
  }
}

class FloatingButton {
  String? id;
  String? title;
  String? image;
  String? url;
  String? status;

  FloatingButton({this.id, this.title, this.image, this.url, this.status});

  FloatingButton.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    url = json['url'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image'] = this.image;
    data['url'] = this.url;
    data['status'] = this.status;
    return data;
  }
}

class UserAgentResponse {
  String? id;
  String? title;
  String? android;
  String? ios;
  String? status;

  UserAgentResponse({this.id, this.title, this.android, this.ios, this.status});

  UserAgentResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    android = json['android'];
    ios = json['ios'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['android'] = this.android;
    data['ios'] = this.ios;
    data['status'] = this.status;
    return data;
  }
}

class TabsResponse {
  String? id;
  String? title;
  String? image;
  String? url;
  String? status;

  TabsResponse({this.id, this.title, this.image, this.url, this.status});

  TabsResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    url = json['url'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image'] = this.image;
    data['url'] = this.url;
    data['status'] = this.status;
    return data;
  }
}

class SplashConfiguration {
  String? id;
  String? firstColor;
  String? secondColor;
  String? title;
  String? titleColor;
  String? enableTitle;
  String? enableLogo;
  String? enableBackground;
  String? splashLogoUrl;
  String? splashBackgroundUrl;

  SplashConfiguration(
      {this.id, this.firstColor, this.secondColor, this.title, this.titleColor, this.enableTitle, this.enableLogo, this.enableBackground, this.splashLogoUrl, this.splashBackgroundUrl});

  SplashConfiguration.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstColor = json['first_color'];
    secondColor = json['second_color'];
    title = json['title'];
    enableTitle = json['enable_title'];
    enableLogo = json['enable_logo'];
    titleColor = json['title_color'];
    enableBackground = json['enable_background'];
    splashLogoUrl = json['splash_logo_url'];
    splashBackgroundUrl = json['splash_background_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_color'] = this.firstColor;
    data['second_color'] = this.secondColor;
    data['title'] = this.title;
    data['enable_title'] = this.enableTitle;
    data['title_color'] = this.titleColor;
    data['enable_logo'] = this.enableLogo;
    data['enable_background'] = this.enableBackground;
    data['splash_logo_url'] = this.splashLogoUrl;
    data['splash_background_url'] = this.splashBackgroundUrl;
    return data;
  }
}
