import 'dart:convert';

// 数据实体
class GirlEntity {
  String title;
  String imgUrl;
  String jumpUrl;
  String count;

  GirlEntity({
    this.title,
    this.imgUrl,
    this.jumpUrl,
    this.count,
  });

  GirlEntity.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        imgUrl = json['img'],
        jumpUrl = json['jumpUrl'],
        count = json['count'];

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'imgUrl': imgUrl,
      'jumpUrl': jumpUrl,
      'count': count,
    };
  }

  @override
  String toString() {
    return json.encode(this.toJson());
  }
}
