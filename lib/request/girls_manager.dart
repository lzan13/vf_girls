import 'package:html/dom.dart';
import 'package:html/parser.dart' show parse;
import 'package:vf_girls/request/bean/daily_bean.dart';

import 'package:vf_girls/request/bean/category_bean.dart';
import 'package:vf_girls/request/bean/girl_bean.dart';
import 'package:vf_girls/request/girls_api.dart';

class GirlsManager {
  ///
  /// 加载瀑布流数据
  ///
  static Future loadFalls(String url) async {
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
    Document document = await _loadData(url);
    // 这里使用 css 选择器语法提取数据
    List<Element> elements =
        document.querySelectorAll('.main>.main-content>.postlist>#pins>li');
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
        Element a = elements[i].querySelector('span>a');
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
  static Future loadDetail(String url) async {
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
    Document document = await _loadData(url);
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
      if (index < 10) {
        return '${imgPrefix}0$index$imgSuffix';
      } else {
        return '$imgPrefix$index$imgSuffix';
      }
    });
    return girl;
  }

  ///
  /// 加载日常更新数据
  ///
  static Future loadDaily(url) async {
    // <div class="main">
    //   <div class="main-content">
    //     <div class="postlist">
    //       <div id="comments">
    //         <ul>
    //           <li class="comment byuser comment-author-abu bypostauthor even thread-even depth-1" id="comment-10685">
    //             <div id="div-comment-10685" class="comment-body">
    //               <p>
    //                 <img class="lazy" data-original="https://wxt.sinaimg.cn/mw1024/9d52c073gy1gau5acibp8j20m80rrdht.jpg" width="640" height="auto" />
    //               </p>
    //             </div>
    //           </li>
    //         </ul>
    //       </div>
    //     </div>
    //   </div>
    // </div>
    Document document = await _loadData(url);
    DailyBean data = new DailyBean();

    // 图片集合
    List<Element> imgElements = document.querySelectorAll(
        '.main>.main-content>.postlist>#comments>ul>li>.comment-body');
    if (imgElements.isNotEmpty) {
      data.images = List.generate(imgElements.length, (i) {
        return imgElements[i]
            .querySelector('p>.lazy')
            .attributes['data-original'];
      });
    }
    // 排行榜
    List<Element> topElements =
        document.querySelectorAll('.main>.sidebar>.widgets_top>a');
    if (topElements.isNotEmpty) {
      data.topGirls = List.generate(topElements.length, (i) {
        GirlBean bean = new GirlBean();
        Element element = topElements[i];
        bean.jumpUrl = element.attributes['href'];
        bean.title = element.querySelector('img').attributes['alt'];
        bean.cover = element.querySelector('img').attributes['src'];
        bean.width =
            int.parse(element.querySelector('img').attributes['width']);
        bean.height =
            int.parse(element.querySelector('img').attributes['height']);
        return bean;
      });
    }

    // 下一页
    data.next = document
        .querySelector(
            '.main>.main-content>.postlist>#comments>.pagenavi-cm>.prev')
        .attributes['href'];
    return data;
  }

  ///
  /// 加载专题数据
  ///
  static Future loadSubject(String url) async {
    // <div class="main">
    //   <div class="main-content">
    //     <div class="postlist">
    //       <dl class="tags">
    //         <dt>标签</dt>
    //         <dd>
    //           <a href="https://www.mzitu.com/tag/xinggan/" target="_blank">
    //             <img class="lazy" src="https://www.mzitu.com/static/pc/img/lazy.png" data-original="https://wxt.sinaimg.cn/mw690/9d52c073gy1frm1sklskij205y05yglw.jpg" alt="性感美女专题" />性感美女</a>
    //           <i>共4347套图</i>
    //         </dd>
    //       </dl>
    //     </div>
    //   </div>
    // </div>
    Document document = await _loadData(url);
    // 这里使用 css 选择器语法提取数据
    List<Element> elements =
        document.querySelectorAll('.main>.main-content>.postlist>.tags>dd');
    List<CategoryBean> data = [];

    if (elements.isNotEmpty) {
      data = List.generate(elements.length, (i) {
        CategoryBean bean = CategoryBean();
        // 标题描述
        bean.title = elements[i].querySelector('a').text;
        bean.desc = elements[i].querySelector('i').text;
        // 封面信息
        bean.cover =
            elements[i].querySelector('.lazy').attributes['data-original'];
        bean.url = elements[i].querySelector('a').attributes['href'];
        return bean;
      });
    }
    return data;
  }

  ///
  /// 统一处理请求
  ///
  static Future _loadData(url) async {
    var response = await http.get(url);
    var result;
    if (response.statusCode == 200) {
      result = response.data;
    } else {
      result =
          '{"code":${response.statusCode}, "msg":"${response.statusMessage}"}';
    }
    return parse(result);
  }
}
