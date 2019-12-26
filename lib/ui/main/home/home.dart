import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import 'package:vf_plugin/vf_plugin.dart';

import 'package:vf_girls/router/router_manger.dart';
import 'package:vf_girls/ui/widget/toast.dart';

import 'parse_girl.dart';

///
/// 首页 Tab 页面
///
class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Container(
        child: EasyRefresh.custom(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate([
                // 普通 Toast
                VFListItem(
                  title: FlutterI18n.translate(context, 'Normal Toast'),
                  describe:
                      FlutterI18n.translate(context, 'show a normal toast'),
                  onPressed: () {
                    VFToast.show("普通 Toast");
                  },
                  leftIcon: Icons.nature,
                ),
                // 错误 Toast
                VFListItem(
                  title: FlutterI18n.translate(context, 'Normal Toast'),
                  describe:
                      FlutterI18n.translate(context, 'show a normal toast'),
                  onPressed: () {
                    VFToast.error("错误 Toast，同时输出错误相关信息，可能会超过一行，自动换行");
                  },
                  leftIcon: Icons.error,
                  leftIconColor: VFColors.red,
                ),
                // 完成 Toast
                VFListItem(
                  title: FlutterI18n.translate(context, 'Normal Toast'),
                  describe:
                      FlutterI18n.translate(context, 'show a normal toast'),
                  onPressed: () {
                    VFToast.success("完成 Toast");
                    loadData();
                  },
                  leftIcon: Icons.done,
                  leftIconColor: VFColors.green,
                ),
                // 基本使用
                VFListItem(
                  title: FlutterI18n.translate(context, 'basicUse'),
                  describe: FlutterI18n.translate(context, 'basicUseDescribe'),
                  onPressed: () {
                    Router.toNotFound(context);
                  },
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
