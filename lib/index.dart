import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';

import 'package:vf_library/config/provider_manager.dart';
import 'package:vf_library/router/router_manger.dart';
import 'package:vf_library/view_model/locale_model.dart';
import 'package:vf_library/view_model/theme_model.dart';

class Store {
  /// 全局的上下文对象
  static BuildContext appContext;

  //  我们将会在main.dart中runAPP实例化init
  static init(BuildContext context) {
    appContext = context;
    // 使用 Provider 需要在外层包括
    return MultiProvider(
      providers: providers,
      child: Consumer2<ThemeModel, LocaleModel>(
          builder: (context, themeModel, localModel, child) {

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          // 主题
          theme: themeModel.themeData(),
          darkTheme: themeModel.themeData(platformDarkMode: true),
          // 国际化配置
          locale: localModel.locale,
          localizationsDelegates: [
            FlutterI18nDelegate(
                useCountryCode: true, fallbackFile: 'en', path: 'assets/langs'),
            GlobalCupertinoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate
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
