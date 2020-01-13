import 'dart:convert';

import 'package:vf_girls/request/girls_api.dart';

import 'package:html/dom.dart';
import 'package:html/parser.dart' show parse;

import 'package:vf_girls/request/bean/girl_bean.dart';

class GirlsManager {
  static Future loadHomeData(String url) async {
    // <div class="main">
    //   <div class="main-content">
    //     <div class="postlist">
    //       <ul id="pins">
    //         <li>
    //           <a href="https://www.mzitu.com/219871" target="_blank">
    //             <img class='lazy' src='https://www.mzitu.com/static/pc/img/lazy.png' data-original='https://i.mmzztt.com/thumb/2020/01/219871_236.jpg' alt='标题描述' width='236' height='354' />
    //           </a>
    //           <span>
    //             <a href="https://www.mzitu.com/219871" target="_blank">标题描述</a>
    //           </span>
    //           <span class="time">2020-01-12</span>
    //         </li>
    //       </ul>
    //     </div>
    //   </div>
    // </div>
    print('request url: $url');
    var response = await http.get(url);
    var result;
    if (response.statusCode == 200) {
      result = response.data;
    } else {
      result = '<html>error! status:${response.statusCode}</html>';
    }

    Document document = parse(result);
    // 这里使用 css 选择器语法提取数据
    List<Element> elements = document
        .querySelectorAll('.main > .main-content > .postlist > #pins > li');
    List<GirlBean> data = [];

    if (elements.isNotEmpty) {
      data = List.generate(elements.length, (i) {
        GirlBean bean = GirlBean();
        // 获取图片信息
        Element image = elements[i].querySelector('.lazy');
        bean.cover = image.attributes['data-original'];
        bean.width = int.parse(image.attributes['width']);
        bean.width = int.parse(image.attributes['height']);

        // 标题及跳转
        Element a = elements[i].querySelector('span > a');
        bean.title = a.text;
        bean.jumpUrl = a.attributes['href'];

        // 时间
        Element time = elements[i].querySelector('.time');
        bean.time = time.text;

        return bean;
      });
    }
    return data;
  }

  ///
  /// 获取详情
  ///
  static Future loadGirlDetail(String detailUrl) async {
    // <div class="main">
    //   <div class="content">
    //     <h2 class="main-title">水电费</h2>
    //     <div class="main-meta">
    //       <span>分类：
    //         <a href="https://www.mzitu.com/xinggan/" rel="category tag">性感妹子</a>
    //       </span>
    //       <span>发布于 2020-01-12 22:29</span>
    //     </div>
    //     <div class="main-image">
    //       <p>
    //         <a href="https://www.mzitu.com/219871/2">
    //           <img src="https://i5.mmzztt.com/2020/01/12c01.jpg" alt="水电费" width="728" height="485" />
    //         </a>
    //       </p>
    //     </div>
    //   </div>
    // </div>
    var response = await http.get(detailUrl);
    var result;
    if (response.statusCode == 200) {
      result = response.data;
    } else {
      result = '';
    }

    Document document = parse(result);
    // 这里使用 css 选择器语法提取数据
    List<Element> elements =
        document.querySelectorAll('.main > .content > .postlist > #pins > li');
    GirlBean bean;

    if (elements.isNotEmpty) {
      data = List.generate(elements.length, (i) {
        GirlBean bean = GirlBean();
        // 获取图片信息
        Element image = elements[i].querySelector('.lazy');
        bean.cover = image.attributes['data-original'];
        bean.width = int.parse(image.attributes['width']);
        bean.width = int.parse(image.attributes['height']);

        // 标题及跳转
        Element a = elements[i].querySelector('span > a');
        bean.title = a.text;
        bean.jumpUrl = a.attributes['href'];

        // 时间
        Element time = elements[i].querySelector('.time');
        bean.time = time.text;

        return bean;
      });
    }
    return data;

    int start = result.indexOf('[[{');
    int end = result.indexOf('}]]');
    result = result.substring(start, end) + "}]]";
    List jsonList = json.decode(result);
    List<GirlBean> data = [];
    // 解析嵌套数据
    for (int i = 0; i < jsonList.length; i++) {
      List list = jsonList[i];
      for (int j = 0; j < list.length; j++) {
        data.add(GirlBean.fromJson(list[j]));
      }
    }
    return data;
  }

  ///
  /// 统一加载数据方法
  ///
  static Future loadData(String url) async {
    var response = await http.get(url);
    var result;
    if (response.statusCode == 200) {
      result = response.data;
    } else {
      result = '<html>error! status:${response.statusCode}</html>';
    }

    Document document = parse(result);
    // 这里使用 css 选择器语法提取数据
    List<Element> elements =
        document.querySelectorAll('.main-body > .item-box > .item-list > a');
    List<GirlBean> data = [];
    if (elements.isNotEmpty) {
      data = List.generate(elements.length, (i) {
        GirlBean entity = GirlBean();
        entity.jumpUrl = elements[i].attributes['href'];

        Element image = elements[i].querySelector('.img-wrap>.img-inner>img');
        entity.title = image.attributes['alt'];
        entity.imgUrl = image.attributes['data-original'];

        Element tips = elements[i].querySelector('.img-wrap>.img-inner>.tips');
        entity.count = tips.text;
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
    result = result.substring(start, end) + "}]]";
    List jsonList = json.decode(result);
    List<GirlBean> data = [];
    // 解析嵌套数据
    for (int i = 0; i < jsonList.length; i++) {
      List list = jsonList[i];
      for (int j = 0; j < list.length; j++) {
        data.add(GirlBean.fromJson(list[j]));
      }
    }
    return data;
  }
}
