import 'dart:convert';

import 'package:vf_girls/request/bean/girl_bean.dart';

///
/// 数据实体
///
class DailyBean {
  String next;
  List<String> images;
  // 排行榜
  List<GirlBean> topGirls;

  DailyBean({
    this.next,
    this.images,
    this.topGirls,
  });

  factory DailyBean.fromJson(Map<String, dynamic> map) {
    var list = map['topGirls'];
    List<GirlBean> topGirls = List<GirlBean>.from(list);
    return DailyBean(
      next: map['next'],
      images: map['images'],
      topGirls: topGirls,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'next': next,
      'images': images,
      'topGirls': topGirls,
    };
  }

  @override
  String toString() {
    return json.encode(this.toJson());
  }
}
