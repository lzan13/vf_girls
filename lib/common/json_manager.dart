import 'dart:convert';

import 'package:vf_girls/request/bean/category_bean.dart';

///
/// Json 操作帮助类
///
class JSONHelper {
  ///
  /// 获取首页 tab 数据
  ///
  static List<CategoryBean> getHomeTabs() {
    String tabStr =
        '[{"title":"最新","url":"https://www.mzitu.com/"},{"title":"最热","url":"https://www.mzitu.com/hot/"},{"title":"推荐","url":"https://www.mzitu.com/best/"}]';
    List jsonList = json.decode(tabStr);
    List<CategoryBean> tabList = [];
    jsonList.forEach((tab) {
      tabList.add(CategoryBean.fromJson(tab));
    });
    return tabList;
  }
}
