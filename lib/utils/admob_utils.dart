import 'dart:io';

import 'package:mightyweb/utils/constant.dart';
import 'package:nb_utils/nb_utils.dart';

String? getBannerAdUnitId() {
  if (Platform.isIOS) {
    return getStringAsync(AD_MOB_BANNER_ID_IOS);
  } else if (Platform.isAndroid) {
    return getStringAsync(AD_MOB_BANNER_ID);
  }
  return null;
}

String? getInterstitialAdUnitId() {
  if (Platform.isIOS) {
    return getStringAsync(AD_MOB_INTENTIAL_ID_IOS);
  } else if (Platform.isAndroid) {
    return getStringAsync(AD_MOB_INTENTIALID);
  }
  return null;
}
