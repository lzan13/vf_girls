import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import 'package:vf_library/common/vf_colors.dart';
import 'package:vf_library/common/vf_toast.dart';
import 'package:vf_library/config/resource_manager.dart';
import 'package:vf_library/ui/widget/circular_icon.dart';
import 'package:vf_library/ui/widget/list_item.dart';

/**
 * 空视图页面
 */
class NotFoundPage extends StatefulWidget {
  String pageName;

  NotFoundPage(this.pageName);

  @override
  NotFoundPageState createState() {
    return NotFoundPageState();
  }
}

class NotFoundPageState extends State<NotFoundPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(FlutterI18n.translate(context, 'page_not_found')),
      ),
      body: EasyRefresh.custom(
        emptyWidget: Container(
          height: double.infinity,
          child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: SizedBox(),
                    flex: 2,
                  ),
//                  Image.asset(
//                    ResHelper.wrapImage('empty.png'),
//                    width: 120,
//                    height: 120,
//                  ),
                  Icon(
                    Icons.not_interested,
                    size: 96.0,
                    color: VFColors.grey54,
                  ),
                  Text(
                    '[${widget.pageName}] ' +
                        FlutterI18n.translate(context, 'page_not_found'),
                    style: TextStyle(fontSize: 16.0, color: Colors.grey),
                  ),
                  Expanded(
                    child: SizedBox(),
                    flex: 3,
                  ),
                ]),
          ),
        ),
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate([]),
          ),
        ],
      ),
    );
  }
}
