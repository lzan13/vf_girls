import 'package:flutter/material.dart';
import 'package:vf_plugin/vf_plugin.dart';

import 'package:vf_girls/common/index.dart';
import 'package:vf_girls/request/bean/category_bean.dart';
import 'package:vf_girls/ui/common/falls_body.dart';

///
/// 首页页面
///
class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  List<CategoryBean> tabList = [];

  @override
  void initState() {
    super.initState();
    VFLog.d('HomePage initState');
    initTab();
  }

  void initTab() {
    tabList = JSONHelper.getHomeTabs();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DefaultTabController(
      length: tabList.length,
      initialIndex: 0,
      child: Scaffold(
        appBar: VFTopBar(
          bgColor: VFColors.transparent,
          top: MediaQuery.of(context).padding.top,
          // 配置 tabbar
          titleWidget: TabBar(
            isScrollable: true,
            indicator: VFTabIndicator(
              width: VFDimens.d_24,
              borderSide: BorderSide(
                width: VFDimens.d_3,
                color: Theme.of(context).textTheme.title.color,
              ),
            ),
            labelColor: Theme.of(context).textTheme.title.color,
            labelStyle: TextStyle(
              fontSize: VFSizes.s_16,
              fontWeight: FontWeight.bold,
            ),
            labelPadding: EdgeInsets.only(left: 0, right: 0),
            unselectedLabelStyle: TextStyle(
              fontSize: VFSizes.s_16,
              fontWeight: FontWeight.w500,
            ),
            tabs: List.generate(
              tabList.length,
              (index) => Padding(
                padding: EdgeInsets.only(
                  left: VFDimens.d_8,
                  right: VFDimens.d_8,
                ),
                child: VFTab(
                  text: tabList[index].title,
                ),
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: List.generate(
            tabList.length,
            (index) => FallsBody(tabList[index]),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
