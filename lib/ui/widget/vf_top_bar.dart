import 'package:flutter/material.dart';

import 'package:vf_library/common/vf_colors.dart';
import 'package:vf_library/common/vf_dimens.dart';

class VFTopBar extends StatefulWidget {
  double height;
  double top;
  String title;
  double titleSize;
  Color titleColor;
  bool centerTitle;
  IconData leftIcon;
  Widget leftWidget;
  IconData rightIcon;

  VFTopBar({
    Key key,
    this.height: VFDimens.bar_normal,
    this.top,
    this.title,
    this.titleSize: VFSizes.title,
    this.titleColor: VFColors.greyBlack,
    this.centerTitle: false,
    this.leftIcon,
    this.leftWidget,
    this.rightIcon,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return VFTopBarState();
  }
}

/**
 * 自定义标题栏
 */
class VFTopBarState extends State<VFTopBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: widget.top),
      height: widget.height + widget.top,
      child: Row(children: <Widget>[
        widget.leftIcon != null
            ? Container(
                child: SizedBox(
                  height: widget.height,
                  width: widget.height,
                  child: Icon(
                    widget.leftIcon,
                    size: VFDimens.d_24,
                    color: widget.titleColor,
                  ),
                ),
              )
            : Container(
                width: VFDimens.margin_normal,
              ),
        widget.leftWidget != null ? widget.leftWidget : Container(),
        Center(
          child: Text(
            widget.title,
            style: TextStyle(
              color: widget.titleColor,
              fontWeight: FontWeight.w500,
              fontSize: widget.titleSize,
            ),
          ),
        ),
        widget.rightIcon != null
            ? Container(
                child: SizedBox(
                  height: widget.height,
                  width: widget.height,
                  child: Icon(
                    widget.rightIcon,
                    size: VFDimens.d_24,
                    color: widget.titleColor,
                  ),
                ),
              )
            : Container(
                width: VFDimens.margin_normal,
              ),
      ]),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [const Color(0xFF3366FF), const Color(0xFF00CCFF)],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
    );
  }
}
