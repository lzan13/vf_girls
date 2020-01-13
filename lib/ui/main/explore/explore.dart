import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/ball_pulse_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:vf_plugin/vf_plugin.dart';

import 'package:vf_girls/request/bean/girl_bean.dart';
import 'package:vf_girls/request/girls_manager.dart';
import 'package:vf_girls/router/router_manger.dart';
import 'package:vf_girls/ui/widget/custom_tab.dart';
import 'package:vf_girls/ui/widget/dialog_loading.dart';
import 'package:vf_girls/ui/widget/falls_item.dart';

///
/// 发现探索 Tab 页面
///
class ExplorePage extends StatefulWidget {
  @override
  ExplorePageState createState() => ExplorePageState();
}

class ExplorePageState extends State<ExplorePage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  // tab 结合
  List<GirlBean> mTabList = [];

  @override
  void initState() {
    super.initState();
    initTab();
  }

  void initTab() {
    String jsonStr =
        '[{"title":"清纯美眉","jumpUrl":"http://www.meinvtu.site/list-cateId-3.html"},{"title":"性感美女","jumpUrl":"http://www.meinvtu.site/list-cateId-2.html"},{"title":"Cosplay","jumpUrl":"http://www.meinvtu.site/list-cateId-20.html"},{"title":"性感美女","jumpUrl":"http://www.meinv666.site/list-cateId-2.html"},{"title":"性爱私拍","jumpUrl":"http://www.meinv666.site/list-cateId-1.html"},{"title":"性感动漫","jumpUrl":"http://www.meinv666.site/list-cateId-21.html"},{"title":"甜美萝莉","jumpUrl":"http://www.meinv666.site/list-cateId-5.html"},{"title":"自拍街拍","jumpUrl":"http://www.meinv666.site/list-cateId-4.html"},{"title":"清纯美眉","jumpUrl":"http://www.meinv666.site/list-cateId-3.html"}]';
    List jsonList = json.decode(jsonStr);
    for (int i = 0; i < jsonList.length; i++) {
      mTabList.add(GirlBean.fromJson(jsonList[i]));
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DefaultTabController(
      length: mTabList.length,
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
              mTabList.length,
              (index) => VFTab(
                text: mTabList[index].title,
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: List.generate(
            mTabList.length,
            (index) => ExploreBody(mTabList[index]),
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
class ExploreBody extends StatefulWidget {
  GirlBean entity;

  ExploreBody(this.entity);

  @override
  State<StatefulWidget> createState() => ExploreBodyState();
}

class ExploreBodyState extends State<ExploreBody>
    with AutomaticKeepAliveClientMixin {
  bool enableRefresh = true;
  bool enableLoad = true;

  // 刷新控制类，必须有，否则列表无法滚动
  EasyRefreshController _controller = EasyRefreshController();

  // 加载数据
  dynamic girlList = [];
  int page = 0;

  ///
  /// 加载数据 isRefresh 表示是否刷新，如果是，则从第一页加载
  ///
  void loadData(isRefresh) async {
    String url = '';
    if (isRefresh) {
      page = 0;
      url = widget.entity.jumpUrl;
    } else {
      page++;
      url = '${widget.entity.jumpUrl}?page=$page';
    }
    dynamic result = await GirlsManager.loadData(url);
    setState(() {
      if (isRefresh) {
        girlList.clear();
      }
      girlList.addAll(result);
    });
    // 数据加载结束，重置刷新加载状态
    if (isRefresh) {
      _controller.finishRefresh(success: true);
    } else {
      _controller.finishLoad(
        success: true,
        noMore: false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      firstRefresh: true,
      firstRefreshWidget: DialogLoading(),
      header: BallPulseHeader(color: Theme.of(context).primaryColor),
      footer: BallPulseFooter(color: Theme.of(context).primaryColor),
      onRefresh: enableRefresh
          ? () async {
              await loadData(true);
            }
          : null,
      onLoad: enableLoad
          ? () async {
              await loadData(false);
            }
          : null,
      child: StaggeredGridView.countBuilder(
        itemCount: this.girlList.length,
        primary: false,
        crossAxisCount: 2,
        mainAxisSpacing: VFDimens.d_4,
        crossAxisSpacing: VFDimens.d_4,
        itemBuilder: (context, index) {
          GirlBean entity = girlList[index];
          return FallsItem(
            bean: entity,
            callback: () => Router.toDetail(context, entity),
          );
        },
        staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
        padding: EdgeInsets.only(
          left: VFDimens.padding_little,
          right: VFDimens.padding_little,
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
