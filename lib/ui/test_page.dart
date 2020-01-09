import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:vf_girls/ui/widget/dialog_loading.dart';

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
  // 总数
  int _count = 0;

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
        firstRefresh: true,
        firstRefreshWidget: DialogLoading(),
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return VFExampleItem();
              },
              childCount: _count,
            ),
          ),
        ],
        onRefresh: () async {
          await Future.delayed(Duration(seconds: 3), () {
            setState(() {
              _count = 20;
            });
          });
        },
        onLoad: () async {
          await Future.delayed(Duration(seconds: 2), () {
            setState(() {
              _count += 20;
            });
          });
        },
      ),
    );
  }
}
