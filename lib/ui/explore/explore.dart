import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import 'package:vf_library/ui/widget/circular_icon.dart';
import 'package:vf_library/ui/widget/list_item.dart';


class Explore extends StatefulWidget {
  @override
  ExploreState createState() => ExploreState();
}


class ExploreState extends State<Explore>
    with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: EasyRefresh.custom(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 100.0,
            pinned: true,
            backgroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              title: Text(FlutterI18n.translate(context, 'sample')),
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
              // 个人中心
              ListItem(
                title: FlutterI18n.translate(context, 'userProfile'),
                describe: FlutterI18n.translate(context, 'userProfileDescribe'),
                onPressed: () {
//                  Navigator.push(context,
//                      MaterialPageRoute(builder: (BuildContext context) {
//                        return UserProfilePage();
//                      },));
                },
                icon: CircularIcon(
                  bgColor: Colors.red,
                  icon: Icons.person,
                ),
              ),
              //  NestedScrollView
              ListItem(
                title: 'NestedScrollView',
                describe: FlutterI18n.translate(context, 'nestedScrollViewDescribe'),
                onPressed: () {
//                  Navigator.push(context,
//                      MaterialPageRoute(builder: (BuildContext context) {
//                        return NestedScrollViewPage();
//                      },));
                },
                icon: CircularIcon(
                  bgColor: Colors.green,
                  icon: Icons.line_style,
                ),
              ),
              //  Swiper
              ListItem(
                title: 'Swiper',
                describe: FlutterI18n.translate(context, 'swiperDescribe'),
                onPressed: () {
//                  Navigator.push(context,
//                      MaterialPageRoute(builder: (BuildContext context) {
//                        return SwiperPage();
//                      },));
                },
                icon: CircularIcon(
                  bgColor: Colors.deepOrangeAccent,
                  icon: Icons.view_array,
                ),
              ),
              //  首次刷新
              ListItem(
                title: FlutterI18n.translate(context, 'firstRefresh'),
                describe: FlutterI18n.translate(
                    context, 'firstRefreshDescribe'),
                onPressed: () {
//                  Navigator.push(context,
//                      MaterialPageRoute(builder: (BuildContext context) {
//                        return FirstRefreshPage();
//                      },));
                },
                icon: CircularIcon(
                  bgColor: Colors.blueGrey,
                  icon: Icons.refresh,
                ),
              ),
              //  空视图
              ListItem(
                title: FlutterI18n.translate(context, 'emptyWidget'),
                describe: FlutterI18n.translate(
                    context, 'emptyWidgetDescribe'),
                onPressed: () {
//                  Navigator.push(context,
//                      MaterialPageRoute(builder: (BuildContext context) {
//                        return EmptyPage();
//                      },));
                },
                icon: CircularIcon(
                  bgColor: Colors.grey,
                  icon: Icons.inbox,
                ),
              ),
              //  CustomHeader
              ListItem(
                title: FlutterI18n.translate(context, 'linkHeader'),
                describe: FlutterI18n.translate(
                    context, 'linkHeaderDescribeDescribe'),
                onPressed: () {
//                  Navigator.push(context,
//                      MaterialPageRoute(builder: (BuildContext context) {
//                        return LinkHeaderPage();
//                      },));
                },
                icon: CircularIcon(
                  bgColor: Colors.amber[700],
                  icon: Icons.format_line_spacing,
                ),
              ),
              //  二楼
              ListItem(
                title: FlutterI18n.translate(context, 'secondFloor'),
                describe: FlutterI18n.translate(
                    context, 'secondFloorDescribe'),
                onPressed: () {
//                  Navigator.push(context,
//                      MaterialPageRoute(builder: (BuildContext context) {
//                        return SecondFloorPage();
//                      },));
                },
                icon: CircularIcon(
                  bgColor: Colors.purple,
                  icon: Icons.view_agenda,
                ),
              ),
              //  聊天页面
              ListItem(
                title: FlutterI18n.translate(context, 'chatPage'),
                describe: FlutterI18n.translate(
                    context, 'chatPageDescribe'),
                onPressed: () {
//                  Navigator.push(context,
//                      MaterialPageRoute(builder: (BuildContext context) {
//                        return ChatPage();
//                      },));
                },
                icon: CircularIcon(
                  bgColor: Colors.blueAccent,
                  icon: Icons.chat,
                ),
              ),
              //  测试页面
              kDebugMode ? ListItem(
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
              ): SizedBox(),
            ]),
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
