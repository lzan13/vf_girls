import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/ball_pulse_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:vf_girls/request/bean/girl.dart';
import 'package:vf_girls/request/girls_manager.dart';
import 'package:vf_girls/ui/widget/dialog_loading.dart';
import 'package:vf_girls/ui/widget/falls_item.dart';

import 'package:vf_plugin/vf_plugin.dart';

import 'package:vf_girls/router/router_manger.dart';
import 'package:vf_girls/ui/widget/toast.dart';

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
  List<GirlEntity> mTabList = [];

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
      mTabList.add(GirlEntity.fromJson(jsonList[i]));
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
          title: TabBar(
            isScrollable: true,
            tabs: List.generate(
              mTabList.length,
              (index) => Tab(
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
  GirlEntity entity;

  ExploreBody(this.entity);

  @override
  State<StatefulWidget> createState() => ExploreBodyState();
}

class ExploreBodyState extends State<ExploreBody> {
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
    print('请求地址 $url');
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
          GirlEntity entity = girlList[index];
          return FallsItem(
            entity: entity,
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
    // EasyRefresh.custom(slivers: <Widget>[
    //   SliverList(
    //     delegate: SliverChildListDelegate([
    //       // 普通 Toast
    //       VFListItem(
    //         title: FlutterI18n.translate(context, 'Normal Toast'),
    //         describe: FlutterI18n.translate(context, 'show a normal toast'),
    //         onPressed: () {
    //           VFToast.show("普通 Toast");
    //         },
    //         leftIcon: Icons.nature,
    //       ),
    //       // 错误 Toast
    //       VFListItem(
    //         title: FlutterI18n.translate(context, 'Normal Toast'),
    //         describe: FlutterI18n.translate(context, 'show a normal toast'),
    //         onPressed: () {
    //           VFToast.error("错误 Toast，同时输出错误相关信息，可能会超过一行，自动换行");
    //         },
    //         leftIcon: Icons.error,
    //         leftIconColor: VFColors.red,
    //       ),
    //       // 完成 Toast
    //       VFListItem(
    //         title: FlutterI18n.translate(context, 'Normal Toast'),
    //         describe: FlutterI18n.translate(context, 'show a normal toast'),
    //         onPressed: () {
    //           VFToast.success("完成 Toast");
    //         },
    //         leftIcon: Icons.done,
    //         leftIconColor: VFColors.green,
    //       ),
    //       // 基本使用
    //       VFListItem(
    //         title: FlutterI18n.translate(context, 'basicUse'),
    //         describe: FlutterI18n.translate(context, 'basicUseDescribe'),
    //         onPressed: () {
    //           Router.toTest(context);
    //         },
    //       ),
    //     ]),
    //   ),
    // ]);
  }
}
