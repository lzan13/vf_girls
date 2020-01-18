import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:provider/provider.dart';
import 'package:vf_girls/view_model/sign_model.dart';

import 'package:vf_plugin/vf_plugin.dart';

import 'package:vf_girls/ads/ads_manager.dart';
import 'package:vf_girls/common/index.dart';
import 'package:vf_girls/router/router_manger.dart';

/// 首次刷新示例
class TestPage extends StatefulWidget {
  @override
  TestPageState createState() {
    return TestPageState();
  }
}

class TestPageState extends State<TestPage> {
  @override
  void initState() {
    super.initState();
    // 初始化 ADS
    ADSManager.instance.initADS();
  }

  @override
  void dispose() {
    super.dispose();
    ADSManager.instance.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SignModel model = Provider.of<SignModel>(context);
    return Scaffold(
      appBar: VFTopBar(
        top: MediaQuery.of(context).padding.top,
        title: FlutterI18n.translate(context, "test"),
        titleColor: VFColors.white,
        leftIcon: VFIcons.ic_arrow_left,
      ),
      // body: DialogLoading(),
      body: EasyRefresh.custom(
        firstRefresh: false,
        firstRefreshWidget: VFDialogLoading(),
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate([
              VFListItem(
                isNewGroup: true,
                showDivider: false,
                title: model.isSign
                    ? '你当前拥有 ${model.user.gold} V币'
                    : '你还没有登录，无法记录金币',
              ),
              // 测试
              VFListItem(
                isNewGroup: true,
                title: FlutterI18n.translate(context, 'splash'),
                onPressed: () {
                  Router.toSplash(context);
                },
                rightIcon: VFIcons.ic_arrow_right,
              ),
              VFListItem(
                isNewGroup: true,
                title: '显示横幅广告',
                onPressed: () {
                  ADSManager.instance.showBannerADS();
                },
              ),
              VFListItem(
                title: '移除横幅广告',
                onPressed: () {
                  ADSManager.instance.hideBannerADS();
                },
              ),
              VFListItem(
                title: '显示插屏广告',
                onPressed: () {
                  ADSManager.instance.showInterstitialADS();
                },
              ),
              VFListItem(
                title: '显示奖励视频广告',
                onPressed: () {
                  ADSManager.instance.showVideoADS();
                },
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
