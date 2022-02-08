import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mightyweb/app_localizations.dart';
import 'package:mightyweb/model/MainResponse.dart';
import 'package:mightyweb/utils/constant.dart';
import 'package:mightyweb/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';

Widget cachedImage(String? url, {double? height, Color? color, double? width, BoxFit? fit, AlignmentGeometry? alignment, bool usePlaceholderIfUrlEmpty = true, double? radius}) {
  if (url.validate().isEmpty) {
    return placeHolderWidget(height: height, width: width, fit: fit, alignment: alignment, radius: radius);
  } else if (url.validate().startsWith('http')) {
    return CachedNetworkImage(
      imageUrl: url!,
      height: height,
      width: width,
      fit: fit,
      color: color,
      alignment: alignment as Alignment? ?? Alignment.center,
      errorWidget: (_, s, d) {
        return placeHolderWidget(height: height, width: width, fit: fit, alignment: alignment, radius: radius);
      },
    );
  } else {
    return Image.asset(url!, height: height, width: width, fit: fit, alignment: alignment ?? Alignment.center).cornerRadiusWithClipRRect(radius ?? defaultRadius);
  }
}

Widget placeHolderWidget({double? height, double? width, BoxFit? fit, AlignmentGeometry? alignment, double? radius}) {
  return Image.asset(appIcon, height: height, width: width, fit: fit ?? BoxFit.cover, alignment: alignment ?? Alignment.center).cornerRadiusWithClipRRect(radius ?? defaultRadius);
}

Widget setImage(String value) {
  return Image.asset(value, height: 18, width: 18, color: white).paddingAll(16);
}

Widget setRightIcon(Righticon mRightIconModel) {
  switch (mRightIconModel.value) {
    case RIGHT_ICON_RELOAD:
      {
        return setImage(ic_reload);
      }
    case RIGHT_ICON_SHARE:
      {
        return setImage(ic_share);
      }
    case RIGHT_ICON_CLOSE:
      {
        return setImage(ic_close);
      }
    case RIGHT_ICON_SEARCH:
      {
        return setImage(ic_search);
      }
    case RIGHT_ICON_SETTINGS:
      {
        return setImage(ic_settings);
      }
    case RIGHT_ICON_CART:
      {
        return setImage(ic_cart);
      }
    case RIGHT_ICON_PROFILE:
      {
        return setImage(ic_profile);
      }
    case RIGHT_ICON_MESSAGE:
      {
        return setImage(ic_message);
      }
    case RIGHT_ICON_NOTIFICATION:
      {
        return setImage(ic_notification);
      }
    case RIGHT_ICON_USER:
      {
        return setImage(ic_user);
      }
    case RIGHT_ICON_LIST:
      {
        return setImage(ic_list);
      }
    case RIGHT_ICON_GRID:
      {
        return setImage(ic_grid);
      }
    case RIGHT_ICON_FILTER:
      {
        return setImage(ic_filter);
      }
    case RIGHT_ICON_FAVOURITE:
      {
        return setImage(ic_favourite);
      }
    case RIGHT_ICON_CHAT:
      {
        return setImage(ic_chat);
      }
    case RIGHT_ICON_ABOUT:
      {
        return setImage(ic_about);
      }
    default:
      {
        return cachedImage(mRightIconModel.url);
      }
  }
}

Widget setLeftIcon(Lefticon mLeftIconModel) {
  switch (mLeftIconModel.value) {
    case LEFT_ICON_BACK_1:
      {
        return setImage(ic_back1);
      }
    case LEFT_ICON_BACK_2:
      {
        return setImage(ic_back2);
      }
    case LEFT_ICON_HOME:
      {
        return setImage(ic_home);
      }
    case LEFT_ICON_PROFILE:
      {
        return setImage(ic_profile);
      }
    case LEFT_ICON_CLOSE:
      {
        return setImage(ic_close);
      }
    case LEFT_ICON_SEARCH:
      {
        return setImage(ic_search);
      }
    case LEFT_ICON_ADD:
      {
        return setImage(ic_add);
      }
    default:
      {
        return cachedImage(mLeftIconModel.url);
      }
  }
}

bool mConfirmationDialog(Function onTap, BuildContext context, AppLocalizations? appLocalization) {
  showConfirmDialogCustom(context,
      dialogType: DialogType.CONFIRMATION,
      negativeText: getStringAsync(EXIST_NEGATIVE_TEXT,defaultValue: appLocalization!.translate('lbl_no')!),
      positiveText: getStringAsync(EXIST_POSITIVE_TEXT,defaultValue: appLocalization.translate('lbl_yes')!),
      customCenterWidget: getStringAsync(EXIST_ENABLE_ICON) == "true" ? Image.network(getStringAsync(EXIST_ICON), fit: BoxFit.contain, height: 80, width: 80).paddingOnly(top: 16) : SizedBox(),
      title: getStringAsync(EXIST_TITLE,defaultValue: appLocalization.translate('lbl_logout')!), onAccept: (c) {
    exit(0);
  });
  return true;
}
