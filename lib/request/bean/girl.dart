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
    return 'title $title';
  }
}
