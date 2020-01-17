import 'dart:io';
import 'package:firebase_admob/firebase_admob.dart';

import 'package:vf_plugin/vf_plugin.dart';

class ADSManager {
  // Google Admob 配置
  final String ADMOB_APP_ID = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544~3347511713'
      : 'ca-app-pub-3940256099942544~1458002511';

  // 横幅广告 Id
  final String ADMOB_BANNER_ID = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111'
      : 'ca-app-pub-3940256099942544/2934735716';

  // 插屏广告 Id
  final String ADMOB_INTERSTITIAL_ID = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/1033173712'
      : 'ca-app-pub-3940256099942544/4411468910';

  // 视频广告 Id
  final String ADMOB_VIDEO_ID = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/5224354917'
      : 'ca-app-pub-3940256099942544/1712485313';
  // 测试设备
  static const String ADMOB_TEST_DEVICES = 'Samsung_Galaxy_SII_API_26:5554';

  // 广告配置信息
  final MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: <String>[ADMOB_TEST_DEVICES],
    keywords: <String>['girl', 'beautiful apps'],
    contentUrl: 'https://flutter.io',
    childDirected: true,
    nonPersonalizedAds: true,
  );

  // 横幅广告
  BannerAd mBannerAds;
  // 插屏广告
  InterstitialAd mInterstitialAds;
  // 奖励回调接口
  ADSRewardedListener mListener;
  // 工厂模式
  factory ADSManager() => _generateInstance();
  // 单例类实例公开访问点
  static ADSManager get instance => _generateInstance();
  // 静态私有成员，没有初始化
  static ADSManager _instance;
  // 私有化构造方法
  ADSManager._() {}
  // 静态、同步、私有访问点
  static ADSManager _generateInstance() {
    if (_instance == null) {
      _instance = ADSManager._();
    }
    return _instance;
  }

  ///
  /// 初始化广告数据
  ///
  void initADS(ADSRewardedListener listener) {
    mListener = listener;

    // 初始化 Admob
    FirebaseAdMob.instance.initialize(appId: ADMOB_APP_ID);
    // 实例化横幅广告并加载
    mBannerAds = createBannerAd()..load();
    // 实例化插屏广告并加载
    mInterstitialAds = createInterstitialAd()..load();
    // 设置视频奖励广告监听
    RewardedVideoAd.instance.listener =
        (RewardedVideoAdEvent event, {String rewardType, int rewardAmount}) {
      VFLog.d("视频广告监听 $event, $rewardType, $rewardAmount");
      if (event == RewardedVideoAdEvent.rewarded) {
        if (mListener != null) {
          mListener(rewardAmount);
        }
      }
    };
    // 奖励视频广告加载
    RewardedVideoAd.instance.load(
      adUnitId: ADMOB_VIDEO_ID,
      targetingInfo: targetingInfo,
    );
  }

  // 创建 Banner 广告
  BannerAd createBannerAd() {
    return BannerAd(
      adUnitId: ADMOB_BANNER_ID,
      size: AdSize.banner,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        VFLog.d("横幅广告监听 $event");
      },
    );
  }

  // 创建插屏广告
  InterstitialAd createInterstitialAd() {
    return InterstitialAd(
      adUnitId: ADMOB_INTERSTITIAL_ID,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        VFLog.d("插屏广告监听 $event");
      },
    );
  }

  ///
  /// 显示横幅广告
  ///
  void showBannerADS() {
    mBannerAds ??= createBannerAd();
    mBannerAds
      ..load()
      ..show();
  }

  void hideBannerADS() {
    mBannerAds?.dispose();
    mBannerAds = null;
  }

  ///
  /// 显示插屏广告
  ///
  void showInterstitialADS() {
    mInterstitialAds?.show();
  }

  ///
  /// 显示视频奖励广告
  ///
  void showVideoADS() {
    RewardedVideoAd.instance.show();
  }

  // 释放广告资源
  void dispose() {
    mBannerAds?.dispose();
    mInterstitialAds?.dispose();
  }
}

/// 定义视频奖励接口
typedef void ADSRewardedListener(int amount);
