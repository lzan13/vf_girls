import 'package:data_plugin/bmob/bmob.dart';
import 'package:data_plugin/bmob/response/bmob_error.dart';
import 'package:data_plugin/bmob/response/bmob_registered.dart';
import 'package:data_plugin/bmob/table/bmob_user.dart';
import 'package:vf_girls/common/callback.dart';

import 'package:vf_girls/common/config.dart';
import 'package:vf_girls/ui/widget/toast.dart';

///
/// BMob 数据管理类
///
class BMobManager {
  ///
  /// 工厂模式实现单例
  ///
  factory BMobManager() => _generateInstance();
  // 单例类实例公开访问点
  static BMobManager get instance => _generateInstance();
  // 静态私有成员，没有初始化
  static BMobManager _instance;
  // 私有化构造方法
  BMobManager._() {}
  // 静态、同步、私有访问点
  static BMobManager _generateInstance() {
    if (_instance == null) {
      _instance = BMobManager._();
    }
    return _instance;
  }

  /// 初始化
  void init() {
    Bmob.init(Configs.bmobAppId, Configs.bmobAppRestKey);
  }

  ///
  /// 注册
  ///
  Future signUp(username, password) async {
    BmobUser user = BmobUser();
    user.username = username;
    user.password = password;
    try {
      BmobRegistered data = await user.register();
      user.objectId = data.objectId;
      user.sessionToken = data.sessionToken;
      return user;
    } catch (e) {
      return commonError(e);
    }
    // then((BmobRegistered data) {
    //   user.objectId = data.objectId;
    //   user.sessionToken = data.sessionToken;
    //   if (callback != null) {
    //     callback(user, null);
    //   }
    // }).catchError((e) {
    //   commonError(e, callback);
    // });
  }

  ///
  /// 登录
  ///
  void signIn(username, password, {CommonCallback callback}) {
    BmobUser user = BmobUser();
    user.username = username;
    user.password = password;
    user.login().then((BmobUser user) {
      if (callback != null) {
        callback(user, null);
      }
    }).catchError((e) {
      commonError(e);
    });
  }

  ///
  /// 统一处理错误信息
  ///
  FError commonError(e) {
    FError ex = FError(
      code: BmobError.convert(e).code,
      error: BmobError.convert(e).error,
    );
    VFToast.error(ex.toString());
    return ex;
  }
}
