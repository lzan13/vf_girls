import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:vf_library/router/route_anim.dart';

import 'package:vf_library/ui/splash.dart';
import 'package:vf_library/ui/app_tab.dart';
import 'package:vf_library/ui/mine/mine_loft.dart';

/*
 * 路由名
 */
class RouteName {
  // 闪屏
  static const String splash = 'splash';

  // 导航页
  static const String appTab = 'appTab';

  // 阁楼
  static const String mineLoft = 'mineLoft';

  // 设置
  static const String settings = 'settings';

  // 登录注册
  static const String signIn = 'signIn';
  static const String signUp = 'signUp';

  static const String articleDetail = 'articleDetail';
  static const String structureList = 'structureList';
  static const String favouriteList = 'favouriteList';
  static const String coinRecordList = 'coinRecordList';
  static const String coinRankingList = 'coinRankingList';
}

/*
 * 路由
 */
class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.splash:
        return NoAnimRouteBuilder(Splash());
      case RouteName.appTab:
        return NoAnimRouteBuilder(AppTab());
      case RouteName.mineLoft:
        return SlideTopRouteBuilder(MineLoft());
//      case RouteName.login:
//        return CupertinoPageRoute(
//            fullscreenDialog: true, builder: (_) => LoginPage());
//      case RouteName.register:
//        return CupertinoPageRoute(builder: (_) => RegisterPage());
//      case RouteName.articleDetail:
//        var article = settings.arguments as Article;
//        return CupertinoPageRoute(builder: (_) {
//          // 根据配置调用页面
//          return StorageManager.sharedPreferences.getBool(kUseWebViewPlugin) ??
//                  false
//              ? ArticleDetailPluginPage(
//                  article: article,
//                )
//              : ArticleDetailPage(
//                  article: article,
//                );
//        });
//      case RouteName.structureList:
//        var list = settings.arguments as List;
//        Tree tree = list[0] as Tree;
//        int index = list[1];
//        return CupertinoPageRoute(
//            builder: (_) => ArticleCategoryTabPage(tree, index));
//      case RouteName.favouriteList:
//        return CupertinoPageRoute(builder: (_) => FavouriteListPage());
//      case RouteName.setting:
//        return CupertinoPageRoute(builder: (_) => SettingPage());
//      case RouteName.coinRecordList:
//        return CupertinoPageRoute(builder: (_) => CoinRecordListPage());
//      case RouteName.coinRankingList:
//        return CupertinoPageRoute(builder: (_) => CoinRankingListPage());
      default:
        return CupertinoPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}

/// Pop路由
class PopRoute extends PopupRoute {
  final Duration _duration = Duration(milliseconds: 300);
  Widget child;

  PopRoute({@required this.child});

  @override
  Color get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return child;
  }

  @override
  Duration get transitionDuration => _duration;
}
