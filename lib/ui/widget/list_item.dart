import 'package:flutter/material.dart';

import 'package:vf_library/common/vf_colors.dart';
import 'package:vf_library/common/vf_dimens.dart';

/// 列表项
class ListItem extends StatefulWidget {
  // 点击事件
  final VoidCallback onPressed;

  // 图标
  final IconData icon;
  final Color iconColor;

  // 标题
  final String title;
  final Color titleColor;

  // 描述
  final String describe;
  final Color describeColor;

  // 右侧控件
  final Widget rightWidget;

  // 构造函数
  ListItem({
    Key key,
    this.onPressed,
    this.icon,
    this.iconColor: VFColors.grey,
    this.title,
    this.titleColor: VFColors.black,
    this.describe,
    this.describeColor: VFColors.grey,
    this.rightWidget,
  }) : super(key: key);

  @override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: widget.onPressed,
      padding: EdgeInsets.all(VFDimens.d_0),
      child: Container(
          height: VFDimens.list_item_normal,
          width: double.infinity,
          child: Row(
            children: <Widget>[
              widget.icon != null
                  ? Container(
                      child: SizedBox(
                        height: VFDimens.list_item_normal,
                        width: VFDimens.list_item_normal,
                        child: Icon(
                          widget.icon,
                          size: VFDimens.d_24,
                          color: widget.iconColor,
                        ),
                      ),
                    )
                  : Container(
                      width: VFDimens.margin_normal,
                    ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    widget.title != null
                        ? Text(
                            widget.title,
                            style: TextStyle(
                              color: widget.titleColor,
                              fontSize: VFSizes.list_item_title,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : Container(),
                    widget.describe != null
                        ? Text(
                            widget.describe,
                            maxLines: 2,
                            style: TextStyle(
                                color: widget.describeColor,
                                fontSize: VFSizes.list_item_desc),
                          )
                        : Container(),
                  ],
                ),
              ),
              widget.rightWidget == null ? Container() : widget.rightWidget,
              Container(
                width: VFDimens.margin_normal,
              ),
            ],
          )),
    );
  }
}

/// 空图标
class EmptyIcon extends Icon {
  const EmptyIcon() : super(Icons.hourglass_empty);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
