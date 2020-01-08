import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import 'package:vf_plugin/vf_plugin.dart';

import 'package:vf_girls/common/resource_manager.dart';
import 'package:vf_girls/request/bean/girl.dart';
import 'package:vf_girls/request/girls_manager.dart';
import 'package:vf_girls/ui/widget/empty.dart';
import 'package:vf_girls/ui/widget/loading.dart';

import 'package:vf_girls/router/router_manger.dart';

///
/// 发现探索 Tab 页面
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
  List<GirlEntity> dataList = [];

  ///
  /// 初始化
  ///
  @override
  void initState() {
    super.initState();
  }

  ///
  /// 加载数据
  ///
  void loadData() async {
    dynamic result = await GirlsManager.loadDetail(widget.mEntity.jumpUrl);
    setState(() {
      dataList.clear();
      dataList.addAll(result);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VFTopBar(
        top: MediaQuery.of(context).padding.top,
        title: widget.mEntity.title,
        titleColor: VFColors.white,
        leftIcon: VFIcons.ic_arrow_left,
      ),
      body: EasyRefresh(
        // controller: _controller,
        emptyWidget: this.dataList.length == 0 ? EmptyPage() : null,
        firstRefresh: true,
        firstRefreshWidget: Loading(),
        onRefresh: () async {
          loadData();
        },
        onLoad: () async {
          // loadData();
        },
        child: ListView.builder(
            itemCount: this.dataList.length > 0 ? this.dataList.length : 0,
            itemBuilder: (BuildContext context, int index) {
              GirlEntity entity = dataList[index];
              return GestureDetector(
                onTap: () => Router.toDisplayMulti(context, dataList, index),
                child: CachedNetworkImage(
                  imageUrl: entity != null && entity.imgUrl != null
                      ? entity.imgUrl
                      : '',
                  placeholder: (context, url) => Padding(
                    padding: EdgeInsets.all(VFDimens.d_36),
                    child: VFProgress(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              );
            }),
      ),
    );
  }
}
