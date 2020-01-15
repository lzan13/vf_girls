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

  factory DailyBean.fromJson(Map<String, dynamic> json) {
    var list = json['topGirls'];
    List<GirlBean> topGirls = List<GirlBean>.from(list);
    return DailyBean(
      next: json['next'],
      images: json['images'],
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
