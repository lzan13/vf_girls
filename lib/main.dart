import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

import 'package:vf_library/config/provider_manager.dart';
import 'package:vf_library/config/storage_manager.dart';
import 'package:vf_library/router/router_manger.dart';
import 'package:vf_library/view_model/locale_model.dart';
import 'package:vf_library/view_model/theme_model.dart';

void main() async {
  await StorageManager.init();
  runApp(StartApp());
}

class StartApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 引入 OKToast，需要在最外城添加
    return OKToast(
      dismissOtherOnShow: true,
      // 使用 Provider 需要在外层包括
      child: MultiProvider(
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
                  useCountryCode: true,
                  fallbackFile: 'en',
                  path: 'assets/langs'),
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
      ),
    );
  }
}
