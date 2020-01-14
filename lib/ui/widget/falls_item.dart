import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:vf_plugin/vf_plugin.dart';

import 'package:vf_girls/common/index.dart';
import 'package:vf_girls/request/bean/girl_bean.dart';

///
/// 瀑布流布局 Widget
///
class FallsItem extends StatelessWidget {
  final GirlBean bean;
  final VoidCallback callback;

  const FallsItem({
    Key key,
    this.bean,
    this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return bean != null && bean.cover != null
        ? GestureDetector(
            onTap: callback,
            child: Container(
              padding: EdgeInsets.only(top: VFDimens.d_4),
              child: Stack(
                alignment: Alignment.center,
                fit: StackFit.expand,
                children: <Widget>[
                  ClipRRect(
                    borderRadius:
                        BorderRadius.circular(VFDimens.border_radius_normal),
                    child: Hero(
                      tag: bean.cover + 'cover',
                      child: CachedNetworkImage(
                        httpHeaders: {'Referer': bean.cover},
                        fit: BoxFit.cover,
                        imageUrl: bean.cover,
                        placeholder: (context, url) => Padding(
                          padding: EdgeInsets.all(VFDimens.d_20),
                          child: VFLoading(type: VFLoadingType.threeBounce),
                        ),
                      ),
                    ),
                  ),
                  // 模糊
                  // BackdropFilter(
                  //   filter: new ImageFilter.blur(sigmaX: 2, sigmaY: 3),
                  //   child: new Container(
                  //     color: VFColors.white.withOpacity(0.1),
                  //   ),
                  // ),
                  Positioned(
                    left: 0.0,
                    top: 0.0,
                    right: 0.0,
                    child: Container(
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
                          topLeft:
                              Radius.circular(VFDimens.border_radius_normal),
                          topRight:
                              Radius.circular(VFDimens.border_radius_normal),
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
                                  bean.time,
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
                  ),
                  Positioned(
                    left: 0.0,
                    right: 0.0,
                    bottom: 0.0,
                    child: Container(
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
                          bottomLeft:
                              Radius.circular(VFDimens.border_radius_normal),
                          bottomRight:
                              Radius.circular(VFDimens.border_radius_normal),
                        ),
                      ),
                      // 描述
                      child: Container(
                        width: double.infinity,
                        margin: EdgeInsets.all(VFDimens.margin_small),
                        child: Text(
                          bean.title != null ? bean.title : '',
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
                  ),
                ],
              ),
            ),
          )
        : Container(
            child: Image.asset(RESHelper.wrapImage('img_default.png')),
          );
  }
}
