import 'package:html/dom.dart';
import 'package:html/parser.dart' show parse;

import 'package:vf_plugin/vf_plugin.dart';

import 'package:vf_girls/request/bean/category_bean.dart';
import 'package:vf_girls/request/bean/girl_bean.dart';
import 'package:vf_girls/request/girls_api.dart';

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
  static Future loadGirlDetail(String url) async {
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
    var response = await http.get(url);
    var result;
    if (response.statusCode == 200) {
      result = response.data;
    } else {
      result = '';
    }

    Document document = parse(result);
    // 这里使用 css 选择器语法提取数据
    GirlBean girl = new GirlBean();
    girl.category = new CategoryBean();

    // 标题
    girl.title = document.querySelector('.main>.content>.main-title').text;
    // 时间
    girl.time =
        document.querySelectorAll('.main>.content>.main-meta>span')[1].text;
    girl.time = girl.time.substring(girl.time.indexOf(' '));

    // 分类
    girl.category.title =
        document.querySelector('.main>.content>.main-meta>span>a').text;
    girl.category.url = document
        .querySelector('.main>.content>.main-meta>span>a')
        .attributes['href'];

    // 宽高
    girl.width = int.parse(document
        .querySelector('.main>.content>.main-image>p>a>img')
        .attributes['width']);
    girl.height = int.parse(document
        .querySelector('.main>.content>.main-image>p>a>img')
        .attributes['height']);
    girl.count = int.parse(
        document.querySelectorAll('.main>.content>.pagenavi>a>span')[4].text);

    // 解析图片地址
    String imgUrl = document
        .querySelector('.main>.content>.main-image>p>a>img')
        .attributes['src'];
    int end = imgUrl.lastIndexOf('.');
    String imgPrefix = imgUrl.substring(0, end - 2);
    String imgSuffix = imgUrl.substring(end);
    girl.images = List.generate(girl.count, (i) {
      int index = i + 1;
      if (i < 10) {
        return '${imgPrefix}0$index$imgSuffix';
      } else {
        return '$imgPrefix$index$imgSuffix';
      }
    });
    return girl;
  }
}
