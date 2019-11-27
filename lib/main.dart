import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

import 'ui/home/home.dart';

void main() => runApp(StartApp());

class StartApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return MaterialApp(title: "首页", home: new HomePage());
    return OKToast(
      dismissOtherOnShow: true,
      child: MaterialApp(
        //内容脚手架 显示标题 内容 drawLayout 底部导航
        home: Home(),
      ),
    );
  }
}
