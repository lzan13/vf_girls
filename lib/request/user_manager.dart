import 'package:vf_girls/request/bean/user_bean.dart';
import 'package:vf_girls/request/user_api.dart';

class UserManager {
  ///
  /// 注册
  ///
  static Future signUp(username, password) async {
    dynamic data = await postRequest('/users', {
      'username': username,
      'password': password,
    });
    if (data is FException) {
      return data;
    } else {
      return UserBean.fromJson(data);
    }
  }

  ///
  /// 登录
  ///
  static Future signIn(username, password) async {
    dynamic data = await postRequest('/login', {
      'username': username,
      'password': password,
    });
    if (data is FException) {
      return data;
    } else {
      return UserBean.fromJson(data);
    }
  }

  ///
  /// 注销
  ///
  static Future<bool> signOut() async {
    dynamic result = await getRequest('/users');
    if (result is FException) {
      return false;
    } else {
      return true;
    }
  }

  ///
  /// 获取用户信息
  ///
  static Future getUserInfo() async {
    dynamic data = await getRequest('/users/me');
    if (data is FException) {
      return data;
    } else {
      return UserBean.fromJson(data);
    }
  }

  ///
  /// 提交奖励
  ///
  static Future submitReward(amount) async {
    dynamic data = await postRequest('/user/reward', {
      'amount': amount,
    });
    if (data is FException) {
      return data;
    } else {
      return UserBean.fromJson(data);
    }
  }
}
