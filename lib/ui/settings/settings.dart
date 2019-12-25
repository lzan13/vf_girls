import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import 'package:vf_plugin/vf_plugin.dart';

///
/// 设置页面
///
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
}
