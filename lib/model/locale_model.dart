import 'package:flutter/material.dart';

import '../config/storage_manager.dart';
import '../generated/i18n.dart';

class LocaleModel extends ChangeNotifier {
//  static const localeNameList = ['auto', '中文', 'English'];
  static const localeValueList = ['', 'zh-CN', 'en'];

  //
  static const kLocaleIndex = 'kLocaleIndex';

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
    _localeIndex = StorageManager.sharedPreferences.getInt(kLocaleIndex) ?? 0;
  }

  switchLocale(int index) {
    _localeIndex = index;
    notifyListeners();
    StorageManager.sharedPreferences.setInt(kLocaleIndex, index);
  }

  static String localeName(index, context) {
    switch (index) {
      case 0:
        return S.of(context).language_auto;
      case 1:
        return S.of(context).language_en;
      case 2:
        return S.of(context).language_zh_cn;
      default:
        return '';
    }
  }
}