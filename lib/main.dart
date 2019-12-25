import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

import 'package:vf_library/index.dart';
import 'package:vf_library/common/index.dart';

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
      child: Store.init(context),
    );
  }
}
