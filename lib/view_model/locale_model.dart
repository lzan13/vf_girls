import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:vf_girls/common/config.dart';

import 'package:vf_girls/common/index.dart';

///
/// 本地语言数据共享
///
class LocaleModel extends ChangeNotifier {
//  static const localeNameList = ['auto', '中文', 'English'];
  static const localeValueList = ['auto', 'zh-CN', 'en'];

  int _localeIndex;
  int get localeIndex => _localeIndex;

  Locale get locale {
    if (_localeIndex > 0) {
      var value = localeValueList[_localeIndex].split("-");
      return Locale(value[0], value.length == 2 ? value[1] : '');
    }
    // 跟随系统
    return null;
  }

  LocaleModel() {
    _localeIndex =
        StorageManager.sharedPreferences.getInt(Configs.KEY_LOCAL_INDEX) ?? 0;
  }

  switchLocale(int index) {
    _localeIndex = index;
    notifyListeners();
    StorageManager.sharedPreferences.setInt(
      Configs.KEY_LOCAL_INDEX,
      _localeIndex,
    );
  }

  static String localeName(index, context) {
    switch (index) {
      case 0:
        return FlutterI18n.translate(context, "language_by_sys");
      case 1:
        return FlutterI18n.translate(context, "language_zh_cn");
      case 2:
        return FlutterI18n.translate(context, "language_en");
      default:
        return FlutterI18n.translate(context, "language_by_sys");
    }
  }
}
