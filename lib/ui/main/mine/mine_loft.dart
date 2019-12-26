import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:vf_girls/common/index.dart';

class MineLoftOuter extends StatelessWidget {
  final Widget child;

  MineLoftOuter(this.child);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180 + MediaQuery.of(context).padding.top + 20,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(RESHelper.wrapImage('img_loft_bg.png')),
          fit: BoxFit.fill,
        ),
      ),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Text('慢慢来，一步一个脚印 👣',
                style: Theme.of(context).textTheme.overline.copyWith(
                      color: Colors.white,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    )),
          ),
          Align(alignment: Alignment(0, 0.85), child: child),
        ],
      ),
      alignment: Alignment.bottomCenter,
    );
  }
}

/**
 * 我的阁楼界面
 */
class MineLoft extends StatefulWidget {
  @override
  MineLoftState createState() => MineLoftState();
}

class MineLoftState extends State<MineLoft> {
  ValueNotifier<bool> notifier = ValueNotifier(false);

  @override
  void dispose() {
    notifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: 'homeFab',
        child: Icon(Icons.arrow_drop_down),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      body: Stack(children: <Widget>[
        Positioned(
          top: -MediaQuery.of(context).padding.top,
          bottom: 0,
          left: 0,
          right: 0,
          child: WebView(
            // 初始化加载的url
            initialUrl: 'https://blog.melove.net',
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController controller) {},
            onPageFinished: (String value) {
              notifier.value = true;
            },
          ),
        ),
        Container(),
        ValueListenableBuilder(
            valueListenable: notifier,
            builder: (context, value, child) => value
                ? SizedBox.shrink()
                : Center(
                    child: CircularProgressIndicator(),
                  ))
      ]),
    );
  }
}
