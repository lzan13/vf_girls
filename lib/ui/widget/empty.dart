import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:vf_girls/common/index.dart';

import 'package:vf_plugin/vf_plugin.dart';

///
/// 空内容 Widget
///
class EmptyPage extends StatefulWidget {
  @override
  EmptyPageState createState() {
    return EmptyPageState();
  }
}

class EmptyPageState extends State<EmptyPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Column(
          children: <Widget>[
            // 图片
            Container(
              margin: EdgeInsets.all(VFDimens.margin_small),
              child: Image.asset(
                RESHelper.wrapImage('empty.png'),
                width: VFDimens.d_96,
                height: VFDimens.d_96,
                fit: BoxFit.cover,
              ),
            ),
            // 文字
            Container(
              child: Text(
                FlutterI18n.translate(context, 'no_data'),
                style: TextStyle(
                  color: Color(0xFF999999),
                  fontSize: VFSizes.s_14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
