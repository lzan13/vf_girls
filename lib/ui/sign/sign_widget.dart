import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import 'package:vf_girls/common/index.dart';
import 'package:vf_girls/ui/widget/bottom_clipper.dart';
import 'package:vf_plugin/vf_plugin.dart';

///
/// 顶部面板
///
class SignTopPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: BottomClipper(),
      child: Container(
        height: 220,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}

class SignLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // var theme = Theme.of(context);
    return Hero(
      tag: 'sign_logo',
      child: ClipOval(
        child: Image.asset(
          RESHelper.wrapImage('img_logo.png'),
          width: VFDimens.d_96,
          height: VFDimens.d_96,
          fit: BoxFit.cover,
          // color: theme.brightness == Brightness.dark
          //     ? theme.accentColor
          //     : Colors.white,
          // colorBlendMode: BlendMode.srcIn,
        ),
      ),
    );
  }
}

///
/// 表单容器
///
class SignFormContainer extends StatelessWidget {
  final Widget child;

  SignFormContainer({this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: VFDimens.d_32,
        vertical: VFDimens.d_32,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: VFDimens.d_16,
        vertical: VFDimens.d_32,
      ),
      decoration: new BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.all(
          Radius.circular(VFDimens.border_radius_normal),
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withAlpha(20),
            offset: Offset(0.0, 5.0),
            blurRadius: VFDimens.d_16,
            spreadRadius: 2.0,
          ),
        ],
      ),
      child: child,
    );
  }
}

/// 按钮样式封装
class SignButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;

  SignButton({this.child, this.onPressed});

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context).primaryColor.withAlpha(180);
    return FlatButton(
      // padding: EdgeInsets.all(0),
      padding: const EdgeInsets.fromLTRB(
        VFDimens.d_16,
        VFDimens.d_12,
        VFDimens.d_16,
        VFDimens.d_12,
      ),
      color: color,
      disabledColor: color,
      child: child,
      onPressed: onPressed,
    );
  }
}

///
/// 封装登录表单输入框
///
class SignInput extends StatefulWidget {
  final String label;
  final IconData icon;
  final bool obscureText;
  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final ValueChanged<String> onFieldSubmitted;

  SignInput({
    this.label,
    this.icon,
    this.controller,
    this.obscureText: false,
    this.validator,
    this.focusNode,
    this.textInputAction,
    this.onFieldSubmitted,
  });

  @override
  SignInputState createState() => SignInputState();
}

class SignInputState extends State<SignInput> {
  TextEditingController controller;

  /// 默认遮挡密码
  ValueNotifier<bool> obscureNotifier;

  @override
  void initState() {
    controller = widget.controller ?? TextEditingController();
    obscureNotifier = ValueNotifier(widget.obscureText);
    super.initState();
  }

  @override
  void dispose() {
    obscureNotifier.dispose();
    // 默认没有传入 controller, 需要内部释放
    if (widget.controller == null) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: VFDimens.d_0,
        vertical: VFDimens.d_4,
      ),
      child: ValueListenableBuilder(
        valueListenable: obscureNotifier,
        builder: (context, value, child) => TextFormField(
          controller: controller,
          obscureText: value,
          validator: (text) {
            var validator = widget.validator ?? (_) => null;
            return text.trim().length > 0
                ? validator(text)
                : FlutterI18n.translate(context, 'not_null');
          },
          focusNode: widget.focusNode,
          textInputAction: widget.textInputAction,
          onFieldSubmitted: widget.onFieldSubmitted,
          decoration: InputDecoration(
            prefixIcon: Icon(
              widget.icon,
              color: theme.accentColor,
              size: VFDimens.d_20,
            ),
            hintText: widget.label,
            hintStyle: TextStyle(fontSize: VFSizes.s_16),
            suffixIcon: SignInputSuffixIcon(
              controller: controller,
              obscureText: widget.obscureText,
              obscureNotifier: obscureNotifier,
            ),
          ),
        ),
      ),
    );
  }
}

///
/// 输入框密码显示隐藏
///
class SignInputSuffixIcon extends StatelessWidget {
  final TextEditingController controller;

  final ValueNotifier<bool> obscureNotifier;

  final bool obscureText;

  SignInputSuffixIcon(
      {this.controller, this.obscureNotifier, this.obscureText});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SignInputClearIcon(controller),
        Offstage(
          offstage: !obscureText,
          child: InkWell(
            onTap: () {
              obscureNotifier.value = !obscureNotifier.value;
            },
            child: ValueListenableBuilder(
              valueListenable: obscureNotifier,
              builder: (context, value, child) => Padding(
                padding: EdgeInsets.all(VFDimens.d_8),
                child: Icon(
                  VFIcons.ic_eye_on,
                  size: VFDimens.d_20,
                  color: value ? theme.hintColor : theme.accentColor,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

///
/// 清空按钮
///
class SignInputClearIcon extends StatefulWidget {
  final TextEditingController controller;

  SignInputClearIcon(this.controller);

  @override
  SignInputClearIconState createState() => SignInputClearIconState();
}

class SignInputClearIconState extends State<SignInputClearIcon> {
  ValueNotifier<bool> notifier;

  @override
  void initState() {
    notifier = ValueNotifier(widget.controller.text.isEmpty);
    widget.controller.addListener(() {
      if (mounted) notifier.value = widget.controller.text.isEmpty;
    });
    super.initState();
  }

  @override
  void dispose() {
    notifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: notifier,
      builder: (context, bool value, child) {
        return Offstage(
          offstage: value,
          child: child,
        );
      },
      child: InkWell(
        onTap: () {
          widget.controller.clear();
        },
        child: Padding(
          padding: EdgeInsets.all(VFDimens.d_8),
          child: Icon(
            VFIcons.ic_close,
            size: VFDimens.d_20,
            color: Theme.of(context).hintColor,
          ),
        ),
      ),
    );
  }
}
