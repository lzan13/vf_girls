import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import 'package:vf_plugin/vf_plugin.dart';

import 'package:vf_girls/router/router_manger.dart';
import 'package:vf_girls/ui/widget/toast.dart';

List<String> tabTitle = ['tab1', 'tab2', 'tab3'];

///
/// 发现探索 Tab 页面
///
class ExplorePage extends StatefulWidget {
  @override
  ExplorePageState createState() => ExplorePageState();
}

class ExplorePageState extends State<ExplorePage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DefaultTabController(
      length: tabTitle.length,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: TabBar(
            isScrollable: true,
            tabs: List.generate(
              tabTitle.length,
              (index) => Tab(
                text: tabTitle[index],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: List.generate(
            tabTitle.length,
            (index) => ExploreList(),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

///
/// 发现列表
///
class ExploreList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ExploreListState();
}

class ExploreListState extends State<ExploreList> {
  @override
  Widget build(BuildContext context) {
    return EasyRefresh.custom(slivers: <Widget>[
      SliverList(
        delegate: SliverChildListDelegate([
          // 普通 Toast
          VFListItem(
            title: FlutterI18n.translate(context, 'Normal Toast'),
            describe: FlutterI18n.translate(context, 'show a normal toast'),
            onPressed: () {
              VFToast.show("普通 Toast");
            },
            leftIcon: Icons.nature,
          ),
          // 错误 Toast
          VFListItem(
            title: FlutterI18n.translate(context, 'Normal Toast'),
            describe: FlutterI18n.translate(context, 'show a normal toast'),
            onPressed: () {
              VFToast.error("错误 Toast，同时输出错误相关信息，可能会超过一行，自动换行");
            },
            leftIcon: Icons.error,
            leftIconColor: VFColors.red,
          ),
          // 完成 Toast
          VFListItem(
            title: FlutterI18n.translate(context, 'Normal Toast'),
            describe: FlutterI18n.translate(context, 'show a normal toast'),
            onPressed: () {
              VFToast.success("完成 Toast");
            },
            leftIcon: Icons.done,
            leftIconColor: VFColors.green,
          ),
          // 基本使用
          VFListItem(
            title: FlutterI18n.translate(context, 'basicUse'),
            describe: FlutterI18n.translate(context, 'basicUseDescribe'),
            onPressed: () {
              Router.toTest(context);
            },
          ),
        ]),
      ),
    ]);
  }
}
