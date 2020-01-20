import 'package:firebase_admob/firebase_admob.dart';

import 'package:vf_plugin/vf_plugin.dart';
import 'package:vf_girls/common/config.dart';

class ADSManager {
  // 广告配置信息
  final MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: <String>[Configs.admobTestDevices],
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
  /// 初始化 Google Admob
  ///
  void initAdmob(ADSRewardedListener listener) {
    mListener = listener;

    FirebaseAdMob.instance.initialize(appId: Configs.admobAppId);
  }

  ///
  /// 初始化广告数据
  ///
  void initADS() {
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
      } else if (event == RewardedVideoAdEvent.closed) {
        loadVideoADS();
      }
    };
    // 加载奖励视频广告
    loadVideoADS();
  }

  // 创建 Banner 广告
  BannerAd createBannerAd() {
    return BannerAd(
      adUnitId: Configs.admobBannerId,
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
      adUnitId: Configs.admobInterstitialId,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        VFLog.d("插屏广告监听 $event");
        if (event == MobileAdEvent.closed) {
          // 实例化插屏广告并加载
          mInterstitialAds = createInterstitialAd()..load();
        }
      },
    );
  }

  // 加载奖励视频广告
  void loadVideoADS() {
    RewardedVideoAd.instance.load(
      adUnitId: Configs.admobVideoId,
      targetingInfo: targetingInfo,
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
