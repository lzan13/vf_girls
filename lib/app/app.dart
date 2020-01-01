import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';

import 'package:vf_girls/common/index.dart';
import 'package:vf_girls/router/router_manger.dart';
import 'package:vf_girls/view_model/theme_model.dart';

class Store {
  /// 全局的上下文对象
  static BuildContext appContext;

  //  我们将会在main.dart中runAPP实例化init
  static init(BuildContext context) {
    appContext = context;

    SchedulerBinding.instance.addPostFrameCallback((Duration timestamp) {
      // 设置 EasyRefresh 的默认样式
      EasyRefresh.defaultHeader = ClassicalHeader(
        enableInfiniteRefresh: false,
        refreshText: FlutterI18n.translate(context, 'refresh_to_pull'),
        refreshReadyText: FlutterI18n.translate(context, 'refresh_release'),
        refreshingText: FlutterI18n.translate(context, 'refreshing'),
        refreshedText: FlutterI18n.translate(context, 'refresh_finish'),
        infoText: FlutterI18n.translate(context, 'refresh_update_at'),
        refreshFailedText: FlutterI18n.translate(context, 'refresh_failed'),
        noMoreText: FlutterI18n.translate(context, 'load_no_more'),
        enableHapticFeedback: false,
      );
      EasyRefresh.defaultFooter = ClassicalFooter(
        enableInfiniteLoad: true,
        loadText: FlutterI18n.translate(context, 'load_to_push'),
        loadReadyText: FlutterI18n.translate(context, 'load_release'),
        loadingText: FlutterI18n.translate(context, 'loading'),
        loadedText: FlutterI18n.translate(context, 'load_finish'),
        loadFailedText: FlutterI18n.translate(context, 'load_failed'),
        noMoreText: FlutterI18n.translate(context, 'load_no_more'),
        infoText: FlutterI18n.translate(context, 'load_update_at'),
        enableHapticFeedback: false,
      );
    });
    // 使用 Provider 需要在外层包括
    return MultiProvider(
      providers: providers,
      child: Consumer<ThemeModel>(builder: (context, themeModel, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          // 主题
          theme: themeModel.themeData(),
          darkTheme: themeModel.themeData(platformDarkMode: true),
          // 国际化配置
          locale: themeModel.locale,
          localizationsDelegates: [
            FlutterI18nDelegate(
                useCountryCode: true, fallbackFile: 'en', path: 'assets/langs'),
            GlobalCupertinoLocalizations.delegate,
            GlobalEasyRefreshLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate
          ],
          supportedLocales: [
            Locale('en', ''),
            Locale('zh', 'CN'),
          ],
          localeResolutionCallback: (local, supportedLocales) {
            return local;
          },
          // 页面路由
          onGenerateRoute: Router.generateRoute,
          initialRoute: RouteName.splash,
        );
      }),
    );
  }

  //  通过Provider.value<T>(context)获取状态数据
  static T value<T>(context) {
    return Provider.of(context);
  }

  //  通过Consumer获取状态数据
  static Consumer connect<T>({builder, child}) {
    return Consumer<T>(builder: builder, child: child);
  }
}
