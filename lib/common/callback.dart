import 'dart:convert';

/// 通用回调接口
typedef void CommonCallback(dynamic result, FError err);

///
/// 异常实体类
///
class FError {
  int code;
  String error;

  FError({
    this.code,
    this.error,
  });

  factory FError.fromJson(Map<String, dynamic> map) {
    return FError(
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
