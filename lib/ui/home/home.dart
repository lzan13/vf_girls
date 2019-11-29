import 'package:flutter/material.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:vf_library/config/helper/refresh_helper.dart';
import 'package:vf_library/router/router_manger.dart';
import 'home_body.dart';

class Home extends StatelessWidget {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MediaQuery.removePadding(
          context: context,
          removeTop: false,
          child: Builder(builder: (_) {
            return RefreshConfiguration.copyAncestor(
              context: context,
              // 下拉触发二楼距离
              twiceTriggerDistance: 165,
              //最大下拉距离,android默认为0,这里为了触发二楼
              maxOverScrollExtent: 180,
              headerTriggerDistance:
                  80 + MediaQuery.of(context).padding.top / 3,
              child: SmartRefresher(
                controller: refreshController,
                header: HomeRefreshHeader(),
                enableTwoLevel: true,
                onTwoLevel: () async {
                  await Navigator.of(context).pushNamed(RouteName.mineLoft);
                  await Future.delayed(Duration(milliseconds: 300));
                  refreshController.twoLevelComplete();
                },
                footer: RefresherFooter(),
                enablePullDown: true,
                onRefresh: () async {
//                    await homeModel.refresh();
//                    homeModel.showErrorMessage(context);
                },
                child: HomeBody(),
              ),
            );
          })),
      floatingActionButton: FloatingActionButton(
        heroTag: 'homeFab',
        key: ValueKey(Icons.search),
        onPressed: () {
        },
        child: Icon(
          Icons.search,
        ),
      ),
    );
  }
}

/**
 * 自定义渐变的标题栏
 */
class GradientAppBar extends StatelessWidget {
  final String title;
  final double barHeight = 56.0;

  GradientAppBar(this.title);

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return new Container(
      padding: EdgeInsets.only(top: statusBarHeight),
      height: statusBarHeight + barHeight,
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 20.0),
        ),
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [const Color(0xFF3366FF), const Color(0xFF00CCFF)],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
    );
  }
}
