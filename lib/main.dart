import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

import 'generated/i18n.dart';
import 'ui/home/home.dart';

void main() => runApp(StartApp());

class StartApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 引入 OKToast，需要在最外城添加
    return OKToast(
      dismissOtherOnShow: true,
      // 使用 Provider 需要在外层包括
      child: MaterialApp(
        // 国际化配置
//        locale: ,
        localizationsDelegates: const [
          S.delegate,
//          RefreshLocalizations.delegate, //下拉刷新
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: S.delegate.supportedLocales,
        // 显示页面内容
        home: Home(),
      ),
    );
  }
}
