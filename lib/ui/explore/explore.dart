import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import 'package:vf_library/ui/widget/circular_icon.dart';
import 'package:vf_library/ui/widget/list_item.dart';

/**
 * 发现探索 Tab 页面
 */
class ExplorePage extends StatefulWidget {
  @override
  ExplorePageState createState() => ExplorePageState();
}

class ExplorePageState extends State<ExplorePage>
    with AutomaticKeepAliveClientMixin {
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
            title: Text(FlutterI18n.translate(context, 'tab_home')),
            centerTitle: true,
            background: Image.network(
              'http://img1.mukewang.com/5c18cf540001ac8206000338.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            // 基本使用
            ListItem(
              title: FlutterI18n.translate(context, 'basicUse'),
              describe: FlutterI18n.translate(context, 'basicUseDescribe'),
              onPressed: () {
//                  Navigator.push(context,
//                      MaterialPageRoute(builder: (BuildContext context) {
//                        return BasicPage(
//                            FlutterI18n.translate(context, 'basicUse'));
//                      },));
              },
              icon: CircularIcon(
                bgColor: Theme.of(context).primaryColor,
                icon: Icons.format_list_bulleted,
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
