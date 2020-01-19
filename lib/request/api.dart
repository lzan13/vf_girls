import 'dart:io';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:flutter/foundation.dart';
import 'package:vf_girls/ui/widget/toast.dart';

import 'package:vf_plugin/vf_plugin.dart';

// 必须是顶层函数
_parseAndDecode(String response) {
  return jsonDecode(response);
}

parseJson(String text) {
  return compute(_parseAndDecode, text);
}

abstract class BaseHttp extends DioForNative {
  BaseHttp() {
    /// 初始化 加入通用处理
    (transformer as DefaultTransformer).jsonDecodeCallback = parseJson;
    interceptors..add(HeaderInterceptor());
    init();
  }

  void init();
}

///
/// 通用 Header 拦截器
///
class HeaderInterceptor extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options) async {
    options.connectTimeout = 30 * 1000;
    options.receiveTimeout = 30 * 1000;

    var appVersion = await VFPlatform.getAppVersion();
    // var version = Map()
    //   ..addAll({
    //     'app_verison': appVersion,
    //   });
    // options.headers['version'] = appVersion;
    // options.headers['platform'] = Platform.operatingSystem;

    // VFLog.d('api-> ${options.baseUrl}${options.path}');
    // VFLog.d('api->headers-> ${options.headers}');
    // VFLog.d('api->params-> ${options.queryParameters}');
    return options;
  }
}

///
/// error统一处理
///
dynamic formatError(DioError dioErr) {
  FException exception;
  if (dioErr.response != null && dioErr.response.data != null) {
    exception = FException.fromJson(dioErr.response.data);
  } else {
    exception = FException();
    exception.code = dioErr.response.statusCode;
    if (dioErr.type == DioErrorType.CONNECT_TIMEOUT) {
      // It occurs when url is opened timeout.
      exception.error = '连接超时 ${dioErr.error}';
    } else if (dioErr.type == DioErrorType.SEND_TIMEOUT) {
      // It occurs when url is sent timeout.
      exception.error = '请求超时 ${dioErr.error}';
    } else if (dioErr.type == DioErrorType.RECEIVE_TIMEOUT) {
      //It occurs when receiving timeout
      exception.error = '响应超时 ${dioErr.error}';
    } else if (dioErr.type == DioErrorType.RESPONSE) {
      // When the server response, but with a incorrect status, such as 404, 503...
      exception.error = '响应错误 ${dioErr.error}';
    } else if (dioErr.type == DioErrorType.CANCEL) {
      // When the request is cancelled, dio will throw a error with this type.
      exception.error = '请求取消 ${dioErr.error}';
    } else {
      //DEFAULT Default error type, Some other Error. In this case, you can read the DioError.error if it is not null.
      exception.error = '未知错误 ${dioErr.error}';
    }
  }
  VFLog.e('请求失败: $exception');

  VFToast.error(exception.error);
  return exception;
}

///
/// 请求结果基类，一般接口定义方式
///
abstract class BaseResult {
  int code = 0;
  String msg;
  dynamic data;

  bool get success;

  BaseResult({this.code, this.msg, this.data});

  Map<String, dynamic> toJson() {
    return {'code': code, 'msg': msg, 'data': data};
  }

  @override
  String toString() {
    return json.encode(this.toJson());
  }
}

///
/// 默认的接口数据处理
class Result extends BaseResult {
  bool get success => 0 == code;

  Result.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    data = json['data'];
  }
}

///
/// 异常实体类
///
class FException implements Exception {
  int code;
  String error;

  FException({
    this.code,
    this.error,
  });

  factory FException.fromJson(Map<String, dynamic> map) {
    return FException(
      code: map['code'],
      error: map['error'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'code': code, 'error': error};
  }

  @override
  String toString() {
    return json.encode(this.toJson());
  }
}
