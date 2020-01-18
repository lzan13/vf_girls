import 'package:vf_girls/request/bean/user_bean.dart';
import 'package:vf_girls/request/user_api.dart';

class UserManager {
  ///
  /// 提交奖励
  ///
  static Future submitReward(amount) async {
    try {
      var response = await http.post<Map>('/user/reward', queryParameters: {
        'amount': amount,
      });
      return UserBean.fromJson(response.data);
    } catch (e, s) {
      formatError(e);
      return null;
    }
  }

  ///
  ///  登录
  ///
  static Future signIn(username, password) async {
    try {
      var response = await http.post<Map>('/user/signIn', queryParameters: {
        'username': username,
        'password': password,
      });
      return UserBean.fromJson(response.data);
    } catch (e, s) {
      formatError(e);
      return null;
    }
  }

  ///
  /// 注册
  ///
  static Future signUp(username, password) async {
    try {
      var response = await http.post<Map>('/user/signUp', queryParameters: {
        'username': username,
        'password': password,
      });
      return UserBean.fromJson(response.data);
    } catch (e, s) {
      formatError(e);
      return null;
    }
  }

  ///
  /// 注销
  ///
  static Future<bool> signOut() async {
    try {
      await http.get('user/signOut');
      return true;
    } catch (e, s) {
      formatError(e);
      return false;
    }
  }
}
