import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/ball_pulse_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:vf_plugin/vf_plugin.dart';

import 'package:vf_girls/request/bean/category_bean.dart';
import 'package:vf_girls/request/bean/girl_bean.dart';
import 'package:vf_girls/request/girls_manager.dart';
import 'package:vf_girls/router/router_manger.dart';
import 'package:vf_girls/ui/widget/dialog_loading.dart';
import 'package:vf_girls/ui/widget/falls_item.dart';

///
/// 发现列表
///
class FallsList extends StatefulWidget {
  CategoryBean category;

  FallsList(this.category);

  @override
  State<StatefulWidget> createState() => FallsListState();
}

class FallsListState extends State<FallsList>
    with AutomaticKeepAliveClientMixin {
  bool enableRefresh = true;
  bool enableLoad = true;

  // 刷新控制类，必须有，否则列表无法滚动
  EasyRefreshController _controller = EasyRefreshController();

  // 加载数据
  dynamic girlList = [];
  int page = 1;

  ///
  /// 加载数据 isRefresh 表示是否刷新，如果是，则从第一页加载
  ///
  void loadData(isRefresh) async {
    String url = '';
    if (isRefresh) {
      page = 1;
      url = widget.category.url;
    } else {
      page++;
      url = '${widget.category.url}page/$page/';
    }
    dynamic result = await GirlsManager.loadHomeData(url);
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
      header: BallPulseHeader(color: Theme.of(context).accentColor),
      footer: BallPulseFooter(color: Theme.of(context).accentColor),
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
        crossAxisCount: 4,
        mainAxisSpacing: VFDimens.d_4,
        crossAxisSpacing: VFDimens.d_4,
        itemBuilder: (context, index) {
          GirlBean girlBean = girlList[index];
          return FallsItem(
            bean: girlBean,
            callback: () => Router.toDetail(context, girlBean),
          );
        },
        staggeredTileBuilder: (int index) => StaggeredTile.count(2, 3),
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
