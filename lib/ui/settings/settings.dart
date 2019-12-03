import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:vf_library/common/vf_dimens.dart';
import 'package:vf_library/config/resource_manager.dart';
import 'package:vf_library/router/router_manger.dart';

import 'package:vf_library/common/vf_colors.dart';
import 'package:vf_library/ui/widget/vf_top_bar.dart';
import 'package:vf_library/ui/widget/list_item.dart';

/**
 * 设置页面
 */
class SettingsPage extends StatefulWidget {
  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        title: Text(FlutterI18n.translate(context, "settings")),
//      ),
      body: Container(
        child: Column(children: <Widget>[
          VFTopBar(
            top: MediaQuery.of(context).padding.top,
            title: FlutterI18n.translate(context, "settings"),
            titleColor: VFColors.white,
          ),
//          EasyRefresh(
//            child: ListView(children: <Widget>[
//              // 个人信息
//              ListItem(
//                title: FlutterI18n.translate(context, 'info'),
////              describe: FlutterI18n.translate(context, 'settings'),
//                onPressed: () {
//                  Router.toUser(context);
//                },
//                icon: Icons.info,
//                iconColor: VFColors.green,
//              ),
//            ]),
//          ),
        ]),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
