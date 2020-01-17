import 'package:flutter/material.dart';
import 'package:vf_girls/ui/common/daily_body.dart';
import 'package:vf_plugin/vf_plugin.dart';

import 'package:vf_girls/common/index.dart';
import 'package:vf_girls/request/bean/category_bean.dart';

///
/// 标签分类页面
///
class ExplorePage extends StatefulWidget {
  @override
  ExplorePageState createState() => ExplorePageState();
}

class ExplorePageState extends State<ExplorePage>
    with AutomaticKeepAliveClientMixin {
  List<CategoryBean> tabList = [];

  @override
  void initState() {
    super.initState();
    VFLog.d('ExplorePage initState');
    initTab();
  }

  void initTab() {
    tabList = JSONHelper.getExploreTabs();
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
            (index) => DailyBody(tabList[index]),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
