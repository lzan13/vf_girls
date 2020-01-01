import 'package:vf_girls/request/girls_api.dart';

import 'package:html/dom.dart';
import 'package:html/parser.dart' show parse;

import 'package:vf_girls/request/bean/girl.dart';

class GirlsManager {
  ///
  /// 加载首页数据
  ///
  static Future loadHomeData() async {
    var response = await http.get("http://www.meinvtu.site/");
    var result;
    if (response.statusCode == 200) {
      result = response.data;
    } else {
      result = '<html>error! status:${response.statusCode}</html>';
    }

    Document document = parse(result);
    // 这里使用 css 选择器语法提取数据
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

        print(entity);

        return entity;
      });
    }
    return data;
  }

  ///
  /// 获取详情
  ///
  static Future loadDetail(String detailUrl) async {
    var response = await http.get(detailUrl);
    var result;
    if (response.statusCode == 200) {
      result = response.data;
    } else {
      result = '';
    }

    int start = result.indexOf('[[{');
    int end = result.indexOf('}]]');
    result = result.subString(start, end);

    return null;
  }
}
