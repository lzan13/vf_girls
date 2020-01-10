import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import 'package:vf_plugin/vf_plugin.dart';

import 'package:vf_girls/common/resource_manager.dart';
import 'package:vf_girls/request/bean/girl.dart';
import 'package:vf_girls/request/girls_manager.dart';
import 'package:vf_girls/ui/widget/dialog_loading.dart';

import 'package:vf_girls/router/router_manger.dart';

///
/// 图片详情页面
///
class DetailPage extends StatefulWidget {
  GirlEntity mEntity;

  DetailPage(this.mEntity);

  @override
  DetailPageState createState() => DetailPageState();
}

class DetailPageState extends State<DetailPage> {
  // 刷新控制类，必须有，否则列表无法滚动
  EasyRefreshController _controller = EasyRefreshController();
  // 加载数据
  List<GirlEntity> girls = [];
  bool enableRefresh = true;
  bool enableLoad = false;

  // 连接通知器
  LinkHeaderNotifier linkNotifier;

  @override
  void initState() {
    super.initState();
    linkNotifier = LinkHeaderNotifier();
  }

  @override
  void dispose() {
    super.dispose();
    linkNotifier.dispose();
  }

  ///
  /// 加载数据
  ///
  void loadGirls() async {
    dynamic result = await GirlsManager.loadDetail(widget.mEntity.jumpUrl);
    setState(() {
      girls.clear();
      girls.addAll(result);
    });
    // // 数据加载结束，重置刷新加载状态
    // // if (isRefresh) {
    _controller.finishRefresh(success: true);
    // } else {
    //   _controller.finishLoad(
    //     success: true,
    //     noMore: false,
    //   );
    // }
  }

  ///
  /// 设置标题
  ///
  Widget buildTitle(String title) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  ///
  /// 板顶 Grid 数据
  ///
  List<Widget> bindGrid() {
    List<Widget> children = [];
    for (int i = 0; i < (girls.length > 9 ? 9 : girls.length); i++) {
      GirlEntity entity = girls[i];
      // 根据图片数量判断是否显示最后的更多数量
      var countWidget = Container(
          child: i == 8 && girls.length > 9
              ? Text(
                  '+${girls.length}',
                  style: TextStyle(
                    color: VFColors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: VFSizes.s_30,
                  ),
                )
              : Container());
      // 将图片加载到集合中
      children.add(
        GestureDetector(
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              AspectRatio(
                aspectRatio: 1.0,
                child: Hero(
                  tag: entity.imgUrl,
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: entity.imgUrl,
                    placeholder: (context, url) => Padding(
                      padding: EdgeInsets.all(VFDimens.d_36),
                      child: VFLoading(type: VFLoadingType.threeBounce),
                    ),
                  ),
                ),
              ),
              countWidget,
            ],
          ),
          onTap: () => Router.toDisplayMulti(context, girls, i),
        ),
      );
    }
    return children;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EasyRefresh.custom(
        firstRefresh: true,
        firstRefreshWidget: DialogLoading(),
        header: LinkHeader(
          linkNotifier,
          extent: 70.0,
          triggerDistance: 70.0,
          completeDuration: Duration(milliseconds: 500),
        ),
        onRefresh: enableRefresh
            ? () async {
                loadGirls();
              }
            : null,
        onLoad: enableLoad
            ? () async {
                // loadData();
              }
            : null,
        slivers: <Widget>[
          // 顶部伸缩布局
          SliverPersistentHeader(
            pinned: true,
            delegate: VFSliverDelegate(
              title: widget.mEntity.title,
              collapsedHeight: VFDimens.d_48,
              expandedHeight: VFDimens.d_320,
              top: MediaQuery.of(context).padding.top,
              leftIcon: VFIcons.ic_arrow_left,
              rightWidget: RefreshIndicator(linkNotifier),
              coverWidget: Hero(
                tag: widget.mEntity.imgUrl,
                child: CachedNetworkImage(
                  imageUrl: widget.mEntity.imgUrl + "cover",
                  placeholder: (context, url) => Padding(
                    padding: EdgeInsets.all(VFDimens.d_36),
                    child: VFLoading(type: VFLoadingType.threeBounce),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          buildTitle(widget.mEntity.title),
          // 加载 GridView
          SliverGrid.count(
            crossAxisCount: 3,
            crossAxisSpacing: VFDimens.d_8,
            mainAxisSpacing: VFDimens.d_8,
            children: bindGrid(),
          ),
          buildTitle(FlutterI18n.translate(context, 'comment')),
          SliverFixedExtentList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => VFExampleItem(),
              childCount: 50,
            ),
            itemExtent: 100,
          ),
        ],
      ),
    );
  }
}

///
/// 自定义链接下拉刷新指示器
///
class RefreshIndicator extends StatefulWidget {
  final LinkHeaderNotifier linkNotifier;

  const RefreshIndicator(this.linkNotifier, {Key key}) : super(key: key);

  @override
  RefreshIndicatorState createState() => RefreshIndicatorState();
}

class RefreshIndicatorState extends State<RefreshIndicator> {
  // 触发刷新百分比
  double triggerValue = 0.0;
  // 刷新状态
  RefreshMode get refreshState => widget.linkNotifier.refreshState;
  // 下拉范围距离
  double get pulledExtent => widget.linkNotifier.pulledExtent;

  @override
  void initState() {
    super.initState();
    widget.linkNotifier.addListener(onRefreshCallback);
  }

  ///
  /// 刷新回调
  ///
  void onRefreshCallback() {
    setState(() {
      if (refreshState == RefreshMode.armed ||
          refreshState == RefreshMode.refresh ||
          refreshState == RefreshMode.refreshed ||
          refreshState == RefreshMode.done) {
        triggerValue = 1.0;
      } else {
        if (refreshState == RefreshMode.inactive) {
          triggerValue = 0.0;
        } else {
          double value = pulledExtent / 70.0;
          triggerValue = value < 1.0 ? value : 1.0;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: VFDimens.d_48,
      height: VFDimens.d_48,
      child: VFLoading(
        color: VFColors.white,
        size: triggerValue * VFDimens.d_24,
      ),
    );
  }
}
