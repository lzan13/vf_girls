import 'dart:convert';

import 'package:vf_girls/request/bean/category_bean.dart';

///
/// Json 操作帮助类
///
class JSONHelper {
  ///
  /// 获取首页 tab 数据 最新和性感一样，所以去掉了第一个
  /// [{
  ///     "title": "最新",
  ///     "url": "https://www.mzitu.com/"
  /// },
  /// {
  ///     "title": "最热",
  ///     "url": "https://www.mzitu.com/hot/"
  /// },
  /// {
  ///     "title": "推荐",
  ///     "url": "https://www.mzitu.com/best/"
  /// },
  /// {
  ///     "title": "性感妹子",
  ///     "url": "https://www.mzitu.com/xinggan/"
  /// },
  /// {
  ///     "title": "日本妹子",
  ///     "url": "https://www.mzitu.com/japan/"
  /// },
  /// {
  ///     "title": "台湾妹子",
  ///     "url": "https://www.mzitu.com/taiwan/"
  /// },
  /// {
  ///     "title": "清纯妹子",
  ///     "url": "https://www.mzitu.com/mm/"
  /// }]
  ///
  static List<CategoryBean> getHomeTabs() {
    String tabStr =
        '[{"title":"最热","url":"https://www.mzitu.com/hot/"},{"title":"推荐","url":"https://www.mzitu.com/best/"},{"title":"性感","url":"https://www.mzitu.com/xinggan/"},{"title":"日本","url":"https://www.mzitu.com/japan/"},{"title":"台湾","url":"https://www.mzitu.com/taiwan/"},{"title":"清纯","url":"https://www.mzitu.com/mm/"}]';
    List jsonList = json.decode(tabStr);
    List<CategoryBean> tabList = [];
    jsonList.forEach((tab) {
      tabList.add(CategoryBean.fromJson(tab));
    });
    return tabList;
  }

  ///
  /// 获取分类 tab 数据
  /// [{
  ///     "title": "妹子自拍",
  ///     "url": "https://www.mzitu.com/zipai/",
  /// },
  /// {
  ///     "title": "街拍美女",
  ///     "url": "https://www.mzitu.com/jiepai/",
  /// }]
  ///
  static List<CategoryBean> getExploreTabs() {
    String tabStr =
        '[{"title":"自拍","url":"https://www.mzitu.com/zipai/"},{"title":"街拍","url":"https://www.mzitu.com/jiepai/"}]';
    List jsonList = json.decode(tabStr);
    List<CategoryBean> tabList = [];
    jsonList.forEach((tab) {
      tabList.add(CategoryBean.fromJson(tab));
    });
    return tabList;
  }
}
