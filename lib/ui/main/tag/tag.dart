import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:vf_plugin/vf_plugin.dart';

import 'package:vf_girls/common/json_manager.dart';
import 'package:vf_girls/request/bean/category_bean.dart';
import 'package:vf_girls/ui/widget/custom_tab.dart';
import 'package:vf_girls/ui/widget/falls_list.dart';

///
/// 标签分类页面
///
class TagPage extends StatefulWidget {
  @override
  TagPageState createState() => TagPageState();
}

class TagPageState extends State<TagPage> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(child: Text(FlutterI18n.translate(context, 'tab_tag')));
  }

  @override
  bool get wantKeepAlive => true;
}
