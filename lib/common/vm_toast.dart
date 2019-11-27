import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

/*
 * 自定义 Flutter Toast 工具类
 */
class FToast {
  /*
   * 显示普通的 Toast
   */
  static void show(String msg) {
    showToastWidget(
      FTContent(
        content: msg,
        radius: 8.0,
      ),
      position: ToastPosition.bottom,
      duration: Duration(milliseconds: 3000),
      textDirection: TextDirection.ltr,
    );
  }

  /*
   * 显示错误 Toast
   */
  static void error(String msg) {
    showToastWidget(
      FTContent(
        content: msg,
        hideIcon: false,
        icon: Icons.close,
        bgColor: Color(0xdddd3636),
        radius: 6.0,
      ),
      position: ToastPosition.bottom,
      duration: Duration(milliseconds: 3000),
      textDirection: TextDirection.ltr,
    );
  }

  /*
   * 显示成功 Toast
   */
  static void success(String msg) {
    showToastWidget(
      FTContent(
        content: msg,
        hideIcon: false,
        icon: Icons.done,
        bgColor: Color(0xdd22aa22),
        radius: 6.0,
      ),
      position: ToastPosition.bottom,
      duration: Duration(milliseconds: 3000),
      textDirection: TextDirection.ltr,
    );
  }
}

/*
 * 弹出 Toast 自定义布局内容
 */
class FTContent extends StatelessWidget {
  String content;
  bool hideIcon;
  IconData icon;
  Color bgColor;
  double radius;

  FTContent({
    Key key,
    this.content,
    this.hideIcon = true,
    this.icon = Icons.insert_emoticon,
    Color bgColor,
    this.radius = 4.0,
  })  : this.bgColor = bgColor ?? const Color(0xdd363636),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
              color: Color(0x54363636),
              offset: Offset(0.0, 5.0),
              blurRadius: 20.0,
              spreadRadius: 1.0),
        ],
        color: bgColor,
      ),
      padding: const EdgeInsets.only(left: 4.0, right: 4.0),
      margin: const EdgeInsets.all(24.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Offstage(
            offstage: hideIcon,
            child: Container(
              margin: const EdgeInsets.only(left: 8.0),
              child: Icon(
                icon,
                color: Colors.white,
              ),
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 12.0, 8.0, 12.0),
              child: Text(
                content,
                softWrap: true,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
