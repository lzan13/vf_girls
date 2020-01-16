import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:vf_girls/router/router_manger.dart';

import 'package:vf_plugin/vf_plugin.dart';

import 'package:vf_girls/common/resource_manager.dart';

/// 首次刷新示例
class TestPage extends StatefulWidget {
  @override
  TestPageState createState() {
    return TestPageState();
  }
}

class TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
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
              // 测试
              VFListItem(
                title: FlutterI18n.translate(context, 'splash'),
                onPressed: () {
                  Router.toSplash(context);
                },
                leftIcon: VFIcons.ic_settings,
                rightIcon: VFIcons.ic_arrow_right,
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
