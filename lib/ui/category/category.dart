import 'package:flutter/material.dart';
import 'package:vf_plugin/vf_plugin.dart';

import 'package:vf_girls/common/index.dart';
import 'package:vf_girls/request/bean/category_bean.dart';
import 'package:vf_girls/ui/common/falls_body.dart';

///
/// 分类页面
///
class CategoryPage extends StatefulWidget {
  final CategoryBean category;

  CategoryPage(this.category);

  @override
  CategoryPageState createState() => CategoryPageState();
}

class CategoryPageState extends State<CategoryPage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: VFTopBar(
        top: MediaQuery.of(context).padding.top,
        title: widget.category.title,
        titleColor: VFColors.white,
        leftIcon: VFIcons.ic_arrow_left,
      ),
      body: FallsBody(widget.category),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
