import 'dart:convert';

import 'package:vf_girls/request/bean/tab_bean.dart';

///
/// Json 操作帮助类
///
class JSONHelper {
  ///
  /// 获取首页 tab 数据
  ///
  static List<TabBean> getHomeTabs() {
    String tabStr =
        '[{"title":"最新","url":"https://www.mzitu.com/"},{"title":"最热","url":"https://www.mzitu.com/hot/"},{"title":"推荐","url":"https://www.mzitu.com/best/"}]';
    List jsonList = json.decode(tabStr);
    List<TabBean> tabList = [];
    jsonList.forEach((tab) {
      tabList.add(TabBean.fromJson(tab));
    });
    return tabList;
  }
}
