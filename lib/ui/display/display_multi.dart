import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import 'package:vf_plugin/vf_plugin.dart';

import 'package:vf_girls/common/index.dart';

///
/// 多图预览界面
///
class DisplayMultiPage extends StatefulWidget {
  // 参数集合，因为当前页需要参数比较多，路由直接透传
  Map<String, dynamic> params;

  List<String> imgList;
  int index = 0;
  PageController controller;

  DisplayMultiPage(this.params) : super() {
    imgList = params['data'];
    index = params['index'];
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
                  String image = widget.imgList[index];
                  return PhotoViewGalleryPageOptions(
                    imageProvider: CachedNetworkImageProvider(
                      image,
                      headers: {'Referer': image},
                    ),
                    heroAttributes: PhotoViewHeroAttributes(
                      tag: image,
                    ),
                  );
                },
                itemCount: widget.imgList.length,
                loadingChild: VFLoading(type: VFLoadingType.threeBounce),
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
                title: '${currentIndex + 1}/${widget.imgList.length}',
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
