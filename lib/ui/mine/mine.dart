import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';


class Mine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(FlutterI18n.translate(context, "tab_mine")),
      ),
    );
  }
}
