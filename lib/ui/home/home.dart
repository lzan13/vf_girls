import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import 'package:vf_library/common/toast.dart';
import 'package:vf_library/router/router_manger.dart';
import 'package:vf_library/ui/widget/circular_icon.dart';
import 'package:vf_library/ui/widget/list_item.dart';

/**
 * 首页 Tab 页面
 */
class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
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
            background: Image.network(
              'http://img1.mukewang.com/5c18cf540001ac8206000338.jpg',
              fit: BoxFit.cover,
            ),
//            centerTitle: false,
            title: Text(FlutterI18n.translate(context, 'tab_home')),
//            titlePadding: const EdgeInsets.all(24.0),
//            collapseMode: CollapseMode.parallax, // 默认模式
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            // 普通 Toast
            ListItem(
              title: FlutterI18n.translate(context, 'Normal Toast'),
              describe: FlutterI18n.translate(context, 'show a normal toast'),
              onPressed: () {
                FToast.show("普通 Toast");
              },
              icon: CircularIcon(
                bgColor: Colors.grey,
                icon: Icons.hd,
              ),
            ),
            // 错误 Toast
            ListItem(
              title: FlutterI18n.translate(context, 'Normal Toast'),
              describe: FlutterI18n.translate(context, 'show a normal toast'),
              onPressed: () {
                FToast.error("错误 Toast，同时输出错误相关信息，可能会超过一行，自动换行");
              },
              icon: CircularIcon(bgColor: Colors.redAccent, icon: Icons.error),
            ),
            // 完成 Toast
            ListItem(
              title: FlutterI18n.translate(context, 'Normal Toast'),
              describe: FlutterI18n.translate(context, 'show a normal toast'),
              onPressed: () {
                FToast.success("完成 Toast");
              },
              icon: CircularIcon(bgColor: Colors.green, icon: Icons.done),
            ),
            // 基本使用
            ListItem(
              title: FlutterI18n.translate(context, 'basicUse'),
              describe: FlutterI18n.translate(context, 'basicUseDescribe'),
              onPressed: () {
                Router.toEmpty(context);
              },
              icon: CircularIcon(
                bgColor: Theme
                    .of(context)
                    .primaryColor,
                icon: Icons.format_list_bulleted,
              ),
            ),
            //  测试页面
            kDebugMode
                ? ListItem(
              title: 'Test',
              describe: 'EasyRefresh test page',
              onPressed: () {
//                  Navigator.push(context,
//                      MaterialPageRoute(builder: (BuildContext context) {
//                        return TestPage();
//                      },));
              },
              icon: CircularIcon(
                bgColor: Colors.black,
                icon: Icons.build,
              ),
            )
                : SizedBox(),
          ]),
        ),
      ]),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
