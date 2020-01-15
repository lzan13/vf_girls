import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/ball_pulse_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import 'package:vf_plugin/vf_plugin.dart';

import 'package:vf_girls/request/girls_manager.dart';
import 'package:vf_girls/request/bean/category_bean.dart';
import 'package:vf_girls/router/router_manger.dart';

///
/// 标签分类页面
///
class SubjectPage extends StatefulWidget {
  @override
  SubjectPageState createState() => SubjectPageState();
}

class SubjectPageState extends State<SubjectPage>
    with AutomaticKeepAliveClientMixin {
  // 加载数据
  List<CategoryBean> dataList = [];

  @override
  void initState() {
    super.initState();
    VFLog.d('SubjectPage initState');
  }

  ///
  /// 加载数据
  ///
  void loadData() async {
    List<CategoryBean> result =
        await GirlsManager.loadSubject('https://www.mzitu.com/zhuanti/');
    setState(() {
      dataList.clear();
      dataList.addAll(result);
    });
  }

  ///
  /// 绑定图片网格数据
  ///
  Widget bindGrid() {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(
        VFDimens.d_16,
        VFDimens.d_8,
        VFDimens.d_16,
        VFDimens.d_8,
      ),
      sliver: new SliverGrid(
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, //Grid按两列显示
          mainAxisSpacing: VFDimens.d_4,
          crossAxisSpacing: VFDimens.d_4,
          childAspectRatio: 1.0,
        ),
        delegate: new SliverChildBuilderDelegate(
          (context, index) {
            CategoryBean bean = dataList[index];
            return GestureDetector(
              child: Stack(
                alignment: Alignment.center,
                fit: StackFit.expand,
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 1.0,
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(VFDimens.border_radius_small),
                      child: CachedNetworkImage(
                        httpHeaders: {
                          'Referer': bean.cover,
                        },
                        fit: BoxFit.cover,
                        imageUrl: bean.cover,
                        placeholder: (context, url) => Padding(
                          padding: EdgeInsets.all(VFDimens.d_12),
                          child: VFLoading(),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0.0,
                    right: 0.0,
                    bottom: 0.0,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: VFDimens.d_16),
                      child: Column(
                        children: <Widget>[
                          Text(
                            bean.title,
                            style: TextStyle(
                              color: VFColors.white87,
                              fontWeight: FontWeight.bold,
                              fontSize: VFSizes.s_14,
                              shadows: [
                                Shadow(
                                  color: VFColors.black,
                                  offset: Offset(0, 1),
                                  blurRadius: VFDimens.d_16,
                                )
                              ],
                            ),
                          ),
                          Text(
                            bean.desc,
                            style: TextStyle(
                              color: VFColors.white87,
                              fontWeight: FontWeight.bold,
                              fontSize: VFSizes.s_14,
                              shadows: [
                                Shadow(
                                  color: VFColors.black,
                                  offset: Offset(0, 1),
                                  blurRadius: VFDimens.d_16,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              onTap: () => Router.toCategory(context, bean),
            );
          },
          childCount: dataList.length,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: VFTopBar(
        bgColor: VFColors.transparent,
        top: MediaQuery.of(context).padding.top,
        title: FlutterI18n.translate(context, 'tab_subject'),
        titleColor: Theme.of(context).textTheme.title.color,
      ),
      body: EasyRefresh.custom(
        firstRefresh: true,
        firstRefreshWidget: VFDialogLoading(),
        header: BallPulseHeader(color: Theme.of(context).accentColor),
        onRefresh: () async {
          await loadData();
        },
        onLoad: null,
        slivers: <Widget>[
          // 网格数据
          bindGrid(),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
