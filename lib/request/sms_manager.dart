import 'package:mobsms/mobsms.dart';
import 'package:vf_plugin/vf_plugin.dart';

class SMSManager {
  ///
  /// 请求文本验证码
  ///
  static Future getTextCode(phone) async {
    Smssdk.getTextCode(phone, '86', '0', (dynamic ret, Map err) {
      if (err != null) {
        VFLog.d('请求短信验证码失败 ');
      }
    });
  }

  ///
  /// 请求语音验证码
  ///
  static Future getVoiceCode(phone) async {
    Smssdk.getVoiceCode(phone, '86', (dynamic ret, Map err) {
      if (err != null) {
        VFLog.d('请求语音验证码失败 ');
      }
    });
  }

  ///
  /// 提交验证码
  ///
  static Future commitCode(phone, code) async {
    Smssdk.commitCode(phone, '86', code, (dynamic ret, Map err) {
      if (err != null) {
        VFLog.d('验证码无效');
      }
    });
  }

  ///
  /// 获取国家代码
  ///
  static Future getSupportedCountries(phone) async {
    Smssdk.getSupportedCountries((dynamic ret, Map err) {
      if (err != null) {
        VFLog.d('获取国家列表失败');
      } else {
        VFLog.d(ret);
      }
    });
  }
}
