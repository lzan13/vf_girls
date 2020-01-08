import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import 'package:vf_plugin/vf_plugin.dart';

import 'package:vf_girls/request/bean/girl.dart';
import 'package:vf_girls/common/index.dart';

///
/// 多图预览界面
///
class DisplayMultiPage extends StatefulWidget {
  // 参数集合，因为当前页需要参数比较多，路由直接透传
  Map<String, dynamic> params;

  List<GirlEntity> dataList;
  int index = 0;
  String heroTag;
  PageController controller;

  DisplayMultiPage(this.params) : super() {
    dataList = params['data'];
    index = params['index'];
    heroTag = params['hero_tag'];
    controller = PageController(initialPage: index);
  }

  @override
  DisplayMultiPageState createState() => DisplayMultiPageState();
}

class DisplayMultiPageState extends State<DisplayMultiPage> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: VFColors.black,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              bottom: 0,
              right: 0,
              child: Container(
                  child: PhotoViewGallery.builder(
                scrollPhysics: const BouncingScrollPhysics(),
                builder: (BuildContext context, int index) {
                  return PhotoViewGalleryPageOptions(
                    imageProvider: NetworkImage(widget.dataList[index].imgUrl),
                    // heroAttributes: PhotoViewHeroAttributes(
                    //   tag: 'display_picture',
                    // ),
                  );
                },
                itemCount: widget.dataList.length,
                loadingChild: VFProgress(),
                pageController: widget.controller,
                enableRotation: true,
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
              )),
            ),
            Positioned(
              left: 0.0,
              top: 0.0,
              right: 0.0,
              child: VFTopBar(
                bgColor: VFColors.translucent,
                top: MediaQuery.of(context).padding.top,
                title: "${currentIndex + 1}/${widget.dataList.length}",
                titleColor: VFColors.white,
                leftIcon: VFIcons.ic_arrow_left,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
