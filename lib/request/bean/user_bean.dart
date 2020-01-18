import 'dart:convert';

///
/// 用户信息数据实体
///
class UserBean {
  int id;
  String username;
  String password;
  String nickname;
  String email;
  String avatar;
  String cover;
  int gold;
  String token;
  bool admin;
  List<Object> collectIds;

  UserBean({
    this.id,
    this.username,
    this.email,
    this.avatar,
    this.cover,
    this.nickname,
    this.password,
    this.gold,
    this.token,
    this.admin,
    this.collectIds,
  });

  factory UserBean.fromJson(Map<String, dynamic> map) {
    return UserBean(
      id: map['id'],
      username: map['username'],
      email: map['email'],
      avatar: map['avatar'],
      cover: map['cover'],
      nickname: map['nickname'],
      password: map['password'],
      gold: map['gold'],
      token: map['token'],
      admin: map['admin'],
      collectIds: map['collectIds'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'avatar': avatar,
      'cover': cover,
      'nickname': nickname,
      'password': password,
      'gold': gold,
      'token': token,
      'admin': admin,
      'collectIds': collectIds,
    };
  }

  @override
  String toString() {
    return json.encode(this.toJson());
  }
}
