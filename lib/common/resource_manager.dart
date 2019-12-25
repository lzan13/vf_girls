import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_i18n/flutter_i18n.dart';

import 'package:vf_library/index.dart';

///
/// 资源加载帮助类
///
class RESHelper {
  static const String baseUrl = 'http://www.meetingplus.cn';
  static const String imagePrefix = '$baseUrl/uimg/';

  /// 包装远程图片
  static String wrapUrl(String url) {
    if (url.startsWith('http')) {
      return url;
    } else {}
    return imagePrefix + url;
  }

  /// 包装本地图片
  static String wrapImage(String url) {
    return "assets/images/" + url;
  }

  /// 获取字符串
  static String str(String key) {
    return FlutterI18n.translate(Store.appContext, "settings");
  }

  static Widget placeHolder({double width, double height}) {
    return SizedBox(
        width: width,
        height: height,
        child: CupertinoActivityIndicator(radius: min(10.0, width / 3)));
  }

  static Widget error({double width, double height, double size}) {
    return SizedBox(
        width: width,
        height: height,
        child: Icon(
          Icons.error_outline,
          size: size,
        ));
  }

  static String randomUrl(
      {int width = 100, int height = 100, Object key = ''}) {
    return 'http://placeimg.com/$width/$height/${key.hashCode.toString() + key.toString()}';
  }
}

/*
 * 自定义三方字体图标
 */
class VFIcons {
  VFIcons._();

  /// 引用自定义的字体图标
  static const String fontFamily = 'iconfont';

  static const IconData man = IconData(0xe616, fontFamily: fontFamily);
  static const IconData woman = IconData(0xe617, fontFamily: fontFamily);
  static const IconData scan = IconData(0xe61b, fontFamily: fontFamily);
  static const IconData ear = IconData(0xe690, fontFamily: fontFamily);
  static const IconData sent = IconData(0xe644, fontFamily: fontFamily);
  static const IconData send = IconData(0xe7d4, fontFamily: fontFamily);
  static const IconData scan_1 = IconData(0xe600, fontFamily: fontFamily);
  static const IconData location = IconData(0xe667, fontFamily: fontFamily);
  static const IconData location2 = IconData(0xe62f, fontFamily: fontFamily);
  static const IconData mine = IconData(0xe67d, fontFamily: fontFamily);
  static const IconData explore = IconData(0xe682, fontFamily: fontFamily);
  static const IconData video = IconData(0xe606, fontFamily: fontFamily);
  static const IconData speaker = IconData(0xe829, fontFamily: fontFamily);
  static const IconData flashChat = IconData(0xe619, fontFamily: fontFamily);
  static const IconData chat = IconData(0xe61a, fontFamily: fontFamily);
  static const IconData me = IconData(0xe61d, fontFamily: fontFamily);
  static const IconData gift2 = IconData(0xe61e, fontFamily: fontFamily);
  static const IconData comment = IconData(0xe620, fontFamily: fontFamily);
  static const IconData star = IconData(0xe6b6, fontFamily: fontFamily);
  static const IconData moon = IconData(0xe6b8, fontFamily: fontFamily);
  static const IconData collect = IconData(0xe6b9, fontFamily: fontFamily);
  static const IconData settings = IconData(0xe6bb, fontFamily: fontFamily);
  static const IconData search = IconData(0xe6bf, fontFamily: fontFamily);
  static const IconData game = IconData(0xe6c6, fontFamily: fontFamily);
  static const IconData download = IconData(0xe6d1, fontFamily: fontFamily);
  static const IconData album = IconData(0xe6d3, fontFamily: fontFamily);
  static const IconData share = IconData(0xe6d5, fontFamily: fontFamily);
  static const IconData cameraChange = IconData(0xe6de, fontFamily: fontFamily);
  static const IconData friend = IconData(0xe6ea, fontFamily: fontFamily);
  static const IconData notify = IconData(0xe6eb, fontFamily: fontFamily);
  static const IconData camera = IconData(0xe6ed, fontFamily: fontFamily);
  static const IconData home = IconData(0xe62e, fontFamily: fontFamily);
  static const IconData shop = IconData(0xe630, fontFamily: fontFamily);
  static const IconData gift = IconData(0xe639, fontFamily: fontFamily);
  static const IconData minimize = IconData(0xe63b, fontFamily: fontFamily);
  static const IconData play = IconData(0xe637, fontFamily: fontFamily);
  static const IconData pause = IconData(0xe63a, fontFamily: fontFamily);
  static const IconData call = IconData(0xe613, fontFamily: fontFamily);
  static const IconData likeFill = IconData(0xe63d, fontFamily: fontFamily);
  static const IconData likePath = IconData(0xe63e, fontFamily: fontFamily);
  static const IconData mic = IconData(0xe751, fontFamily: fontFamily);
  static const IconData micMute = IconData(0xe752, fontFamily: fontFamily);
  static const IconData eyeOff = IconData(0xe621, fontFamily: fontFamily);
  static const IconData eyeOn = IconData(0xe699, fontFamily: fontFamily);
  static const IconData qrCode = IconData(0xe66b, fontFamily: fontFamily);
  static const IconData delete = IconData(0xe750, fontFamily: fontFamily);
  static const IconData error = IconData(0xe674, fontFamily: fontFamily);
  static const IconData arrowLeft = IconData(0xe6f7, fontFamily: fontFamily);
  static const IconData arrowRight = IconData(0xe6f8, fontFamily: fontFamily);
  static const IconData close = IconData(0xe6f9, fontFamily: fontFamily);
  static const IconData face = IconData(0xe789, fontFamily: fontFamily);
  static const IconData emotionFill = IconData(0xe78a, fontFamily: fontFamily);
  static const IconData emotionLine = IconData(0xe78b, fontFamily: fontFamily);
  static const IconData emotionSadFill =
      IconData(0xe78c, fontFamily: fontFamily);
  static const IconData emotionSadLine =
      IconData(0xe78d, fontFamily: fontFamily);
  static const IconData switchClose = IconData(0xe609, fontFamily: fontFamily);
  static const IconData switchOpen = IconData(0xe7d6, fontFamily: fontFamily);
  static const IconData callEnd = IconData(0xe7d7, fontFamily: fontFamily);
  static const IconData add = IconData(0xe7d8, fontFamily: fontFamily);
}
