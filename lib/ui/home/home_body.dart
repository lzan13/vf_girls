import 'package:flutter/material.dart';
import '../../common/vm_toast.dart';

class HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              RaisedButton(
                child: Text("Normal Toast"),
                onPressed: () {
                  FToast.show("普通 Toast");
                },
              ),
              RaisedButton(
                child: Text("Error Toast"),
                onPressed: () {
                  FToast.error(
                      "错误 Toast 并且自动换行水电费违法塑料袋附件为of建瓯市就分手了放假我饿if建瓯市金佛山经发委所肩负的是老的福建师范深粉色并且自动换行水电费违法塑料袋附件为of建瓯市就分手了");
                },
              ),
              RaisedButton(
                child: Text("Success Toast"),
                onPressed: () {
                  FToast.success("完成 Toast");
                },
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(16),
                margin: EdgeInsets.all(16),
                child: Center(
                  child: Text(
                    "分类 1",
                    style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        fontSize: 20.0),
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular((16.0)),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0x54363636),
                        offset: Offset(0.0, 4.0),
                        blurRadius: 15.0,
                        spreadRadius: 2.0),
                  ],
                  gradient: LinearGradient(
                      colors: [
                        const Color(0xFF3366FF),
                        const Color(0xFF00CCFF)
                      ],
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(1.0, 1.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                margin: EdgeInsets.all(16),
                //对齐方式 居中 居左 居上.....
                alignment: Alignment.center,
                //图形变换对这个控件 进行旋转 位移...
//            transform: Matrix4.rotationZ(0.1),
                child: Center(
                  child: Text(
                    //文字展示
                    'Text 使用',
                    //最大行数
                    maxLines: 1,
                    // 设置成false 超出显示区域的文字不会在现实 只显示一行文字
                    softWrap: true,
                    //文字对齐方式
                    textAlign: TextAlign.center,
                    //显示方式 下面这个显示不了的字 后面会加上...
                    overflow: TextOverflow.ellipsis,
                    //文字样式
                    style: TextStyle(
                      //字体颜色
                      color: Colors.white,
                      //加粗
                      fontWeight: FontWeight.bold,
                      //字体大小
                      fontSize: 20,
                      //字体样式 斜体 直体
                      fontStyle: FontStyle.normal,
                      //字符间距
                      letterSpacing: 2,
                      //基线对齐
                      textBaseline: TextBaseline.ideographic,
                      //单词间距
                      wordSpacing: 4,
                      //上划线 下划线 中划线
//                    decoration: TextDecoration.lineThrough,
                      //线条样式 虚线 直线
//                    decorationStyle: TextDecorationStyle.dashed,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular((16.0)),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0x54363636),
                        offset: Offset(0.0, 4.0),
                        blurRadius: 15.0,
                        spreadRadius: 2.0),
                  ],
                  gradient: LinearGradient(
                      colors: [
                        const Color(0xFF3366FF),
                        const Color(0xFF00CCFF)
                      ],
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(1.0, 1.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.mirror),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
