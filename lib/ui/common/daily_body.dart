import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/ball_pulse_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:vf_plugin/vf_plugin.dart';

import 'package:vf_girls/common/index.dart';
import 'package:vf_girls/request/bean/girl_bean.dart';
import 'package:vf_girls/request/bean/category_bean.dart';
import 'package:vf_girls/request/bean/daily_bean.dart';
import 'package:vf_girls/request/girls_manager.dart';
import 'package:vf_girls/router/router_manger.dart';

///
/// 日常更新 UI Body 部分
///
class DailyBody extends StatefulWidget {
  CategoryBean category;

  DailyBody(this.category);

  @override
  State<StatefulWidget> createState() => DailyBodyState();
}

class DailyBodyState extends State<DailyBody>
    with AutomaticKeepAliveClientMixin {
  bool enableRefresh = true;
  bool enableLoad = true;

  // 刷新控制类，必须有，否则列表无法滚动
  EasyRefreshController _controller = EasyRefreshController();

  // 加载数据
  DailyBean daily;

  @override
  void initState() {
    super.initState();
    VFLog.d('FallsList initState');
    daily = new DailyBean();
    daily.topGirls = [];
    daily.images = [];
  }

  ///
  /// 加载数据 isRefresh 表示是否刷新，如果是，则从第一页加载
  ///
  void loadData(isRefresh) async {
    String url = '';
    if (isRefresh) {
      url = widget.category.url;
    } else {
      url = daily.next;
    }
    DailyBean result = await GirlsManager.loadDaily(url);
    setState(() {
      if (isRefresh) {
        daily.images.clear();
        daily.topGirls.clear();
        daily.topGirls = result.topGirls;
      }
      daily.next = result.next;
      daily.images.addAll(result.images);
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
    super.build(context);
    return EasyRefresh(
      controller: _controller,
      firstRefresh: true,
      firstRefreshWidget: VFDialogLoading(),
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
        itemCount: daily.topGirls.length + daily.images.length,
        primary: false,
        crossAxisCount: 4,
        mainAxisSpacing: VFDimens.d_4,
        crossAxisSpacing: VFDimens.d_4,
        padding: EdgeInsets.only(
          left: VFDimens.padding_small,
          right: VFDimens.padding_small,
        ),
        staggeredTileBuilder: (int index) => StaggeredTile.count(
          index < daily.topGirls.length ? 1 : 2,
          index < daily.topGirls.length ? 1 : 3,
        ),
        itemBuilder: (context, index) {
          if (index < daily.topGirls.length) {
            GirlBean bean = daily.topGirls[index];
            return GestureDetector(
              onTap: () {
                Router.toDetail(context, bean);
              },
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(VFDimens.border_radius_normal),
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: Hero(
                    tag: bean.cover + 'cover',
                    child: CachedNetworkImage(
                      httpHeaders: {'Referer': bean.cover},
                      fit: BoxFit.cover,
                      imageUrl: bean.cover,
                      placeholder: (context, url) => Image.asset(
                        RESHelper.wrapImage('img_default.png'),
                        fit: BoxFit.cover,
                      ),
                      // Padding(
                      //   padding: EdgeInsets.all(VFDimens.d_20),
                      //   child: VFLoading(),
                      // ),
                    ),
                  ),
                ),
              ),
            );
          } else {
            //底部图片
            String image = daily.images[index - daily.topGirls.length];
            return GestureDetector(
              onTap: () {
                Router.toDisplayMulti(
                    context, daily.images, index - daily.topGirls.length);
              },
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(VFDimens.border_radius_normal),
                child: CachedNetworkImage(
                  httpHeaders: {'Referer': image},
                  fit: BoxFit.cover,
                  imageUrl: image,
                  placeholder: (context, url) => Image.asset(
                    RESHelper.wrapImage('img_default_big.png'),
                    fit: BoxFit.cover,
                  ),
                  // Padding(
                  //   padding: EdgeInsets.all(VFDimens.d_20),
                  //   child: VFLoading(),
                  // ),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
