import 'dart:convert';

///
/// 数据实体
///
class GirlBean {
  String title;

  String cover;
  List<String> images;

  String count;
  String time;

  String jumpUrl;

  int width;
  int height;

  GirlBean({
    this.title,
    this.cover,
    this.images,
    this.count,
    this.time,
    this.jumpUrl,
    this.width,
    this.height,
  });

  GirlBean.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        cover = json['cover'],
        images = json['images'],
        count = json['count'],
        time = json['time'],
        jumpUrl = json['jumpUrl'],
        width = json['width'],
        height = json['height'];

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
    };
  }

  @override
  String toString() {
    return json.encode(this.toJson());
  }
}
