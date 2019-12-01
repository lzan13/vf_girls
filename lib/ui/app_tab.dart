import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import 'home/home.dart';
import 'explore/explore.dart';
import 'mine/mine.dart';


class AppTab extends StatefulWidget {
  AppTab({Key key}) : super(key: key);

  @override
  AppTabState createState() => AppTabState();
}

class AppTabState extends State<AppTab> with SingleTickerProviderStateMixin{
  // 页面控制
  TabController _tabController;

  // 初始化
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
    SchedulerBinding.instance.addPostFrameCallback((Duration timestamp) {
      // 设置EasyRefresh的默认样式
      EasyRefresh.defaultHeader = ClassicalHeader(
        enableInfiniteRefresh: false,
        refreshText: FlutterI18n.translate(context, 'refresh_to_pull'),
        refreshReadyText: FlutterI18n.translate(context, 'refresh_release'),
        refreshingText: FlutterI18n.translate(context, 'refreshing'),
        refreshedText: FlutterI18n.translate(context, 'refreshed'),
        infoText: FlutterI18n.translate(context, 'refresh_update_at'),
        refreshFailedText: FlutterI18n.translate(context, 'refresh_failed'),
        noMoreText: FlutterI18n.translate(context, 'load_no_more'),
      );
      EasyRefresh.defaultFooter = ClassicalFooter(
        enableInfiniteLoad: true,
        loadText: FlutterI18n.translate(context, 'load_to_push'),
        loadReadyText: FlutterI18n.translate(context, 'load_release'),
        loadingText: FlutterI18n.translate(context, 'loading'),
        loadedText: FlutterI18n.translate(context, 'loaded'),
        loadFailedText: FlutterI18n.translate(context, 'load_failed'),
        noMoreText: FlutterI18n.translate(context, 'load_no_more'),
        infoText: FlutterI18n.translate(context, 'load_update_at'),
      );
    });
  }

  // 底部栏切换
  void _onBottomNavigationBarTap(int index) {
    setState(() {
      _tabController.index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[Home(), Explore(), Mine()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tabController.index,
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.black,
        onTap: _onBottomNavigationBarTap,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              title: Text(FlutterI18n.translate(context, 'tab_home'))),
          BottomNavigationBarItem(
              icon: Icon(Icons.style),
              title: Text(FlutterI18n.translate(context, 'tab_explore'))),
          BottomNavigationBarItem(
              icon: Icon(Icons.more_vert),
              title: Text(FlutterI18n.translate(context, 'tab_mine'))),
        ],
      ),
    );
  }
}