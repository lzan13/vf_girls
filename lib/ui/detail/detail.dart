import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:vf_plugin/vf_plugin.dart';

import 'package:vf_girls/common/resource_manager.dart';
import 'package:vf_girls/request/bean/girl_bean.dart';
import 'package:vf_girls/request/girls_manager.dart';
import 'package:vf_girls/router/router_manger.dart';
import 'package:vf_girls/ui/widget/dialog_loading.dart';

///
/// 详情页面
///
class DetailPage extends StatefulWidget {
  GirlBean girl;

  DetailPage(this.girl);

  @override
  DetailPageState createState() => DetailPageState();
}

class DetailPageState extends State<DetailPage> {
  // 刷新控制类，必须有，否则列表无法滚动
  EasyRefreshController _controller = EasyRefreshController();
  // 加载数据
  List<String> imgList = [];
  // 连接通知器
  LinkHeaderNotifier linkNotifier;

  DetailPageState();

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
  void loadData(isRefresh) async {
    await loadDetail();
    // loadComment(isRefresh);
    // // 数据加载结束，重置刷新加载状态
    if (isRefresh) {
      _controller.finishRefresh(success: true);
    }
  }

  ///
  /// 加载详情数据
  ///
  void loadDetail() async {
    GirlBean result = await GirlsManager.loadGirlDetail(widget.girl.jumpUrl);
    setState(() {
      widget.girl.title = result.title;
      widget.girl.images = result.images;
      widget.girl.count = result.count;
      widget.girl.time = result.time;
      widget.girl.category = result.category;
      imgList.clear();
      imgList.addAll(widget.girl.images);
    });
  }

  ///
  /// 加载评论
  ///
  void loadComment(isRefresh) {
    if (!isRefresh) {
      _controller.finishLoad(
        success: true,
        noMore: false,
      );
    }
  }

  ///
  /// 组合详细信息Widget
  ///
  Widget bindDetailWidget() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      VFIcons.ic_time,
                      color: Theme.of(context).accentColor.withAlpha(128),
                      size: VFDimens.d_18,
                    ),
                    Text(
                      widget.girl.time,
                      style: TextStyle(
                        color: VFColors.grey87,
                        fontSize: VFSizes.s_12,
                      ),
                    ),
                  ],
                ),
                // 分类
                Container(
                  margin: EdgeInsets.all(VFDimens.margin_small),
                  decoration: BoxDecoration(
                    color: VFColors.black38,
                    borderRadius: BorderRadius.all(
                      Radius.circular(VFDimens.border_radius_large),
                    ),
                  ),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(
                      VFDimens.padding_small,
                      VFDimens.padding_little,
                      VFDimens.padding_small,
                      VFDimens.padding_little,
                    ),
                    child: Text(
                      widget.girl.category == null
                          ? ''
                          : widget.girl.category.title,
                      style: TextStyle(
                        color: VFColors.white87,
                        fontSize: VFSizes.s_14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: VFDimens.d_4),
            Text(
              widget.girl.title,
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: VFSizes.s_16),
            ),
          ],
        ),
      ),
    );
  }

  ///
  /// 绑定图片网格数据
  ///
  Widget bindGrid() {
    return SliverPadding(
      padding: const EdgeInsets.all(8.0),
      sliver: new SliverGrid(
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, //Grid按两列显示
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
          childAspectRatio: 1.0,
        ),
        delegate: new SliverChildBuilderDelegate(
          (context, index) {
            //创建子widget
            return GestureDetector(
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Hero(
                    tag: imgList[index],
                    child: CachedNetworkImage(
                      httpHeaders: {
                        'Referer':
                            DateTime.now().millisecondsSinceEpoch.toString()
                      },
                      fit: BoxFit.cover,
                      imageUrl: imgList[index],
                      placeholder: (context, url) => Padding(
                        padding: EdgeInsets.all(VFDimens.d_20),
                        child: VFLoading(type: VFLoadingType.threeBounce),
                      ),
                    ),
                  ),
                  // countWidget,
                ],
              ),
              onTap: () => Router.toDisplayMulti(context, imgList, index),
            );
          },
          childCount: imgList.length > 9 ? 9 : imgList.length,
        ),
      ),
    );

    // List<Widget> children = [];
    // for (int i = 0; i < (imgList.length > 9 ? 9 : imgList.length); i++) {
    //   String image = imgList[i];
    //   // 根据图片数量判断是否显示最后的更多数量
    //   var countWidget = Container(
    //       child: i == 8 && imgList.length > 9
    //           ? Text(
    //               '+${imgList.length}',
    //               style: TextStyle(
    //                 color: VFColors.white,
    //                 fontWeight: FontWeight.w500,
    //                 fontSize: VFSizes.s_30,
    //               ),
    //             )
    //           : Container());
    //   // 将图片加载到集合中
    //   children.add(
    //     GestureDetector(
    //       child: Stack(
    //         alignment: Alignment.center,
    //         children: <Widget>[
    //           AspectRatio(
    //             aspectRatio: 1.0,
    //             child: Hero(
    //               tag: image,
    //               child: CachedNetworkImage(
    //                 httpHeaders: {
    //                   'Referer':
    //                       DateTime.now().millisecondsSinceEpoch.toString()
    //                 },
    //                 fit: BoxFit.cover,
    //                 imageUrl: image,
    //                 placeholder: (context, url) => Padding(
    //                   padding: EdgeInsets.all(VFDimens.d_20),
    //                   child: VFLoading(type: VFLoadingType.threeBounce),
    //                 ),
    //               ),
    //             ),
    //           ),
    //           countWidget,
    //         ],
    //       ),
    //       onTap: () => Router.toDisplayMulti(context, imgList, i),
    //     ),
    //   );
    // }
    // return children;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EasyRefresh.custom(
        firstRefresh: true,
        // firstRefreshWidget: DialogLoading(),
        header: LinkHeader(
          linkNotifier,
          extent: 70.0,
          triggerDistance: 70.0,
          completeDuration: Duration(milliseconds: 500),
        ),
        onRefresh: () async {
          await loadData(true);
        },
        onLoad: () async {
          // await loadComment(false);
        },
        slivers: <Widget>[
          // 顶部伸缩布局
          SliverPersistentHeader(
            pinned: true,
            delegate: VFSliverDelegate(
              title: widget.girl.title,
              collapsedHeight: VFDimens.d_48,
              expandedHeight: VFDimens.d_320,
              top: MediaQuery.of(context).padding.top,
              leftIcon: VFIcons.ic_arrow_left,
              rightWidget: RefreshIndicator(linkNotifier),
              coverWidget: Hero(
                tag: widget.girl.cover,
                child: CachedNetworkImage(
                  imageUrl: widget.girl.cover,
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
          //  组合详细信息Widget
          bindDetailWidget(),
          // 网格数据
          bindGrid(),
          // SliverGrid.count(
          //   crossAxisCount: 3,
          //   crossAxisSpacing: VFDimens.d_8,
          //   mainAxisSpacing: VFDimens.d_8,
          //   children: bindGrid(),
          // ),
          // 评论标题
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: <Widget>[
                  Icon(
                    VFIcons.ic_comment,
                    color: Theme.of(context).accentColor.withAlpha(128),
                    size: VFDimens.d_24,
                  ),
                  Text(
                    FlutterI18n.translate(context, 'comment'),
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: VFSizes.s_16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // 评论数据
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
  // 下拉范围��离
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
