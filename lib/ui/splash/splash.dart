import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

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
  AnimationController _logoController;
  Animation<double> _animation;
  AnimationController _countdownController;

  @override
  void initState() {
    _logoController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));

    _animation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(curve: Curves.easeInOutBack, parent: _logoController));

    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _logoController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _logoController.forward();
      }
    });
    _logoController.forward();

    _countdownController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _countdownController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _logoController.dispose();
    _countdownController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () => Future.value(false),
        child: Stack(fit: StackFit.expand, children: <Widget>[
          Image.asset(RESHelper.wrapImage('splash_bg.png'),
              colorBlendMode: BlendMode
                  .srcOver, //colorBlendMode方式在android等机器上有些延迟,导致有些闪屏,故采用两套图片的方式
              color: Colors.black.withOpacity(
                  Theme.of(context).brightness == Brightness.light ? 0 : 0.65),
              fit: BoxFit.fill),
          AnimatedFlutterLogo(
            animation: _animation,
          ),
          Align(
            alignment: Alignment(0.0, 0.7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                AnimatedAndroidLogo(
                  animation: _animation,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: SafeArea(
              child: InkWell(
                onTap: () {
                  Router.toAppTab(context);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  margin: EdgeInsets.only(right: 20, bottom: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.black.withAlpha(100),
                  ),
                  child: AnimatedCountdown(
                    context: context,
                    animation: StepTween(begin: 3, end: 0)
                        .animate(_countdownController),
                  ),
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}

class AnimatedCountdown extends AnimatedWidget {
  final Animation<int> animation;

  AnimatedCountdown({key, this.animation, context})
      : super(key: key, listenable: animation) {
    this.animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Router.toAppTab(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var value = animation.value + 1;
    return Text(
      (value == 0 ? '' : '$value | ') + FlutterI18n.translate(context, "skip"),
      style: TextStyle(color: Colors.white),
    );
  }
}

class AnimatedFlutterLogo extends AnimatedWidget {
  AnimatedFlutterLogo({
    Key key,
    Animation<double> animation,
  }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return AnimatedAlign(
      duration: Duration(milliseconds: 10),
      alignment: Alignment(0, 0.2 + animation.value * 0.3),
      curve: Curves.bounceOut,
      child: Image.asset(
        RESHelper.wrapImage('splash_flutter.png'),
        width: 280,
        height: 120,
      ),
    );
  }
}

class AnimatedAndroidLogo extends AnimatedWidget {
  AnimatedAndroidLogo({
    Key key,
    Animation<double> animation,
  }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Image.asset(
          RESHelper.wrapImage('splash_fun.png'),
          width: 140 * animation.value,
          height: 80 * animation.value,
        ),
        Image.asset(
          RESHelper.wrapImage('splash_android.png'),
          width: 200 * (1 - animation.value),
          height: 80 * (1 - animation.value),
        ),
      ],
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
