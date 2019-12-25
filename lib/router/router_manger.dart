import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import 'package:vf_library/router/route_anim.dart';
import 'package:vf_library/ui/settings/settings.dart';

import 'package:vf_library/ui/splash.dart';
import 'package:vf_library/ui/app_tab.dart';
import 'package:vf_library/ui/mine/mine_loft.dart';
import 'package:vf_library/ui/user/user.dart';
import 'package:vf_library/ui/widget/not_fount.dart';

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

  // 用户信息
  static const String user = 'user';

  static const String notFound = 'notFound';

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
      case RouteName.settings:
        return CupertinoPageRoute(builder: (_) => SettingsPage());
      case RouteName.user:
        return CupertinoPageRoute(builder: (_) => UserPage());
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
        return CupertinoPageRoute(builder: (_) => NotFoundPage(settings.name));
//        Scaffold(
//          body: Center(
//            child: Text(FlutterI18n.translate(context, "hide_not_fount_page")+' ${settings.name}'),
//          ),
//        )
    }
  }

  /// APP 入口 Tab
  static void toAppTab(context) {
    Navigator.of(context).pushReplacementNamed(RouteName.appTab);
  }

  /// 阁楼
  static void toMineLoft(context) {
    Navigator.of(context).pushReplacementNamed(RouteName.mineLoft);
  }

  /// 设置页面
  static void toSettings(context) {
    Navigator.pushNamed(context, RouteName.settings);
  }

  /// 个人中心
  static void toUser(context) {
    Navigator.pushNamed(context, RouteName.user);
  }

  /// TODO 测试找不到的页面跳转
  static void toNotFound(context) {
    Navigator.pushNamed(context, RouteName.notFound);
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
