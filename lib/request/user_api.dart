import 'package:dio/dio.dart';
import 'package:vf_girls/common/index.dart';

import 'package:vf_plugin/vf_plugin.dart';

import 'package:vf_girls/common/config.dart';
import 'package:vf_girls/request/api.dart';

export 'package:vf_girls/request/api.dart';

final Http http = Http();

class Http extends BaseHttp {
  @override
  void init() {
    options.baseUrl = Configs.lcBaseUrl;
    interceptors..add(UserInterceptor());
  }
}

///
/// 请求结果拦截器
///
class UserInterceptor extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options) async {
    // 添加所需的请求头
    options.headers['Content-Type'] = 'application/json';
    options.headers['X-LC-Id'] = Configs.lcAppId;
    options.headers['X-LC-Key'] = Configs.lcAppKey;
    String token = StorageManager.getToken();
    if (token != null) {
      options.headers['X-LC-Session'] = token;
    }

    // 添加公共请求体
    // options.queryParameters['appKey'] = '7954deb7bce815d3b49a0626ff0b76a7';
    VFLog.d('api-> ${options.baseUrl}${options.path}');
    VFLog.d('api->headers-> ${options.headers}');
    VFLog.d('api->params-> ${options.queryParameters}');
    return options;
  }

  @override
  onResponse(Response response) {
    VFLog.d('api-response-> ${response.data}');
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return http.resolve(response);
    } else {
      throw FException.fromJson(response.data);
    }
    // // 普通的 json 结果处理
    // Result result = Result.fromJson(response.data);
    // if (result.success) {
    //   response.data = result.data;
    //   return http.resolve(response);
    // } else {
    //   throw FailException.fromJson(response.data);
    // }
  }
}

///
/// Post 请求
///
dynamic postRequest(path, params) async {
  try {
    var response = await http.post<Map>(path, queryParameters: params);
    return response.data;
  } catch (dioErr) {
    return formatError(dioErr);
  }
}

///
/// Get 请求，参数直接拼接在路径中
///
dynamic getRequest(path) async {
  try {
    var response = await http.get(path);
    return response.data;
  } catch (dioErr) {
    return formatError(dioErr);
  }
}
