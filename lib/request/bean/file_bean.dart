import 'dart:convert';

///
/// 文件数据实体
/// avatar: {
///     mime_type: image / png,
///     updatedAt: 2020 - 01 - 19T07: 47 : 48.306Z,
///     key: 21061fe4dc06a47add18 / avatar_me.png,
///     name: avatar_me.png,
///     objectId: 5e2409a4562071008e379521,
///     createdAt: 2020 - 01 - 19T07: 47 : 48.3,
///     __type: File,
///     url: http: //lc-j1AGx1iU.cn-n1.lcfile.com/21061fe4dc06a47add18/avatar_me.png,
///     provider: qiniu,
///     bucket: j1AGx1iU
///     metaData: {
///         size: 23126,
///         owner: unknown
///     },
/// },
///
class FileBean {
  String objectId;
  String key;
  String name;
  String url;
  String createdAt;
  String updatedAt;
  String mime_type;
  String provider;
  String bucket;

  FileBean({
    this.objectId,
    this.key,
    this.name,
    this.url,
    this.createdAt,
    this.updatedAt,
    this.mime_type,
    this.provider,
    this.bucket,
  });

  factory FileBean.fromJson(Map<String, dynamic> map) {
    if (map == null) {
      return null;
    }
    return FileBean(
      objectId: map['objectId'],
      key: map['key'],
      name: map['name'],
      url: map['url'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
      mime_type: map['mime_type'],
      provider: map['provider'],
      bucket: map['bucket'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'objectId': objectId,
      'key': key,
      'name': name,
      'url': url,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'mime_type': mime_type,
      'provider': provider,
      'bucket': bucket,
    };
  }

  @override
  String toString() {
    return json.encode(this.toJson());
  }
}
