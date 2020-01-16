import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:vf_girls/request/bean/category_bean.dart';
import 'package:vf_girls/request/bean/girl_bean.dart';
import 'package:vf_girls/router/route_anim.dart';
import 'package:vf_girls/ui/category/category.dart';
import 'package:vf_girls/ui/detail/detail.dart';
import 'package:vf_girls/ui/display/display_multi.dart';
import 'package:vf_girls/ui/main/app_tab.dart';
import 'package:vf_girls/ui/main/mine/mine_loft.dart';
import 'package:vf_girls/ui/settings/feedback.dart';
import 'package:vf_girls/ui/settings/settings.dart';
import 'package:vf_girls/ui/splash/splash.dart';
import 'package:vf_girls/ui/user/user.dart';
import 'package:vf_girls/ui/widget/not_fount.dart';
import 'package:vf_girls/ui/test_page.dart';

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
  // 问题反馈
  static const String feedback = 'feedback';

  // 登录注册
  static const String signIn = 'signIn';
  static const String signUp = 'signUp';

  // 用户信息
  static const String user = 'user';

  //  分类
  static const String category = 'category';

  // 详情
  static const String detail = 'detail';

  // 预览多图
  static const String displayMulti = 'displayMulti';

  // 错误页面
  static const String notFound = 'notFound';

  // 测试页面
  static const String test = 'test';
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
      case RouteName.feedback:
        return CupertinoPageRoute(builder: (_) => FeedbackPage());
      case RouteName.settings:
        return CupertinoPageRoute(builder: (_) => SettingsPage());
      case RouteName.user:
        return CupertinoPageRoute(builder: (_) => UserPage());
      case RouteName.category:
        CategoryBean bean = settings.arguments;
        return CupertinoPageRoute(builder: (_) => CategoryPage(bean));
      case RouteName.detail:
        GirlBean bean = settings.arguments;
        return CupertinoPageRoute(builder: (_) => DetailPage(bean));
      case RouteName.displayMulti:
        return CupertinoPageRoute(
            builder: (_) => DisplayMultiPage(settings.arguments));
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

      case RouteName.test:
        return CupertinoPageRoute(builder: (_) => TestPage());
      default:
        return CupertinoPageRoute(builder: (_) => NotFoundPage(settings.name));
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

  /// 问题反馈
  static void toFeedback(context) {
    Navigator.pushNamed(context, RouteName.feedback);
  }

  /// 设置页面
  static void toSettings(context) {
    Navigator.pushNamed(context, RouteName.settings);
  }

  /// 个人中心
  static void toUser(context) {
    Navigator.pushNamed(context, RouteName.user);
  }

  /// 分类
  static void toCategory(context, bean) {
    if (bean != null) {
      Navigator.pushNamed(
        context,
        RouteName.category,
        arguments: bean,
      );
    } else {
      toNotFound(context);
    }
  }

  /// 详情
  static void toDetail(context, bean) {
    if (bean != null) {
      Navigator.pushNamed(
        context,
        RouteName.detail,
        arguments: bean,
      );
    } else {
      toNotFound(context);
    }
  }

  /// 预览
  static void toDisplayMulti(context, list, index) {
    Navigator.pushNamed(
      context,
      RouteName.displayMulti,
      arguments: {
        'data': list,
        'index': index,
      },
    );
  }

  /// 测试找不到的页面跳转
  static void toNotFound(context) {
    Navigator.pushNamed(context, RouteName.notFound);
  }

  /// 测试页面
  static void toTest(context) {
    Navigator.pushNamed(context, RouteName.test);
  }

  /// 测试页面
  static void toSplash(context) {
    Navigator.pushNamed(context, RouteName.splash);
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
