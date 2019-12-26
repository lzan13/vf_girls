import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:provider/provider.dart';
import 'package:vf_girls/view_model/theme_model.dart';

import 'package:vf_plugin/vf_plugin.dart';

import 'package:vf_girls/common/index.dart';
import 'package:vf_girls/router/router_manger.dart';

///
/// 设置页面
///
class SettingsPage extends StatefulWidget {
  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VFTopBar(
        top: MediaQuery.of(context).padding.top,
        title: FlutterI18n.translate(context, "settings"),
        titleColor: VFColors.white,
        leftIcon: VFIcons.arrowLeft,
      ),
      body: SettingBody(),
    );
  }
}

class SettingBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SettingBodyState();
  }
}

class SettingBodyState extends State<SettingBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: EasyRefresh(
        child: ListView(children: <Widget>[
          // 设置字体
          VFListItem(
            title: FlutterI18n.translate(context, 'theme_font'),
            describe: ThemeModel.fontName(
                Provider.of<ThemeModel>(context).fontIndex, context),
            isNewGroup: true,
            onPressed: () {
              showChangeFont();
            },
            leftIcon: Icons.font_download,
          ),
          // 设置主题
          VFListItem(
            title: FlutterI18n.translate(context, 'theme_color'),
            showDivider: false,
            onPressed: () {
              showChangeTheme();
            },
            leftIcon: Icons.color_lens,
          ),
          // 问题反馈
          VFListItem(
            title: FlutterI18n.translate(context, 'feedback'),
            showDivider: false,
            onPressed: () {
              Router.toFeedback(context);
            },
            leftIcon: Icons.color_lens,
          ),
        ]),
      ),
    );
  }

  ///
  /// 显示设置字体对话框
  ///
  void showChangeFont() {
    showDialog(
        context: context,
        builder: (ctx) {
          return SimpleDialog(
            title: Text(FlutterI18n.translate(context, "theme_font")),
            titlePadding: EdgeInsets.all(VFDimens.d_20),
            elevation: VFDimens.elevation_normal,
            contentPadding: const EdgeInsets.fromLTRB(
                VFDimens.d_16, VFDimens.d_8, VFDimens.d_16, VFDimens.d_24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(VFDimens.border_radius_small),
              ),
            ),
            children: <Widget>[
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: ThemeModel.fontValueList.length,
                  itemBuilder: (context, index) {
                    var model = Provider.of<ThemeModel>(context);
                    return RadioListTile(
                      value: index,
                      onChanged: (index) {
                        model.switchFont(index);
                      },
                      groupValue: model.fontIndex,
                      title: Text(ThemeModel.fontName(index, context)),
                    );
                  })
            ],
          );
        });
  }

  ///
  /// 显示设置主题对话框
  ///
  void showChangeTheme() {
    showDialog(
        context: context,
        builder: (ctx) {
          return SimpleDialog(
            title: Text(FlutterI18n.translate(context, "theme_color")),
            titlePadding: EdgeInsets.all(VFDimens.d_20),
            elevation: VFDimens.elevation_normal,
            contentPadding: const EdgeInsets.fromLTRB(
                VFDimens.d_16, VFDimens.d_8, VFDimens.d_16, VFDimens.d_24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(VFDimens.border_radius_small),
              ),
            ),
            children: <Widget>[
              Center(
                // padding: const EdgeInsets.symmetric(
                //     horizontal: VFDimens.d_8, vertical: VFDimens.d_8),
                child: Wrap(
                  spacing: 5,
                  runSpacing: 5,
                  children: <Widget>[
                    ...Colors.primaries.map((color) {
                      return Material(
                        color: color,
                        child: InkWell(
                          onTap: () {
                            var model = Provider.of<ThemeModel>(context);
                            model.switchTheme(color: color);
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: VFDimens.d_40,
                            height: VFDimens.d_40,
                          ),
                        ),
                      );
                    }).toList(),
                    // 随机颜色
                    // Material(
                    //   child: InkWell(
                    //     onTap: () {
                    //       var model = Provider.of<ThemeModel>(context);
                    //       var brightness = Theme.of(context).brightness;
                    //       model.switchRandomTheme(brightness: brightness);
                    //     },
                    //     child: Container(
                    //       alignment: Alignment.center,
                    //       decoration: BoxDecoration(
                    //           border:
                    //               Border.all(color: Theme.of(context).accentColor)),
                    //       width: 40,
                    //       height: 40,
                    //       child: Text(
                    //         "?",
                    //         style: TextStyle(
                    //             fontSize: 20, color: Theme.of(context).accentColor),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          );
        });
  }
}
