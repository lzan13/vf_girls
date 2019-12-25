import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import 'package:vf_plugin/vf_plugin.dart';

import 'package:vf_library/common/index.dart';
import 'package:vf_library/router/router_manger.dart';

///
/// 我的 Tab 页面
///
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
        SliverList(
          delegate: SliverChildListDelegate([
            Center(
              child: Column(
                children: <Widget>[
//                  Image.asset(
//                    ResHelper.wrapImage("default_avatar.png"),
//                    width: 72.0,
//                    height: 72.0,
//                  ),
                  Icon(
                    Icons.account_circle,
                    size: VFDimens.d_96,
                    color: VFColors.grey54,
                  ),
                  Text("昵称")
                ],
              ),
            ),
            // 个人信息
            VFListItem(
              title: FlutterI18n.translate(context, 'info'),
//              describe: FlutterI18n.translate(context, 'settings'),
              onPressed: () {
                Router.toUser(context);
              },
              leftIcon: VFIcons.mine,
              leftIconColor: VFColors.green,
            ), // 设置
            VFListItem(
              title: FlutterI18n.translate(context, "settings"),
//              describe: FlutterI18n.translate(context, 'settings'),
              onPressed: () {
                Router.toSettings(context);
              },
              // leftIcon: VFIcons.settings,
              leftWidget: CircleIcon(
                bgColor: Colors.green,
                color: Colors.red,
                icon: VFIcons.call,
              ),
              rightIcon: VFIcons.arrowRight,
            ),
            // 设置
            VFListItem(
              title: FlutterI18n.translate(context, "settings"),
//              describe: FlutterI18n.translate(context, 'settings'),
              onPressed: () {
                Router.toSettings(context);
              },
              leftIcon: VFIcons.settings,
              rightIcon: VFIcons.arrowRight,
            ),
          ]),
        ),
      ]),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
