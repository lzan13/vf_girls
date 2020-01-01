import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:vf_girls/request/girls_manager.dart';
import 'package:vf_girls/ui/widget/empty.dart';
import 'package:vf_girls/ui/widget/loading.dart';

import 'package:vf_plugin/vf_plugin.dart';

import 'package:vf_girls/router/router_manger.dart';
import 'package:vf_girls/ui/widget/toast.dart';

///
/// 发现探索 Tab 页面
///
class DetailPage extends StatefulWidget {
  String url;

  DetailPage(this.url);

  @override
  DetailPageState createState() => DetailPageState();
}

class DetailPageState extends State<DetailPage> {
  // 刷新控制类，必须有，否则列表无法滚动
  EasyRefreshController _controller = EasyRefreshController();
  // 加载数据
  dynamic girlList = [];

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
    dynamic result = await GirlsManager.loadDetail(widget.url);
    print(result);
    // setState(() {
    //   girlList.clear();
    //   girlList.addAll(result);
    // });
    // // 数据加载结束，重置刷新加载状态
    // // if (isRefresh) {
    // _controller.finishRefresh(success: true);
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
      body: EasyRefresh(
        // controller: _controller,
        emptyWidget: this.girlList.length == 0 ? EmptyPage() : null,
        firstRefresh: true,
        firstRefreshWidget: Loading(),
        onRefresh: () async {
          loadData();
        },
        onLoad: () async {
          // loadData();
        },
        child: ListView(),
      ),
    );
  }
}
