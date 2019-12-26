class User {
  int id;
  String username;
  String email;
  String avatar;
  String cover;
  String nickname;
  String password;
  String token;
  bool admin;
  List<Object> collectIds;

  User.fromJsonMap(Map<String, dynamic> map)
      : id = map["id"],
        username = map["username"],
        email = map["email"],
        avatar = map["avatar"],
        cover = map["cover"],
        nickname = map["nickname"],
        password = map["password"],
        token = map["token"],
        admin = map["admin"],
        collectIds = map["collectIds"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['username'] = username;
    data['email'] = email;
    data['avatar'] = avatar;
    data['cover'] = cover;
    data['nickname'] = nickname;
    data['password'] = password;
    data['token'] = token;
    data['admin'] = admin;
    data['collectIds'] = collectIds;
    return data;
  }
}
