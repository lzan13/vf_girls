import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:vf_library/view_model/locale_model.dart';

import 'config/provider_manager.dart';
import 'config/storage_manager.dart';
import 'generated/i18n.dart';
import 'router/router_manger.dart';
import 'ui/home/home.dart';
import 'view_model/theme_model.dart';

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
          return RefreshConfiguration(
            // 列表数据不满一页,不触发加载更多
            hideFooterWhenNotFull: true,
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              // 主题
              theme: themeModel.themeData(),
              darkTheme: themeModel.themeData(platformDarkMode: true),
              // 国际化配置
              locale: localModel.locale,
              localizationsDelegates: const [
                S.delegate,
                RefreshLocalizations.delegate, //下拉刷新
                GlobalCupertinoLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate
              ],
              supportedLocales: S.delegate.supportedLocales,
              // 页面路由
              onGenerateRoute: Router.generateRoute,
              initialRoute: RouteName.splash,
            ),
          );
        }),
      ),
    );
  }
}
