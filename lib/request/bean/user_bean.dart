import 'dart:convert';

import 'package:vf_girls/request/bean/file_bean.dart';

///
/// 用户信息数据实体
///
class UserBean {
  String objectId;
  String username;
  String password;
  String nickname;
  String signature;
  FileBean avatar;
  FileBean cover;
  String email;
  bool emailVerified;
  String phone;
  bool phoneVerified;
  int gold;
  String sessionToken;
  String createdAt;
  String updatedAt;
  bool admin;

  UserBean({
    this.objectId,
    this.username,
    this.password,
    this.nickname,
    this.signature,
    this.avatar,
    this.cover,
    this.email,
    this.emailVerified,
    this.phone,
    this.phoneVerified,
    this.gold,
    this.sessionToken,
    this.createdAt,
    this.updatedAt,
    this.admin,
  });

  factory UserBean.fromJson(Map<String, dynamic> map) {
    FileBean avatar = FileBean.fromJson(map['avatar']);
    FileBean cover = FileBean.fromJson(map['cover']);
    return UserBean(
      objectId: map['objectId'],
      username: map['username'],
      password: map['password'],
      nickname: map['nickname'],
      signature: map['signature'],
      avatar: avatar,
      cover: cover,
      email: map['email'],
      emailVerified: map['emailVerified'],
      phone: map['phone'],
      phoneVerified: map['phoneVerified'],
      gold: map['gold'],
      sessionToken: map['sessionToken'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
      admin: map['admin'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'objectId': objectId,
      'username': username,
      'password': password,
      'nickname': nickname,
      'signature': signature,
      'avatar': avatar,
      'cover': cover,
      'email': email,
      'emailVerified': emailVerified,
      'phone': phone,
      'phoneVerified': phoneVerified,
      'gold': gold,
      'sessionToken': sessionToken,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'admin': admin,
    };
  }

  @override
  String toString() {
    return json.encode(this.toJson());
  }
}
