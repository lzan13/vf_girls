import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:vf_plugin/vf_plugin.dart';

import 'package:vf_girls/request/bean/girl.dart';
import 'package:vf_girls/ui/widget/empty.dart';
import 'package:vf_girls/ui/widget/loading.dart';
import 'package:vf_girls/ui/widget/staggered_item.dart';
import 'package:vf_girls/request/girls_manager.dart';
import 'package:vf_girls/router/router_manger.dart';

///
/// 首页 Tab 页面
///
class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  // 刷新控制类，必须有，否则列表无法滚动
  EasyRefreshController _controller = EasyRefreshController();
  // 加载数据
  dynamic girlList = [];
  bool enableRefresh = true;
  bool enableLoad = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    _controller.callRefresh();
    // _controller.callLoad();

    return Container(
      child: EasyRefresh(
        // controller: _controller,
        emptyWidget: this.girlList.length == 0 ? EmptyPage() : null,
        firstRefresh: true,
        firstRefreshWidget: Loading(),
        onRefresh: enableRefresh
            ? () async {
                loadData();
              }
            : null,
        onLoad: enableLoad
            ? () async {
                // loadData();
              }
            : null,
        child: StaggeredGridView.countBuilder(
          itemCount: this.girlList.length > 0 ? this.girlList.length : 0,
          primary: false,
          crossAxisCount: 2,
          mainAxisSpacing: VFDimens.d_4,
          crossAxisSpacing: VFDimens.d_4,
          itemBuilder: (context, index) {
            GirlEntity entity = girlList[index];
            return StaggeredItem(
              entity: entity,
              callback: () => Router.toDetail(context, entity),
            );
          },
          staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
          // StaggeredTile.count(2, index.isEven ? 3 : 2.5),
          padding: EdgeInsets.only(
            left: VFDimens.padding_little,
            right: VFDimens.padding_little,
          ),
        ),
      ),
    );
  }

  ///
  /// 加载数据
  /// isRefresh 表示是否刷新，如果是，则从第一页加载
  void loadData() async {
    dynamic result = await GirlsManager.loadHomeData();
    setState(() {
      girlList.clear();
      girlList.addAll(result);
    });
    // 数据加载结束，重置刷新加载状态
    // if (isRefresh) {
    _controller.finishRefresh(success: true);
    // } else {
    //   _controller.finishLoad(
    //     success: true,
    //     noMore: false,
    //   );
    // }
  }

  @override
  bool get wantKeepAlive => true;
}
