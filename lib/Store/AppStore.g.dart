// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AppStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AppStore on AppStoreBase, Store {
  final _$isDarkModeOnAtom = Atom(name: 'AppStoreBase.isDarkModeOn');

  @override
  bool? get isDarkModeOn {
    _$isDarkModeOnAtom.reportRead();
    return super.isDarkModeOn;
  }

  @override
  set isDarkModeOn(bool? value) {
    _$isDarkModeOnAtom.reportWrite(value, super.isDarkModeOn, () {
      super.isDarkModeOn = value;
    });
  }

  final _$isNetworkAvailableAtom =
      Atom(name: 'AppStoreBase.isNetworkAvailable');

  @override
  bool get isNetworkAvailable {
    _$isNetworkAvailableAtom.reportRead();
    return super.isNetworkAvailable;
  }

  @override
  set isNetworkAvailable(bool value) {
    _$isNetworkAvailableAtom.reportWrite(value, super.isNetworkAvailable, () {
      super.isNetworkAvailable = value;
    });
  }

  final _$primaryColorsAtom = Atom(name: 'AppStoreBase.primaryColors');

  @override
  Color get primaryColors {
    _$primaryColorsAtom.reportRead();
    return super.primaryColors;
  }

  @override
  set primaryColors(Color value) {
    _$primaryColorsAtom.reportWrite(value, super.primaryColors, () {
      super.primaryColors = value;
    });
  }

  final _$loaderValuesAtom = Atom(name: 'AppStoreBase.loaderValues');

  @override
  String? get loaderValues {
    _$loaderValuesAtom.reportRead();
    return super.loaderValues;
  }

  @override
  set loaderValues(String? value) {
    _$loaderValuesAtom.reportWrite(value, super.loaderValues, () {
      super.loaderValues = value;
    });
  }

  final _$urlAtom = Atom(name: 'AppStoreBase.url');

  @override
  String? get url {
    _$urlAtom.reportRead();
    return super.url;
  }

  @override
  set url(String? value) {
    _$urlAtom.reportWrite(value, super.url, () {
      super.url = value;
    });
  }

  final _$currentIndexAtom = Atom(name: 'AppStoreBase.currentIndex');

  @override
  int get currentIndex {
    _$currentIndexAtom.reportRead();
    return super.currentIndex;
  }

  @override
  set currentIndex(int value) {
    _$currentIndexAtom.reportWrite(value, super.currentIndex, () {
      super.currentIndex = value;
    });
  }

  final _$selectedLanguageCodeAtom =
      Atom(name: 'AppStoreBase.selectedLanguageCode');

  @override
  String? get selectedLanguageCode {
    _$selectedLanguageCodeAtom.reportRead();
    return super.selectedLanguageCode;
  }

  @override
  set selectedLanguageCode(String? value) {
    _$selectedLanguageCodeAtom.reportWrite(value, super.selectedLanguageCode,
        () {
      super.selectedLanguageCode = value;
    });
  }

  final _$isLoadingAtom = Atom(name: 'AppStoreBase.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$mTabListAtom = Atom(name: 'AppStoreBase.mTabList');

  @override
  List<TabsResponse> get mTabList {
    _$mTabListAtom.reportRead();
    return super.mTabList;
  }

  @override
  set mTabList(List<TabsResponse> value) {
    _$mTabListAtom.reportWrite(value, super.mTabList, () {
      super.mTabList = value;
    });
  }

  final _$mFABListAtom = Atom(name: 'AppStoreBase.mFABList');

  @override
  List<FloatingButton> get mFABList {
    _$mFABListAtom.reportRead();
    return super.mFABList;
  }

  @override
  set mFABList(List<FloatingButton> value) {
    _$mFABListAtom.reportWrite(value, super.mFABList, () {
      super.mFABList = value;
    });
  }

  final _$mOnBoardListAtom = Atom(name: 'AppStoreBase.mOnBoardList');

  @override
  List<Walkthrough> get mOnBoardList {
    _$mOnBoardListAtom.reportRead();
    return super.mOnBoardList;
  }

  @override
  set mOnBoardList(List<Walkthrough> value) {
    _$mOnBoardListAtom.reportWrite(value, super.mOnBoardList, () {
      super.mOnBoardList = value;
    });
  }

  final _$mBottomNavigationListAtom =
      Atom(name: 'AppStoreBase.mBottomNavigationList');

  @override
  List<MenuStyle> get mBottomNavigationList {
    _$mBottomNavigationListAtom.reportRead();
    return super.mBottomNavigationList;
  }

  @override
  set mBottomNavigationList(List<MenuStyle> value) {
    _$mBottomNavigationListAtom.reportWrite(value, super.mBottomNavigationList,
        () {
      super.mBottomNavigationList = value;
    });
  }

  final _$deepLinkURLAtom = Atom(name: 'AppStoreBase.deepLinkURL');

  @override
  String? get deepLinkURL {
    _$deepLinkURLAtom.reportRead();
    return super.deepLinkURL;
  }

  @override
  set deepLinkURL(String? value) {
    _$deepLinkURLAtom.reportWrite(value, super.deepLinkURL, () {
      super.deepLinkURL = value;
    });
  }

  final _$toggleDarkModeAsyncAction =
      AsyncAction('AppStoreBase.toggleDarkMode');

  @override
  Future<void> toggleDarkMode({bool? value}) {
    return _$toggleDarkModeAsyncAction
        .run(() => super.toggleDarkMode(value: value));
  }

  final _$setDarkModeAsyncAction = AsyncAction('AppStoreBase.setDarkMode');

  @override
  Future<void> setDarkMode({bool? aIsDarkMode}) {
    return _$setDarkModeAsyncAction
        .run(() => super.setDarkMode(aIsDarkMode: aIsDarkMode));
  }

  final _$setLanguageAsyncAction = AsyncAction('AppStoreBase.setLanguage');

  @override
  Future<void> setLanguage(String? aSelectedLanguageCode) {
    return _$setLanguageAsyncAction
        .run(() => super.setLanguage(aSelectedLanguageCode));
  }

  final _$AppStoreBaseActionController = ActionController(name: 'AppStoreBase');

  @override
  void setLoading(bool val) {
    final _$actionInfo = _$AppStoreBaseActionController.startAction(
        name: 'AppStoreBase.setLoading');
    try {
      return super.setLoading(val);
    } finally {
      _$AppStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setConnectionState(ConnectivityResult val) {
    final _$actionInfo = _$AppStoreBaseActionController.startAction(
        name: 'AppStoreBase.setConnectionState');
    try {
      return super.setConnectionState(val);
    } finally {
      _$AppStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDeepLinkURL(String val) {
    final _$actionInfo = _$AppStoreBaseActionController.startAction(
        name: 'AppStoreBase.setDeepLinkURL');
    try {
      return super.setDeepLinkURL(val);
    } finally {
      _$AppStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addToTabList(TabsResponse val) {
    final _$actionInfo = _$AppStoreBaseActionController.startAction(
        name: 'AppStoreBase.addToTabList');
    try {
      return super.addToTabList(val);
    } finally {
      _$AppStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addToOnBoardList(Walkthrough val) {
    final _$actionInfo = _$AppStoreBaseActionController.startAction(
        name: 'AppStoreBase.addToOnBoardList');
    try {
      return super.addToOnBoardList(val);
    } finally {
      _$AppStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addToFabList(FloatingButton val) {
    final _$actionInfo = _$AppStoreBaseActionController.startAction(
        name: 'AppStoreBase.addToFabList');
    try {
      return super.addToFabList(val);
    } finally {
      _$AppStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addToBottomNavigationLis(MenuStyle val) {
    final _$actionInfo = _$AppStoreBaseActionController.startAction(
        name: 'AppStoreBase.addToBottomNavigationLis');
    try {
      return super.addToBottomNavigationLis(val);
    } finally {
      _$AppStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPrimaryColor(Color value) {
    final _$actionInfo = _$AppStoreBaseActionController.startAction(
        name: 'AppStoreBase.setPrimaryColor');
    try {
      return super.setPrimaryColor(value);
    } finally {
      _$AppStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLoader(String? value) {
    final _$actionInfo = _$AppStoreBaseActionController.startAction(
        name: 'AppStoreBase.setLoader');
    try {
      return super.setLoader(value);
    } finally {
      _$AppStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setURL(String value) {
    final _$actionInfo =
        _$AppStoreBaseActionController.startAction(name: 'AppStoreBase.setURL');
    try {
      return super.setURL(value);
    } finally {
      _$AppStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIndex(int value) {
    final _$actionInfo = _$AppStoreBaseActionController.startAction(
        name: 'AppStoreBase.setIndex');
    try {
      return super.setIndex(value);
    } finally {
      _$AppStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isDarkModeOn: ${isDarkModeOn},
isNetworkAvailable: ${isNetworkAvailable},
primaryColors: ${primaryColors},
loaderValues: ${loaderValues},
url: ${url},
currentIndex: ${currentIndex},
selectedLanguageCode: ${selectedLanguageCode},
isLoading: ${isLoading},
mTabList: ${mTabList},
mFABList: ${mFABList},
mOnBoardList: ${mOnBoardList},
mBottomNavigationList: ${mBottomNavigationList},
deepLinkURL: ${deepLinkURL}
    ''';
  }
}
