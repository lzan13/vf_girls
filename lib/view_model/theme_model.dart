import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import 'package:vf_girls/common/index.dart';
import 'package:vf_plugin/vf_plugin.dart';

///
/// 主题数据共享
///
class ThemeModel extends ChangeNotifier {
  // 字体值
  static const fontValueList = ['system', 'kuaile'];
  // 语言值
  // static const localeValueList = ['auto', 'zh-CN', 'en'];

  /// 用户选择的明暗模式
  bool _userDarkMode;

  /// 当前主题颜色
  MaterialColor _themeColor;

  /// 当前字体索引
  int _fontIndex;

  /// 当前语言索引
  // int _localeIndex;
  // int get localeIndex => _localeIndex;

  ThemeModel() {
    // 用户选择的明暗模式
    _userDarkMode = StorageManager.getDarkMode();
    // 获取主题色
    _themeColor = Colors.primaries[StorageManager.getThemeIndex()];
    // 获取字体
    _fontIndex = StorageManager.getFontIndex();
    // 获取语言
    // _localeIndex = StorageManager.getLanguageIndex();
  }

  int get fontIndex => _fontIndex;

  ///
  /// 切换指定色彩
  /// 没有传 [brightness] 就不改变 brightness, color 同理
  ///
  void switchTheme({bool userDarkMode, MaterialColor color}) {
    _userDarkMode = userDarkMode ?? _userDarkMode;
    _themeColor = color ?? _themeColor;
    notifyListeners();
    saveTheme2Storage(_userDarkMode, _themeColor);
  }

  ///
  /// 检查主题状态栏
  ///
  void checkThemeStatusBar() {
    if (_userDarkMode) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
        statusBarColor: VFColors.transparent,
      ));
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: VFColors.transparent,
      ));
    }
  }

  ///
  /// 随机一个主题色彩
  /// 可以指定明暗模式,不指定则保持不变
  ///
  void switchRandomTheme({Brightness brightness}) {
    int colorIndex = Random().nextInt(Colors.primaries.length - 1);
    switchTheme(
      userDarkMode: Random().nextBool(),
      color: Colors.primaries[colorIndex],
    );
  }

  /// 切换字体
  switchFont(int index) {
    _fontIndex = index;
    switchTheme();
    saveFontIndex(index);
  }

  /// 根据主题 明暗 和 颜色 生成对应的主题
  /// [dark]系统的Dark Mode
  themeData({bool platformDarkMode: false}) {
    var isDark = platformDarkMode || _userDarkMode;
    Brightness brightness = isDark ? Brightness.dark : Brightness.light;

    var themeColor = _themeColor;
    var accentColor = isDark ? themeColor[700] : _themeColor;
    var themeData = ThemeData(
        brightness: brightness,
        // 主题颜色属于亮色系还是属于暗色系(eg:dark时,AppBarTitle文字及状态栏文字的颜色为白色,反之为黑色)
        // 这里设置为dark目的是,不管App是明or暗,都将appBar的字体颜色的默认值设为白色.
        // 再AnnotatedRegion<SystemUiOverlayStyle>的方式,调整响应的状态栏颜色
        primaryColorBrightness: Brightness.dark,
        accentColorBrightness: Brightness.dark,
        primarySwatch: themeColor,
        accentColor: accentColor,
        fontFamily: fontValueList[fontIndex]);

    themeData = themeData.copyWith(
      brightness: brightness,
      accentColor: accentColor,
      cupertinoOverrideTheme: CupertinoThemeData(
        primaryColor: themeColor,
        brightness: brightness,
      ),

      appBarTheme: themeData.appBarTheme.copyWith(elevation: 0),
      splashColor: themeColor.withAlpha(50),
      hintColor: themeData.hintColor.withAlpha(90),
      errorColor: Colors.red,
      cursorColor: accentColor,
      textTheme: themeData.textTheme.copyWith(
        // 解决中文 hint 不居中的问题 https://github.com/flutter/flutter/issues/40248
        subhead: themeData.textTheme.subhead
            .copyWith(textBaseline: TextBaseline.alphabetic),
      ),
      textSelectionColor: accentColor.withAlpha(60),
      textSelectionHandleColor: accentColor.withAlpha(60),
      toggleableActiveColor: accentColor,
      chipTheme: themeData.chipTheme.copyWith(
        pressElevation: 0,
        padding: EdgeInsets.symmetric(horizontal: 10),
        labelStyle: themeData.textTheme.caption,
        backgroundColor: themeData.chipTheme.backgroundColor.withOpacity(0.1),
      ),
//          textTheme: CupertinoTextThemeData(brightness: Brightness.light)
      inputDecorationTheme: inputDecorationTheme(themeData),
    );
    return themeData;
  }

  ///
  /// 装饰主题
  ///
  InputDecorationTheme inputDecorationTheme(ThemeData theme) {
    var primaryColor = theme.primaryColor;
    var dividerColor = theme.dividerColor;
    var errorColor = theme.errorColor;
    var disabledColor = theme.disabledColor;

    var width = 0.5;

    return InputDecorationTheme(
      hintStyle: TextStyle(fontSize: 14),
      errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: width, color: errorColor)),
      focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: 0.7, color: errorColor)),
      focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: width, color: primaryColor)),
      enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: width, color: dividerColor)),
      border: UnderlineInputBorder(
          borderSide: BorderSide(width: width, color: dividerColor)),
      disabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: width, color: disabledColor)),
    );
  }

  ///
  /// 数据持久化到 SharedPreferences
  ///
  saveTheme2Storage(bool userDarkMode, MaterialColor themeColor) async {
    var index = Colors.primaries.indexOf(themeColor);
    await Future.wait([
      StorageManager.setDarkMode(userDarkMode),
      StorageManager.setThemeIndex(index)
    ]);
  }

  ///
  /// 根据索引获取字体名称,这里牵涉到国际化
  ///
  static String fontName(index, context) {
    switch (index) {
      case 0:
        return FlutterI18n.translate(context, "font_by_sys");
      case 1:
        return FlutterI18n.translate(context, "font_kuai_le");
      default:
        return '';
    }
  }

  ///
  /// 字体选择持久化
  ///
  static saveFontIndex(int index) async {
    await StorageManager.setFontIndex(index);
  }

//   Locale get locale {
//     if (_localeIndex > 0) {
//       var value = localeValueList[_localeIndex].split("-");
//       return Locale(value[0], value.length == 2 ? value[1] : '');
//     }
//     // 跟随系统
//     return null;
//   }

//   ///
//   /// 根据索引获取语言,这里牵涉到国际化
//   ///
//   static String localeName(index, context) {
//     switch (index) {
//       case 0:
//         return FlutterI18n.translate(context, "language_by_sys");
//       case 1:
//         return FlutterI18n.translate(context, "language_zh_cn");
//       case 2:
//         return FlutterI18n.translate(context, "language_en");
//       default:
//         return FlutterI18n.translate(context, "language_by_sys");
//     }
//   }

//   ///
//   /// 修改语言并持久化保存
//   ///
//   switchLocale(int index) {
//     _localeIndex = index;
//     notifyListeners();
//     StorageManager.setLanguageIndex(_localeIndex);
//   }
}
