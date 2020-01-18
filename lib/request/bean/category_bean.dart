import 'dart:convert';

///
/// 标签分类数据实体
///
class CategoryBean {
  String title;
  String desc;
  String cover;
  String url;

  CategoryBean({
    this.title,
    this.desc,
    this.cover,
    this.url,
  });

  factory CategoryBean.fromJson(Map<String, dynamic> map) {
    return CategoryBean(
      title: map['title'],
      desc: map['desc'],
      cover: map['cover'],
      url: map['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'title': title, 'desc': desc, 'cover': cover, 'url': url};
  }

  @override
  String toString() {
    return json.encode(this.toJson());
  }
}
