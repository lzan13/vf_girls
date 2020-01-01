import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'package:vf_girls/request/api.dart';

final Http http = Http();

class Http extends BaseHttp {
  @override
  void init() {
    // options.baseUrl = 'http://www.meinvtu.site';
    interceptors..add(ApiInterceptor());
  }
}

///
/// 请求结果拦截器
class ApiInterceptor extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options) async {
    // debugPrint('->api-> ${options.baseUrl}${options.path} ->params->${options.queryParameters}');
    return options;
  }

  @override
  onResponse(Response response) {
    // debugPrint('-api-response-> ${response.data}');
    // 直接返回结果
    return http.resolve(response);

    // 普通的 json 结果处理
    // Result result = Result.fromJson(response.data);
    // if (result.success) {
    //   response.data = result.data;
    //   return http.resolve(response);
    // } else {
    //   if (result.code == -1001) {
    //     // 如果cookie过期,需要清除本地存储的登录信息
    //     // StorageManager.localStorage.deleteItem(UserModel.keyUser);
    //     throw FailException.fromRespData(result);
    //   }
    // }
  }
}

class Result extends BaseResult {
  bool get success => 0 == code;

  Result.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'];
  }
}
