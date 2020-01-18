import 'package:flutter/material.dart';

import 'package:vf_girls/common/config.dart';
import 'package:vf_girls/common/index.dart';
import 'package:vf_girls/request/bean/user_bean.dart';
import 'package:vf_girls/request/user_manager.dart';
import 'package:vf_plugin/vf_plugin.dart';

/// 状态类型
enum StateType {
  idle, // 空闲中
  busy, // 忙碌中
  error, // 失败了
}

///
/// 登录信息数据共享
///
class SignModel extends ChangeNotifier {
  UserBean _user;
  StateType _stateType = StateType.idle;

  UserBean get user => _user;
  bool get isSign => user != null;
  bool get isBusy => _stateType == StateType.busy;

  SignModel() {
    var userMap = StorageManager.localStorage.getItem(Configs.KEY_USER_INFO);
    _user = userMap != null ? UserBean.fromJson(userMap) : null;
  }

  String getUsername() {
    return StorageManager.sharedPreferences.getString(Configs.KEY_USER_NAME);
  }

  ///
  /// 提较奖励
  ///
  Future<bool> submitReward(amount) async {
    if (!isSign) {
      return false;
    }
    _user.gold += amount;
    dynamic result = await UserManager.submitReward(_user.gold);

    saveUser(_user);
    return true;
  }

  ///
  /// 登录
  ///
  Future<bool> signIn(loginName, password) async {
    setBusy();
    dynamic result = await UserManager.signIn(loginName, password);
    VFLog.d('signIn result $result');
    if (result != null && result is UserBean) {
      saveUser(result);
      return true;
    } else {
      setIdle();
      return false;
    }
  }

  ///
  /// 注册
  ///
  Future<bool> signUp(loginName, password) async {
    setBusy();
    dynamic result = await UserManager.signUp(loginName, password);
    VFLog.d('signIn result $result');
    if (result != null && result is UserBean) {
      saveUser(result);
      return true;
    } else {
      setIdle();
      return false;
    }
  }

  ///
  /// 注销
  ///
  Future<bool> signOut() async {
    if (!isSign) {
      //防止递归
      return false;
    }
    setBusy();
    bool result = await UserManager.signOut();
    clearUser();
    return result;
  }

  ///
  /// 设置忙碌状态
  ///
  void setIdle() {
    _stateType = StateType.idle;
    notifyListeners();
  }

  ///
  /// 设置忙碌状态
  ///
  void setBusy() {
    _stateType = StateType.busy;
    notifyListeners();
  }

  ///
  /// 设置错误状态
  ///
  void setError() {
    _stateType = StateType.error;
    notifyListeners();
  }

  ///
  /// 保存用户
  ///
  saveUser(UserBean user) {
    _user = user;
    setIdle();
    StorageManager.sharedPreferences
        .setString(Configs.KEY_USER_NAME, user.username);
    StorageManager.localStorage.setItem(Configs.KEY_USER_INFO, user);
  }

  ///
  /// 清除持久化的用户数据
  ///
  clearUser() {
    _user = null;
    setIdle();
    StorageManager.localStorage.deleteItem(Configs.KEY_USER_INFO);
  }
}
