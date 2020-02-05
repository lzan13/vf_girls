import 'dart:io';

class Configs {
  // 时间
  static const int TIME_HOUR = 60 * 60 * 1000;
  static const int TIME_MINUTE = 60 * 1000;
  static const int TIME_SECOND = 1000;

  // 保存数据 key
  static const String KEY_THEME_COLOR_INDEX = 'key_theme_color_index';
  static const String KEY_THEME_DARK_MODE = 'key_theme_dark_mode';
  static const String KEY_FONT_INDEX = 'key_font_index';
  static const String KEY_LOCAL_INDEX = 'key_local_index';
  static const String KEY_USER_INFO = 'key_user_info';
  static const String KEY_USERNAME = 'key_user_name';
  static const String KEY_USER_TOKEN = 'key_user_token';

  // Google Admob 配置
  static final String admobAppId = Platform.isAndroid
      ? 'ca-app-pub-8752747601683918~8734153723'
      : 'ca-app-pub-8752747601683918~1739470154';

  // 横幅广告 Id
  static final String admobBannerId = Platform.isAndroid
      ? 'ca-app-pub-8752747601683918/7768556413'
      : 'ca-app-pub-8752747601683918/4659833885';

  // 插屏广告 Id
  static final String admobInterstitialId = Platform.isAndroid
      ? 'ca-app-pub-8752747601683918/1253805879'
      : 'ca-app-pub-8752747601683918/8327616156';

  // 视频广告 Id
  static final String admobVideoId = Platform.isAndroid
      ? 'ca-app-pub-8752747601683918/5098801674'
      : 'ca-app-pub-8752747601683918/1572589821';

  // // Google Admob 配置
  // static final String admobAppId = Platform.isAndroid
  //     ? 'ca-app-pub-3940256099942544~3347511713'
  //     : 'ca-app-pub-3940256099942544~1458002511';

  // // 横幅广告 Id
  // static final String admobBannerId = Platform.isAndroid
  //     ? 'ca-app-pub-3940256099942544/6300978111'
  //     : 'ca-app-pub-3940256099942544/2934735716';

  // // 插屏广告 Id
  // static final String admobInterstitialId = Platform.isAndroid
  //     ? 'ca-app-pub-3940256099942544/1033173712'
  //     : 'ca-app-pub-3940256099942544/4411468910';

  // // 视频广告 Id
  // static final String admobVideoId = Platform.isAndroid
  //     ? 'ca-app-pub-3940256099942544/5224354917'
  //     : 'ca-app-pub-3940256099942544/1712485313';
  // 测试设备
  static const String admobTestDevices = '3c76ba0';

  // Leancloud 域名
  static final String lcBaseUrl = 'https://j1agx1iu.lc-cn-n1-shared.com/1.1';
  static final String lcAppId = 'j1AGx1iU48PGjyv1RcuQr0OX-gzGzoHsz';
  static final String lcAppKey = 'jwYileaj7c4FCU7L1SuAzUWR';

  static final String bmobAppId = '904f703bf4e3f469b63f396419099948';
  static final String bmobAppKey = '32843d34de3ba8ae';
  static final String bmobAppRestKey = '7b8e801c2b55d0d11f90db85eeeb63f5';
  static final String bmobAppMasterKey = '';
}
