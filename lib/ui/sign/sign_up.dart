import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:provider/provider.dart';
import 'package:vf_girls/common/config.dart';
import 'package:vf_girls/common/index.dart';
import 'package:vf_girls/ui/sign/sign_widget.dart';
import 'package:vf_girls/view_model/sign_model.dart';
import 'package:vf_plugin/vf_plugin.dart';

///
/// 注册界面
///
class SignUpPage extends StatefulWidget {
  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  // 输入控制器
  final _nameController = TextEditingController();
  final _codeController = TextEditingController();
  final _passwordController = TextEditingController();
  // 倒计时器
  final VFTimer mTimer = VFTimer(totalTime: Configs.TIME_MINUTE);
  String timerStr;

  @override
  void initState() {
    super.initState();
    mTimer.setOnTimerCallback((int time) {
      double _tick = time / 1000;
      setState(() {
        timerStr = '${_tick}s';
      });
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _codeController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SignModel model = Provider.of<SignModel>(context);
    return Scaffold(
      appBar: VFTopBar(
        top: MediaQuery.of(context).padding.top,
        title: FlutterI18n.translate(context, 'sign_up'),
        titleColor: VFColors.white,
        leftIcon: VFIcons.ic_arrow_left,
      ),
      body: EasyRefresh.custom(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Stack(
              children: <Widget>[
                SignTopPanel(),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SignLogo(),
                      SignFormContainer(
                        child: Form(
                          onWillPop: () async {
                            return !model.isBusy;
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              SignInput(
                                label: FlutterI18n.translate(
                                    context, 'sign_username'),
                                icon: VFIcons.ic_mine,
                                controller: _nameController,
                                validator: (value) {
                                  return VFReg.isMobileExact(
                                          _nameController.text)
                                      ? null
                                      : FlutterI18n.translate(
                                          context, 'sign_username_verify');
                                },
                                textInputAction: TextInputAction.next,
                              ),
                              Stack(
                                children: <Widget>[
                                  SignInput(
                                    controller: _codeController,
                                    label: FlutterI18n.translate(
                                        context, 'sign_sms_code'),
                                    icon: VFIcons.ic_shield,
                                    textInputAction: TextInputAction.next,
                                  ),
                                  Positioned(
                                    right: 0.0,
                                    child: FlatButton(
                                      child: Text(
                                        mTimer.isActive()
                                            ? timerStr
                                            : FlutterI18n.translate(
                                                context, 'sign_sms_code'),
                                      ),
                                      onPressed: mTimer.isActive()
                                          ? null
                                          : () {
                                              mTimer.startCountDown();
                                            },
                                    ),
                                  ),
                                ],
                              ),
                              SignInput(
                                controller: _passwordController,
                                label: FlutterI18n.translate(
                                    context, 'sign_password'),
                                icon: VFIcons.ic_password,
                                obscureText: true,
                                textInputAction: TextInputAction.done,
                              ),
                              SignUpButton(
                                _nameController,
                                _passwordController,
                              ),
                            ],
                          ),
                        ),
                      ),
                      // ThirdSign(),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SignUpButton extends StatelessWidget {
  final nameController;
  final passwordController;

  SignUpButton(this.nameController, this.passwordController);

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<SignModel>(context);
    return Padding(
      padding: EdgeInsets.only(top: VFDimens.d_24),
      child: SignButton(
        child: model.isBusy
            ? VFLoading(color: Theme.of(context).primaryColorLight)
            : Text(
                FlutterI18n.translate(context, 'sign_up'),
                style: Theme.of(context).accentTextTheme.title.copyWith(
                      wordSpacing: 6,
                      fontSize: VFSizes.s_18,
                    ),
              ),
        onPressed: model.isBusy
            ? null
            : () async {
                if (Form.of(context).validate()) {
                  bool result = await model.signUp(
                      nameController.text, passwordController.text);
                  if (result) {
                    model.updateUserInfo();
                    Navigator.of(context).pop(true);
                  }
                }
              },
      ),
    );
  }
}
