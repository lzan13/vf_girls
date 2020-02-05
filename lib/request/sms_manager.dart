import 'package:mobsms/mobsms.dart';
import 'package:vf_plugin/vf_plugin.dart';

class SMSManager {
  ///
  /// 工厂模式实现单例
  ///
  factory SMSManager() => _generateInstance();
  // 单例类实例公开访问点
  static SMSManager get instance => _generateInstance();
  // 静态私有成员，没有初始化
  static SMSManager _instance;
  // 私有化构造方法
  SMSManager._() {}
  // 静态、同步、私有访问点
  static SMSManager _generateInstance() {
    if (_instance == null) {
      _instance = SMSManager._();
    }
    return _instance;
  }

  ///
  /// 请求文本验证码
  ///
  Future getTextCode(phone) async {
    await Smssdk.getTextCode(phone, '86', '0', (dynamic ret, Map err) {
      if (err != null) {
        VFLog.e('请求短信验证码失败 $err');
        return err;
      } else {
        VFLog.d('请求短信验证码成功 $ret');
        return ret;
      }
    });
  }

  ///
  /// 请求语音验证码
  ///
  Future getVoiceCode(phone) async {
    Smssdk.getVoiceCode(phone, '86', (dynamic ret, Map err) {
      if (err != null) {
        VFLog.d('请求语音验证码失败 ');
      }
    });
  }

  ///
  /// 提交验证码
  ///
  Future commitCode(phone, code) async {
    Smssdk.commitCode(phone, '86', code, (dynamic ret, Map err) {
      if (err != null) {
        VFLog.d('验证码无效');
      }
    });
  }

  ///
  /// 获取国家代码
  ///
  Future getSupportedCountries(phone) async {
    Smssdk.getSupportedCountries((dynamic ret, Map err) {
      if (err != null) {
        VFLog.d('获取国家列表失败');
      } else {
        VFLog.d(ret);
      }
    });
  }
}
