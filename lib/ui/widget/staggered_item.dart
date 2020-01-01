import 'package:flutter/material.dart';
import 'package:vf_girls/common/index.dart';
import 'package:vf_girls/request/bean/girl.dart';

import 'package:vf_plugin/vf_plugin.dart';

///
/// 瀑布流 Item
///
class StaggeredItem extends StatelessWidget {
  final GirlEntity girl;
  final VoidCallback callback;

  const StaggeredItem({
    Key key,
    this.girl,
    this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        // 图片
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(VFDimens.border_radius_normal),
          image: DecorationImage(
            image: NetworkImage(
              girl != null && girl.imgUrl != null ? girl.imgUrl : '',
            ),
            fit: BoxFit.cover,
          ), //设置图片的填充模式
        ),
        // 顶部布局
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              // 顶部阴影
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    VFColors.black12,
                    VFColors.grey12,
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(VFDimens.border_radius_normal),
                  topRight: Radius.circular(VFDimens.border_radius_normal),
                ),
              ),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // 收藏图标
                    Padding(
                      padding: EdgeInsets.all(VFDimens.padding_small),
                      child: Icon(
                        VFIcons.ic_like_fill,
                        size: VFSizes.title,
                        color: Colors.white,
                      ),
                    ),
                    // 图片张数
                    Container(
                      margin: EdgeInsets.all(VFDimens.margin_small),
                      decoration: BoxDecoration(
                        color: VFColors.black38,
                        borderRadius: BorderRadius.all(
                          Radius.circular(VFDimens.border_radius_large),
                        ),
                      ),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(
                          VFDimens.padding_small,
                          VFDimens.padding_little,
                          VFDimens.padding_small,
                          VFDimens.padding_little,
                        ),
                        child: Text(
                          girl.count,
                          style: TextStyle(
                            color: VFColors.white87,
                            fontSize: VFSizes.s_10,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              // 底部阴影
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    VFColors.black38,
                    VFColors.grey38,
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(VFDimens.border_radius_normal),
                  bottomRight: Radius.circular(VFDimens.border_radius_normal),
                ),
              ),
              // 描述
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.all(VFDimens.margin_small),
                child: Text(
                  girl.title != null ? girl.title : '',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: VFSizes.s_14,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
