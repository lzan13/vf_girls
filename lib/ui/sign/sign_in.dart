import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import 'package:provider/provider.dart';

import 'package:vf_plugin/vf_plugin.dart';

import 'package:vf_girls/common/index.dart';
import 'package:vf_girls/router/router_manger.dart';
import 'package:vf_girls/ui/sign/sign_widget.dart';
import 'package:vf_girls/view_model/sign_model.dart';

///
/// 登录
///
class SignInPage extends StatefulWidget {
  @override
  SignInPageState createState() => SignInPageState();
}

class SignInPageState extends State<SignInPage> {
  /// outside new  inside dispose may be crash. watch it
  /// 理论上应该在当前页面dispose,
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _pwdFocus = FocusNode();

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SignModel model = Provider.of<SignModel>(context);
    return Scaffold(
      appBar: VFTopBar(
        top: MediaQuery.of(context).padding.top,
        title: FlutterI18n.translate(context, 'sign_in'),
        titleColor: VFColors.white,
        leftIcon: VFIcons.ic_close,
      ),
      body: EasyRefresh.custom(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Stack(
              children: <Widget>[
                SignTopPanel(),
                Container(
                  padding: EdgeInsets.symmetric(vertical: VFDimens.d_24),
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
                                textInputAction: TextInputAction.next,
                                validator: (value) {
                                  return VFReg.isMobileExact(
                                          _nameController.text)
                                      ? FlutterI18n.translate(context, '')
                                      : null;
                                },
                                onFieldSubmitted: (text) {
                                  FocusScope.of(context)
                                      .requestFocus(_pwdFocus);
                                },
                              ),
                              SignInput(
                                controller: _passwordController,
                                label: FlutterI18n.translate(
                                    context, 'sign_password'),
                                icon: VFIcons.ic_password,
                                obscureText: true,
                                focusNode: _pwdFocus,
                                textInputAction: TextInputAction.done,
                              ),
                              SignInButton(
                                _nameController,
                                _passwordController,
                              ),
                              GoSignUp(),
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
          ),
        ],
      ),
    );
  }
}

class SignInButton extends StatelessWidget {
  final nameController;
  final passwordController;

  SignInButton(this.nameController, this.passwordController);

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<SignModel>(context);
    return Padding(
      padding: EdgeInsets.only(top: VFDimens.d_24),
      child: SignButton(
        child: model.isBusy
            ? VFLoading(color: Theme.of(context).primaryColorLight)
            : Text(
                FlutterI18n.translate(context, 'sign_in'),
                style: Theme.of(context).accentTextTheme.title.copyWith(
                      wordSpacing: 6,
                      fontSize: VFSizes.s_18,
                    ),
              ),
        onPressed: model.isBusy
            ? null
            : () async {
                if (Form.of(context).validate()) {
                  bool result = await model.signIn(
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

class GoSignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: VFDimens.d_24),
      child: Center(
        child: InkWell(
          onTap: () {
            Router.toSignUp(context);
          },
          child: Text.rich(
            TextSpan(
              text: FlutterI18n.translate(context, 'sign_no_account'),
              children: [
                TextSpan(
                  text: FlutterI18n.translate(context, 'sign_go_up'),
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
