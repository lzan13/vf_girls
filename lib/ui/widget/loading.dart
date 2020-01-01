import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import 'package:vf_plugin/vf_plugin.dart';

///
/// Loading Widget
///
class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: SizedBox(
          height: VFDimens.d_220,
          width: VFDimens.d_320,
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: VFDimens.d_56,
                  height: VFDimens.d_56,
                  child: Text(FlutterI18n.translate(context, 'loading')),
                ),
                Container(
                  child: Text(
                    FlutterI18n.translate(context, "loading"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
