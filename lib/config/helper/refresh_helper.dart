import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';


import 'package:vf_library/ui/mine/mine_loft.dart';

/// 首页列表的header
//class HomeRefreshHeader extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    var strings = RefreshLocalizations.of(context)?.currentLocalization ??
//        EnRefreshString();
//    return ClassicHeader(
//      canTwoLevelText: FlutterI18n.translate(context, "welcome_to_loft"),
//      textStyle: TextStyle(color: Colors.white),
//      outerBuilder: (child) => MineLoftOuter(child),
//      twoLevelView: Container(),
//      height: 70 + MediaQuery.of(context).padding.top / 3,
////      refreshingIcon: ActivityIndicator(brightness: Brightness.dark),
//      releaseText: strings.canRefreshText,
//    );
//  }
//}
//
///// 通用的footer
/////
///// 由于国际化需要context的原因,所以无法在[RefreshConfiguration]配置
//class RefresherFooter extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return ClassicFooter(
////      failedText: FlutterI18n.translate(context, "loadMoreFailed,
////      idleText: FlutterI18n.translate(context, "loadMoreIdle,
////      loadingText: FlutterI18n.translate(context, "loadMoreLoading,
////      noDataText: FlutterI18n.translate(context, "loadMoreNoData,
//        );
//  }
//}
