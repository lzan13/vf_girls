import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'package:vf_plugin/vf_plugin.dart';

import 'package:vf_girls/common/index.dart';
import 'package:vf_girls/router/router_manger.dart';

///
/// 闪屏启动界面
///
class Splash extends StatefulWidget {
  @override
  SplashState createState() => SplashState();
}

class SplashState extends State<Splash> with TickerProviderStateMixin {
  // 动画时间 单位 秒
  int animTime = 5;
  // 封面背景动画
  Animation<double> coverAnimation;
  AnimationController coverController;

  // 跳过按钮动画
  Animation<int> skipAnimation;
  AnimationController skipController;

  @override
  void initState() {
    super.initState();
    coverController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: animTime * 1000),
    );
    // 创建动画
    coverAnimation = Tween(begin: 1.0, end: 0.0).animate(
        CurvedAnimation(curve: Curves.easeInOutBack, parent: coverController));
    // 开始动画
    coverController.forward();

    // 跳过按钮动画
    skipController = AnimationController(
      vsync: this,
      duration: Duration(seconds: animTime),
    );
    skipAnimation = StepTween(begin: animTime, end: 0).animate(skipController);
    // 动画监听
    skipAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Router.toAppTab(context);
      }
    });
    // 开始动画
    skipController.forward();
  }

  @override
  void dispose() {
    coverController.dispose();
    skipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () => Future.value(false),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            //colorBlendMode 方式在 android 机器上有些延迟,导致有些闪屏,故采用两套图片的方式
            Image.asset(RESHelper.wrapImage('img_girl.jpg'),
                colorBlendMode: BlendMode.srcOver,
                color: Colors.black.withOpacity(
                    Theme.of(context).brightness == Brightness.light
                        ? 0
                        : 0.65),
                fit: BoxFit.cover),
            // 模糊
            BlurCoverWidget(animation: coverAnimation),
            Positioned(
              left: 0,
              bottom: 0,
              right: 0,
              child: Container(
                color: VFColors.white,
                padding: EdgeInsets.all(VFDimens.d_16),
                height: VFDimens.d_48 + VFDimens.d_32,
                child: Stack(
                  alignment: AlignmentDirectional.centerEnd,
                  fit: StackFit.expand,
                  children: <Widget>[
                    Image.asset(
                      RESHelper.wrapImage('img_logo.png'),
                    ),
                    Positioned(
                      right: 0,
                      child: InkWell(
                        onTap: () {
                          Router.toAppTab(context);
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(
                            Radius.circular(VFDimens.border_radius_normal),
                          ),
                          child: Container(
                            color: VFColors.black38,
                            padding: EdgeInsets.all(VFDimens.d_8),
                            child: SkipWidget(animation: skipAnimation),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

///
/// 倒计时
///
class SkipWidget extends AnimatedWidget {
  // 动画
  final Animation<int> animation;
  SkipWidget({key, this.animation}) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    var value = animation.value + 1;
    return Text(
      FlutterI18n.translate(context, "skip") + (value == 0 ? '' : ' $value'),
      style: TextStyle(
        color: Colors.white,
        fontSize: VFSizes.s_14,
      ),
    );
  }
}

///
/// 模糊背景
///
class BlurCoverWidget extends AnimatedWidget {
  // 动画
  final Animation<double> animation;
  BlurCoverWidget({key, this.animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: animation.value * 10,
          sigmaY: animation.value * 10,
        ),
        child: Container(
          color: VFColors.white.withOpacity(0.1),
        ),
      ),
    );
  }
}

class GuidePage extends StatefulWidget {
  static const List<String> images = <String>[
    'guide_page_1.png',
    'guide_page_2.png',
    'guide_page_3.png',
    'guide_page_4.png'
  ];

  @override
  _GuidePageState createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage> {
  int curIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Theme.of(context).primaryColor,
      child: Stack(
        alignment: Alignment(0, 0.87),
        children: <Widget>[
          Swiper(
              itemBuilder: (ctx, index) => Image.asset(
                    'assets/images/${GuidePage.images[index]}',
                    fit: BoxFit.fill,
                  ),
              itemCount: GuidePage.images.length,
              loop: false,
              onIndexChanged: (index) {
                setState(() {
                  curIndex = index;
                });
              }),
          Offstage(
            offstage: curIndex != GuidePage.images.length - 1,
            child: CupertinoButton(
              color: Theme.of(context).primaryColorDark,
              child: Text('点我开始'),
              onPressed: () {
                Router.toAppTab(context);
              },
            ),
          )
        ],
      ),
    ));
  }
}
