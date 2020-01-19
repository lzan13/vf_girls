import 'package:dio/dio.dart';
import 'package:vf_girls/request/api.dart';
import 'package:vf_plugin/vf_plugin.dart';

final Http http = Http();

class Http extends BaseHttp {
  @override
  void init() {
    // options.baseUrl = 'http://www.meinvtu.site';
    interceptors..add(GirlInterceptor());
  }
}

///
/// Girls 相管请求拦截器
///
class GirlInterceptor extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options) async {
    VFLog.d('api-> ${options.baseUrl}${options.path}');
    VFLog.d('api->headers-> ${options.headers}');
    VFLog.d('api->params-> ${options.queryParameters}');
    return options;
  }
}
