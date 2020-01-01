import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:provider/provider.dart';

import 'package:vf_plugin/vf_plugin.dart';

import 'package:vf_girls/common/index.dart';
import 'package:vf_girls/router/router_manger.dart';
import 'package:vf_girls/ui/widget/bottom_clipper.dart';
import 'package:vf_girls/view_model/user_model.dart';

///
/// 我的 Tab 页面
///
class MinePage extends StatefulWidget {
  @override
  MinePageState createState() => MinePageState();
}

class MinePageState extends State<MinePage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: EasyRefresh.custom(slivers: <Widget>[
        SliverList(
          delegate: SliverChildListDelegate([
            MineHeaderWidget(),
            // 个人信息
            VFListItem(
              title: FlutterI18n.translate(context, 'info'),
//              describe: FlutterI18n.translate(context, 'settings'),
              onPressed: () {
                Router.toUser(context);
              },
              leftIcon: VFIcons.ic_mine,
            ),
            // 设置
            VFListItem(
              title: FlutterI18n.translate(context, "settings"),
//              describe: FlutterI18n.translate(context, 'settings'),
              onPressed: () {
                Router.toSettings(context);
              },
              leftIcon: VFIcons.ic_settings,
              rightIcon: VFIcons.ic_arrow_right,
            ),
          ]),
        ),
      ]),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class MineHeaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: BottomClipper(),
      child: Container(
        height: 200 + MediaQuery.of(context).padding.top,
        color: Theme.of(context).primaryColor.withAlpha(225),
        padding: EdgeInsets.only(top: VFDimens.d_16),
        child: Consumer<UserModel>(
          builder: (context, model, child) => InkWell(
            onTap: model.hasUser
                ? null
                : () {
                    Navigator.of(context).pushNamed(RouteName.mineLoft);
                  },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  child: Hero(
                    tag: 'loginLogo',
                    child: ClipOval(
                      child: Image.asset(
                          RESHelper.wrapImage('img_default_avatar.png'),
                          fit: BoxFit.cover,
                          width: 80,
                          height: 80,
                          color: model.hasUser
                              ? Theme.of(context).accentColor.withAlpha(200)
                              : Theme.of(context).accentColor.withAlpha(10),
                          // https://api.flutter.dev/flutter/dart-ui/BlendMode-class.html
                          colorBlendMode: BlendMode.colorDodge),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: <Widget>[
                    Text(
                        model.hasUser
                            ? model.user.nickname
                            : FlutterI18n.translate(context, "app_name"),
                        style: Theme.of(context)
                            .textTheme
                            .title
                            .apply(color: Colors.white.withAlpha(200))),
                    SizedBox(
                      height: VFDimens.d_24,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
