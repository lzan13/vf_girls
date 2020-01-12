import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import 'package:vf_plugin/vf_plugin.dart';

import 'package:vf_girls/common/index.dart';
import 'package:vf_girls/ui/main/explore/explore.dart';
import 'package:vf_girls/ui/main/home/home.dart';
import 'package:vf_girls/ui/main/mine/mine.dart';
import 'package:vf_girls/ui/widget/toast.dart';

List<Widget> pages = <Widget>[HomePage(), ExplorePage(), MinePage()];

///
/// 项目 Tab 界面
///
class AppTab extends StatefulWidget {
  AppTab({Key key}) : super(key: key);

  @override
  AppTabState createState() => AppTabState();
}

class AppTabState extends State<AppTab> with SingleTickerProviderStateMixin {
  // 页面控制
  // TabController tabController;
  PageController pageController = PageController();
  int currentIndex = 0;

  // 上次点击时间
  DateTime lastTapAt;

  // 初始化
  @override
  void initState() {
    super.initState();
    // tabController = TabController(length: 3, vsync: this);
    // tabController.addListener(() {
    //   setState(() {});
    // });
  }

  ///
  /// 底部栏切换
  ///
  // void onBottomNavigationBarTap(int index) {
  //   setState(() {
  //     currentIndex = index;
  //     // tabController.index = index;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          if (lastTapAt == null ||
              DateTime.now().difference(lastTapAt) > Duration(seconds: 1)) {
            // 两次点击间隔超过阀值则重新计时
            lastTapAt = DateTime.now();
            VFToast.show(FlutterI18n.translate(context, "back_again"));
            return false;
          }
          return true;
        },
        // child: TabBarView(
        //   controller: tabController,
        //   children: pages,
        // ),
        child: PageView.builder(
          itemBuilder: (ctx, index) => pages[index],
          itemCount: pages.length,
          controller: pageController,
          physics: NeverScrollableScrollPhysics(),
          onPageChanged: (index) {
            setState(() {
              currentIndex = index;
            });
          },
        ),
      ),
      // 底部 tab 布局
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          pageController.jumpToPage(index);
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                VFIcons.ic_home,
                size: VFDimens.d_30,
              ),
              title: Text(
                FlutterI18n.translate(context, 'tab_home'),
                style: TextStyle(fontSize: VFSizes.tab_small),
              )),
          BottomNavigationBarItem(
              icon: Icon(
                VFIcons.ic_explore,
                size: VFDimens.d_30,
              ),
              title: Text(
                FlutterI18n.translate(context, 'tab_explore'),
                style: TextStyle(fontSize: VFSizes.tab_small),
              )),
          BottomNavigationBarItem(
              icon: Icon(
                VFIcons.ic_mine,
                size: VFDimens.d_30,
              ),
              title: Text(
                FlutterI18n.translate(context, 'tab_mine'),
                style: TextStyle(fontSize: VFSizes.tab_small),
              )),
        ],
      ),
    );
  }
}
