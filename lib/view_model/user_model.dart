import 'package:flutter/material.dart';
import 'package:vf_girls/common/index.dart';
import 'package:vf_girls/model/user.dart';

class UserModel extends ChangeNotifier {
  static const String key_account = 'key_account';

  User _user;

  User get user => _user;

  bool get hasUser => user != null;

  UserModel() {
    var userMap = StorageManager.localStorage.getItem(key_account);
    _user = userMap != null ? User.fromJsonMap(userMap) : null;
  }

  saveUser(User user) {
    _user = user;
    notifyListeners();
    StorageManager.localStorage.setItem(key_account, user);
  }

  /// 清除持久化的用户数据
  clearUser() {
    _user = null;
    notifyListeners();
    StorageManager.localStorage.deleteItem(key_account);
  }
}
