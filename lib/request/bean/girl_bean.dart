import 'dart:convert';
import 'package:vf_girls/request/bean/category_bean.dart';

///
/// 数据实体
///
class GirlBean {
  String title;

  String cover;
  List<String> images;

  String time;

  String jumpUrl;

  int count;
  int width;
  int height;

  CategoryBean category;

  GirlBean({
    this.title,
    this.cover,
    this.images,
    this.count,
    this.time,
    this.jumpUrl,
    this.width,
    this.height,
    this.category,
  });

  GirlBean.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        cover = json['cover'],
        images = json['images'],
        count = json['count'],
        time = json['time'],
        jumpUrl = json['jumpUrl'],
        width = json['width'],
        height = json['height'],
        category = json['category'];

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'cover': cover,
      'images': images,
      'count': count,
      'time': time,
      'jumpUrl': jumpUrl,
      'width': width,
      'height': height,
      'category': category,
    };
  }

  @override
  String toString() {
    return json.encode(this.toJson());
  }
}
