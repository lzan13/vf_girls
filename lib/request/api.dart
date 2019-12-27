import 'dart:io';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:flutter/foundation.dart';
import 'package:vf_girls/util/platform_utils.dart';

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
/// 添加 Header
///
class HeaderInterceptor extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options) async {
    options.connectTimeout = 30 * 1000;
    options.receiveTimeout = 30 * 1000;

    var appVersion = await PlatformUtils.getAppVersion();
    // var version = Map()
    //   ..addAll({
    //     'app_verison': appVersion,
    //   });
    options.headers['version'] = appVersion;
    options.headers['platform'] = Platform.operatingSystem;
    return options;
  }
}

///
/// 请求结果基类
///
abstract class BaseResult {
  int code = 0;
  String message;
  dynamic data;

  bool get success;

  BaseResult({this.code, this.message, this.data});

  @override
  String toString() {
    return 'result:{code: $code, message: $message, data: $data}';
  }
}

///
/// 接口返回失败
///
class FailException implements Exception {
  int code;
  String message;

  FailException.fromRespData(BaseResult result) {
    code = result.code;
    message = result.message;
  }

  @override
  String toString() {
    return 'FailException: {code: $code, message: $message}';
  }
}
