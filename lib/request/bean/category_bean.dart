import 'dart:convert';

///
/// 分类数据实体
///
class CategoryBean {
  String title;
  String url;

  CategoryBean({
    this.title,
    this.url,
  });

  CategoryBean.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        url = json['url'];

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'url': url,
    };
  }

  @override
  String toString() {
    return json.encode(this.toJson());
  }
}
