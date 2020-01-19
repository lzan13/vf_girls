import 'dart:io';
import 'package:localstorage/localstorage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vf_girls/common/config.dart';

class StorageManager {
  /// app 全局配置 eg:theme
  static SharedPreferences sharedPreferences;

  /// 临时目录 eg: cookie
  static Directory temporaryDirectory;

  /// 初始化必备操作 eg:user 数据
  static LocalStorage localStorage;

  ///
  /// 必备数据的初始化操作，由于是同步操作会导致阻塞，所以应尽量减少存储容量
  ///
  static init() async {
    // async 异步操作
    // sync 同步操作
    sharedPreferences = await SharedPreferences.getInstance();
    temporaryDirectory = await getTemporaryDirectory();
    localStorage = LocalStorage('LocalStorage');
    await localStorage.ready;
  }

  ///
  /// ----------------------------- 用户相关数据 -----------------------------
  ///
  /// 保存登录注册信息
  ///
  static void saveSignInfo(user) {
    sharedPreferences.setString(Configs.KEY_USERNAME, user.username);
    sharedPreferences.setString(Configs.KEY_USER_TOKEN, user.sessionToken);
    localStorage.setItem(Configs.KEY_USER_INFO, user);
  }

  ///
  /// 清空登录信息
  ///
  static void clearSignInfo() {
    sharedPreferences.remove(Configs.KEY_USER_TOKEN);
    localStorage.deleteItem(Configs.KEY_USER_INFO);
  }

  ///
  /// 获取登录账户名
  ///
  static String getUsername() {
    return sharedPreferences.getString(Configs.KEY_USERNAME);
  }

  ///
  /// 获取 Token
  ///
  static String getToken() {
    return sharedPreferences.getString(Configs.KEY_USER_TOKEN);
  }

  ///
  /// 获取登录信息
  ///
  static dynamic getSignInfo() {
    return localStorage.getItem(Configs.KEY_USER_INFO);
  }

  ///
  /// ----------------------------- 主题数据 -----------------------------
  ///
  ///

  ///
  /// 设置黑暗模式
  //
  static Future<bool> setDarkMode(mode) {
    return sharedPreferences.setBool(Configs.KEY_THEME_DARK_MODE, mode);
  }

  static bool getDarkMode() {
    return sharedPreferences.getBool(Configs.KEY_THEME_DARK_MODE) ?? false;
  }

  ///
  /// 设置主题样式
  ///
  static Future<bool> setThemeIndex(index) {
    return sharedPreferences.setInt(Configs.KEY_THEME_COLOR_INDEX, index);
  }

  static int getThemeIndex() {
    return sharedPreferences.getInt(Configs.KEY_THEME_COLOR_INDEX) ?? 9;
  }

  ///
  /// 设置文字
  ///
  static Future<bool> setFontIndex(index) {
    return sharedPreferences.setInt(Configs.KEY_FONT_INDEX, index);
  }

  static int getFontIndex() {
    return sharedPreferences.getInt(Configs.KEY_FONT_INDEX) ?? 0;
  }

  ///
  /// 设置当前语言
  ///
  static Future<bool> setLanguageIndex(index) {
    return sharedPreferences.setInt(Configs.KEY_LOCAL_INDEX, index);
  }

  static int getLanguageIndex() {
    return sharedPreferences.getInt(Configs.KEY_LOCAL_INDEX) ?? 0;
  }
}
