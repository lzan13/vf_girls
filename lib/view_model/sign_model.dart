import 'package:flutter/material.dart';
import 'package:vf_girls/common/callback.dart';

import 'package:vf_girls/common/index.dart';
import 'package:vf_girls/request/bean/bmob_manager.dart';
import 'package:vf_girls/request/bean/user_bean.dart';
import 'package:vf_girls/request/sign_manager.dart';

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
    var userMap = StorageManager.getSignInfo();
    _user = userMap != null ? UserBean.fromJson(userMap) : null;
  }

  String getUsername() {
    return StorageManager.getUsername();
  }

  ///
  /// 注册
  ///
  Future<bool> signUp(username, password) async {
    setBusy();
    dynamic result = await BMobManager.instance.signUp(username, password);
    // dynamic result = await SignManager.signUp(username, password);
    if (result is FError) {
      setIdle();
      return false;
    } else {
      saveUser(result);
      return true;
    }
  }

  ///
  /// 登录
  ///
  Future<bool> signIn(username, password) async {
    setBusy();
    BMobManager.instance.signIn(username, password);
    dynamic result = await SignManager.signIn(username, password);
    if (result is UserBean) {
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
    bool result = await SignManager.signOut();
    clearUser();
    return result;
  }

  ///
  /// 更新自己的用户信息
  ///
  void updateUserInfo() async {
    dynamic result = await SignManager.getUserInfo();
    if (result is UserBean) {
      saveUser(result);
    } else {
      setIdle();
    }
  }

  ///
  /// 提较奖励
  ///
  Future<bool> submitReward(amount) async {
    if (!isSign) {
      return false;
    }
    _user.gold += amount;
    await SignManager.submitReward(_user.gold);

    saveUser(_user);
    return true;
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
    StorageManager.saveSignInfo(_user);
  }

  ///
  /// 清除持久化的用户数据
  ///
  clearUser() {
    _user = null;
    setIdle();
    StorageManager.clearSignInfo();
  }
}
