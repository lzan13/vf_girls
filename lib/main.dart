import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

import 'package:vf_girls/app/app.dart';
import 'package:vf_girls/common/index.dart';

void main() async {
  await StorageManager.init();
  runApp(StartApp());
  // Android 状态栏透明 splash 为白色,所以调整状态栏文字为黑色
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
  //   statusBarColor: VFColors.transparent,
  // ));
  FirebaseAdMob.instance
      .initialize(appId: 'ca-app-pub-3940256099942544~3347511713');
}

class StartApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 引入 OKToast，需要在最外城添加
    return OKToast(
      dismissOtherOnShow: true,
      child: Store.init(context),
    );
  }
}
