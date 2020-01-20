import 'dart:convert';

import 'package:vf_girls/request/bean/user_bean.dart';

///
/// 评论数据实体
///
class CommentBean {
  String url;
  String objectId;
  String content;
  UserBean user;

  CommentBean({
    this.url,
    this.objectId,
    this.content,
    this.user,
  });

  factory CommentBean.fromJson(Map<String, dynamic> map) {
    UserBean user = UserBean.fromJson(map['user']);
    return CommentBean(
      url: map['url'],
      objectId: map['objectId'],
      content: map['content'],
      user: user,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'objectId': objectId,
      'content': content,
      'user': user,
    };
  }

  @override
  String toString() {
    return json.encode(this.toJson());
  }
}
