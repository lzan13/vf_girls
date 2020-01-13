import 'package:flutter/material.dart';
import 'package:vf_plugin/vf_plugin.dart';

import 'package:vf_girls/common/json_manager.dart';
import 'package:vf_girls/request/bean/tab_bean.dart';
import 'package:vf_girls/ui/widget/custom_tab.dart';
import 'package:vf_girls/ui/widget/falls_list.dart';

///
/// 首页 Tab 页面
///
class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  List<TabBean> tabList = [];

  @override
  void initState() {
    super.initState();
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
        appBar: AppBar(
          backgroundColor: VFColors.transparent,
          title: TabBar(
            isScrollable: true,
            indicator: VFTabIndicator(
              borderSide: BorderSide(
                width: VFDimens.d_3,
                color: Theme.of(context).accentColor,
              ),
            ),
            labelColor: Theme.of(context).accentColor,
            labelStyle: TextStyle(
              fontSize: VFSizes.s_20,
              fontWeight: FontWeight.bold,
            ),
            labelPadding: EdgeInsets.only(left: 0, right: 0),
            unselectedLabelColor: VFColors.grey87,
            unselectedLabelStyle: TextStyle(
              fontSize: VFSizes.s_14,
              fontWeight: FontWeight.w400,
            ),
            tabs: List.generate(
              tabList.length,
              (index) => VFTab(
                text: tabList[index].title,
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: List.generate(
            tabList.length,
            (index) => FallsList(tabList[index]),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
