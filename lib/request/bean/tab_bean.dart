import 'dart:convert';

///
/// 数据实体
///
class TabBean {
  String title;
  String url;

  TabBean({
    this.title,
    this.url,
  });

  TabBean.fromJson(Map<String, dynamic> json)
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
