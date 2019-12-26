import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';
import 'dart:convert';
import 'dart:io';

// 数据实体
class GirlEntity {
  String title;
  String imgUrl;
  String jumpUrl;
  String count;

  GirlEntity({
    this.title,
    this.imgUrl,
    this.jumpUrl,
    this.count,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'imgUrl': imgUrl,
      'jumpUrl': jumpUrl,
      'count': count,
    };
  }
}

///
/// 请求地址获取 Html 数据
///
requestHtml() async {
  var url = "http://www.meinvtu.site/";

  var response = await http.get(url);
  if (response.statusCode == 200) {
    return response.body;
  }
  return '<html>error! status:${response.statusCode}</html>';
}

///
/// 解析 Html 数据
///
parseHtml() async {
  var html = await requestHtml();
  Document document = parse(html);
  // 这里使用css选择器语法提取数据
  List<Element> elements =
      document.querySelectorAll('.page-index > .item-box > .item-list > a');
  List<GirlEntity> data = [];
  if (elements.isNotEmpty) {
    data = List.generate(elements.length, (i) {
      GirlEntity entity = GirlEntity();
      entity.jumpUrl = elements[i].attributes['href'];

      Element image = elements[i].querySelector('.img-wrap>.img-inner>img');
      entity.title = image.attributes['alt'];
      entity.imgUrl = image.attributes['data-original'];

      Element tips = elements[i].querySelector('.img-wrap>.img-inner>.tips');
      entity.count = tips.text;

      return entity;
      // GirlEntity(
      //     title: elements[i].attributes['alt'],
      //     imgUrl: elements[i].attributes['data-original']);
    });
  }
  return data;
}

///
/// 加载数据
///
void loadData() async {
  var data = await parseHtml();

  String jsonStr = json.encode({'items': data});
  print(jsonStr);

  // 将json写入文件中
  // await File('data.json').writeAsString(jsonStr, flush: true);
}
