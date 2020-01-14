import 'dart:convert';

///
/// 分类数据实体
///
class CategoryBean {
  String title;
  String url;

  CategoryBean({this.title, this.url});

  factory CategoryBean.fromJson(Map<String, dynamic> json) {
    return CategoryBean(title: json['title'], url: json['url']);
  }

  Map<String, dynamic> toJson() {
    return {'title': title, 'url': url};
  }

  @override
  String toString() {
    return json.encode(this.toJson());
  }
}
