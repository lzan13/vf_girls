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
  bool mobilePhoneVerified;
  int gold;
  String sessionToken;
  String createdAt;
  String updatedAt;
  bool admin;
  List<Object> collectIds;

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
    this.mobilePhoneVerified,
    this.gold,
    this.sessionToken,
    this.createdAt,
    this.updatedAt,
    this.admin,
    this.collectIds,
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
      mobilePhoneVerified: map['mobilePhoneVerified'],
      gold: map['gold'],
      sessionToken: map['sessionToken'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
      admin: map['admin'],
      collectIds: map['collectIds'],
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
      'mobilePhoneVerified': mobilePhoneVerified,
      'gold': gold,
      'sessionToken': sessionToken,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'admin': admin,
      'collectIds': collectIds,
    };
  }

  @override
  String toString() {
    return json.encode(this.toJson());
  }
}
