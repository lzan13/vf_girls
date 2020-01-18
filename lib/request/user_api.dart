import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'package:vf_plugin/vf_plugin.dart';

import 'package:vf_girls/request/api.dart';
import 'package:vf_girls/ui/widget/toast.dart';

final Http http = Http();

class Http extends BaseHttp {
  @override
  void init() {
    options.baseUrl = 'http://www.meinvtu.site';
    interceptors..add(ApiInterceptor());
  }
}

///
/// 请求结果拦截器
class ApiInterceptor extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options) async {
    debugPrint(
        '->api-> ${options.baseUrl}${options.path} ->params->${options.queryParameters}');
    return options;
  }

  @override
  onResponse(Response response) {
    debugPrint('-api-response-> ${response.data}');
    // 普通的 json 结果处理
    Result result = Result.fromJson(response.data);
    if (result.success) {
      response.data = result.data;
      return http.resolve(response);
    } else {
      throw FailException.fromRespData(result);
    }
  }
}

///
/// error统一处理
///
void formatError(DioError e) {
  String error = '';
  if (e.type == DioErrorType.CONNECT_TIMEOUT) {
    // It occurs when url is opened timeout.
    error = '连接超时 ${e.error}';
  } else if (e.type == DioErrorType.SEND_TIMEOUT) {
    // It occurs when url is sent timeout.
    error = '请求超时 ${e.error}';
  } else if (e.type == DioErrorType.RECEIVE_TIMEOUT) {
    //It occurs when receiving timeout
    error = '响应超时 ${e.error}';
  } else if (e.type == DioErrorType.RESPONSE) {
    // When the server response, but with a incorrect status, such as 404, 503...
    error = '响应错误 ${e.error}';
  } else if (e.type == DioErrorType.CANCEL) {
    // When the request is cancelled, dio will throw a error with this type.
    error = '请求取消 ${e.error}';
  } else {
    //DEFAULT Default error type, Some other Error. In this case, you can read the DioError.error if it is not null.
    error = '未知错误 ${e.error}';
  }
  VFLog.e('请求失败: $error');
  VFToast.error(error);
}

class Result extends BaseResult {
  bool get success => 0 == code;

  Result.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'];
  }
}
