import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_i18n/flutter_i18n.dart';

import 'package:vf_girls/app/app.dart';

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

  static const IconData ic_man = IconData(0xe616, fontFamily: fontFamily);
  static const IconData ic_woman = IconData(0xe617, fontFamily: fontFamily);
  static const IconData ic_scan = IconData(0xe61b, fontFamily: fontFamily);
  static const IconData ic_send = IconData(0xe7d4, fontFamily: fontFamily);
  static const IconData ic_dingwei = IconData(0xe667, fontFamily: fontFamily);
  static const IconData ic_thumb = IconData(0xe668, fontFamily: fontFamily);
  static const IconData ic_warning = IconData(0xe66f, fontFamily: fontFamily);
  static const IconData ic_password = IconData(0xe989, fontFamily: fontFamily);
  static const IconData ic_password_open =
      IconData(0xe98a, fontFamily: fontFamily);
  static const IconData ic_picture = IconData(0xe67c, fontFamily: fontFamily);
  static const IconData ic_mine = IconData(0xe67d, fontFamily: fontFamily);
  static const IconData ic_zhinanzhen =
      IconData(0xe682, fontFamily: fontFamily);
  static const IconData ic_video = IconData(0xe606, fontFamily: fontFamily);
  static const IconData ic_speaker = IconData(0xe829, fontFamily: fontFamily);
  static const IconData ic_chat_circle =
      IconData(0xe619, fontFamily: fontFamily);
  static const IconData ic_chat = IconData(0xe61a, fontFamily: fontFamily);
  static const IconData ic_gift = IconData(0xe61e, fontFamily: fontFamily);
  static const IconData ic_comment = IconData(0xe620, fontFamily: fontFamily);
  static const IconData ic_star = IconData(0xe6b6, fontFamily: fontFamily);
  static const IconData ic_moon = IconData(0xe6b8, fontFamily: fontFamily);
  static const IconData ic_moonlight = IconData(0xe92f, fontFamily: fontFamily);
  static const IconData ic_sunny = IconData(0xe932, fontFamily: fontFamily);
  static const IconData ic_collect = IconData(0xe6b9, fontFamily: fontFamily);
  static const IconData ic_settings = IconData(0xe6bb, fontFamily: fontFamily);
  static const IconData ic_search = IconData(0xe6bf, fontFamily: fontFamily);
  static const IconData ic_game = IconData(0xe6c6, fontFamily: fontFamily);
  static const IconData ic_download_picture =
      IconData(0xe6d1, fontFamily: fontFamily);
  static const IconData ic_album = IconData(0xe6d3, fontFamily: fontFamily);
  static const IconData ic_share = IconData(0xe6d5, fontFamily: fontFamily);
  static const IconData ic_camera_change =
      IconData(0xe6de, fontFamily: fontFamily);
  static const IconData ic_friend = IconData(0xe6ea, fontFamily: fontFamily);
  static const IconData ic_notify = IconData(0xe6eb, fontFamily: fontFamily);
  static const IconData ic_camera = IconData(0xe6ed, fontFamily: fontFamily);
  static const IconData ic_download = IconData(0xe611, fontFamily: fontFamily);
  static const IconData ic_home = IconData(0xe62e, fontFamily: fontFamily);
  static const IconData ic_location = IconData(0xe62f, fontFamily: fontFamily);
  static const IconData ic_shop = IconData(0xe630, fontFamily: fontFamily);
  static const IconData ic_diamond = IconData(0xe636, fontFamily: fontFamily);
  static const IconData ic_gift_box = IconData(0xe639, fontFamily: fontFamily);
  static const IconData ic_edit = IconData(0xe640, fontFamily: fontFamily);
  static const IconData ic_time = IconData(0xe63c, fontFamily: fontFamily);
  static const IconData ic_mobile = IconData(0xe63f, fontFamily: fontFamily);
  static const IconData ic_minimize = IconData(0xe63b, fontFamily: fontFamily);
  static const IconData ic_explore = IconData(0xe951, fontFamily: fontFamily);
  static const IconData ic_play = IconData(0xe637, fontFamily: fontFamily);
  static const IconData ic_pause = IconData(0xe63a, fontFamily: fontFamily);
  static const IconData ic_call = IconData(0xe613, fontFamily: fontFamily);
  static const IconData ic_like_fill = IconData(0xe63d, fontFamily: fontFamily);
  static const IconData ic_like_path = IconData(0xe63e, fontFamily: fontFamily);
  static const IconData ic_palette = IconData(0xe664, fontFamily: fontFamily);
  static const IconData ic_mic = IconData(0xe751, fontFamily: fontFamily);
  static const IconData ic_mic_mute = IconData(0xe752, fontFamily: fontFamily);
  static const IconData ic_eye_on = IconData(0xe699, fontFamily: fontFamily);
  static const IconData ic_qrcode = IconData(0xe66b, fontFamily: fontFamily);
  static const IconData ic_network = IconData(0xe8a2, fontFamily: fontFamily);
  static const IconData ic_arrow_left =
      IconData(0xe6f7, fontFamily: fontFamily);
  static const IconData ic_arrow_down =
      IconData(0xe6fa, fontFamily: fontFamily);
  static const IconData ic_arrow_up = IconData(0xe6fb, fontFamily: fontFamily);
  static const IconData ic_arrow_right =
      IconData(0xe6f8, fontFamily: fontFamily);
  static const IconData ic_close = IconData(0xe6f9, fontFamily: fontFamily);
  static const IconData ic_done_all = IconData(0xe6cd, fontFamily: fontFamily);
  static const IconData ic_eye_off = IconData(0xe621, fontFamily: fontFamily);
  static const IconData ic_switch_close =
      IconData(0xe609, fontFamily: fontFamily);
  static const IconData ic_face = IconData(0xe789, fontFamily: fontFamily);
  static const IconData ic_fire = IconData(0xefd4, fontFamily: fontFamily);
  static const IconData ic_emotion_fill =
      IconData(0xe78a, fontFamily: fontFamily);
  static const IconData ic_emotion_line =
      IconData(0xe78b, fontFamily: fontFamily);
  static const IconData ic_switch_open =
      IconData(0xe7d6, fontFamily: fontFamily);
  static const IconData ic_subject = IconData(0xe670, fontFamily: fontFamily);
  static const IconData ic_call_end = IconData(0xe7d7, fontFamily: fontFamily);
  static const IconData ic_add = IconData(0xe7d8, fontFamily: fontFamily);
  static const IconData ic_alert = IconData(0xe673, fontFamily: fontFamily);
  static const IconData ic_delete = IconData(0xe677, fontFamily: fontFamily);
  static const IconData ic_info = IconData(0xe68b, fontFamily: fontFamily);
  static const IconData ic_shield = IconData(0xe69a, fontFamily: fontFamily);
  static const IconData ic_sign_out = IconData(0xe85f, fontFamily: fontFamily);
  static const IconData ic_earth = IconData(0xe622, fontFamily: fontFamily);
  static const IconData ic_done = IconData(0xed3d, fontFamily: fontFamily);
  static const IconData ic_font = IconData(0xed5d, fontFamily: fontFamily);
}
