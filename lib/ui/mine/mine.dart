import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:vf_library/common/vf_dimens.dart';
import 'package:vf_library/config/resource_manager.dart';
import 'package:vf_library/router/router_manger.dart';

import 'package:vf_library/common/vf_colors.dart';
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
                  Text("")
                ],
              ),
            ),
            // 个人信息
            ListItem(
              title: FlutterI18n.translate(context, 'info'),
//              describe: FlutterI18n.translate(context, 'settings'),
              onPressed: () {
                Router.toUser(context);
              },
              icon: VFIcons.mine,
              iconColor: VFColors.green,
            ),
            // 设置
            ListItem(
              title: FlutterI18n.translate(context, "settings"),
//              describe: FlutterI18n.translate(context, 'settings'),
              onPressed: () {
                Router.toSettings(context);
              },
              icon: VFIcons.settings,
            ),
          ]),
        ),
      ]),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
