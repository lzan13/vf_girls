import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:vf_library/router/router_manger.dart';

import 'package:vf_library/ui/widget/circular_icon.dart';
import 'package:vf_library/ui/widget/list_item.dart';

/**
 * 我的 Tab 页面
 */
class MinePage extends StatefulWidget {
  @override
  MinePageState createState() => MinePageState();
}

class MinePageState extends State<MinePage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: EasyRefresh.custom(slivers: <Widget>[
        SliverAppBar(
          floating: true,
          snap: true,
          pinned: true,
          expandedHeight: 220.0,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(FlutterI18n.translate(context, 'tab_mine')),
            centerTitle: true,
            background: Image.network(
              'http://img1.mukewang.com/5c18cf540001ac8206000338.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            // 个人信息
            ListItem(
              title: FlutterI18n.translate(context, 'info'),
//              describe: FlutterI18n.translate(context, 'settings'),
              onPressed: () {
                Router.toUser(context);
              },
              icon: CircularIcon(
                bgColor: Colors.green,
                icon: Icons.info,
              ),
            ),
            // 设置
            ListItem(
              title: FlutterI18n.translate(context, 'settings'),
//              describe: FlutterI18n.translate(context, 'settings'),
              onPressed: () {},
              icon: CircularIcon(
                bgColor: Colors.grey,
                icon: Icons.settings,
              ),
            ),
          ]),
        ),
      ]),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
