import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import 'package:vf_plugin/vf_plugin.dart';

import 'package:vf_girls/common/index.dart';

///
/// 设置页面
///
class FeedbackPage extends StatefulWidget {
  @override
  FeedbackPageState createState() => FeedbackPageState();
}

class FeedbackPageState extends State<FeedbackPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VFTopBar(
        top: MediaQuery.of(context).padding.top,
        title: FlutterI18n.translate(context, "feedback"),
        titleColor: VFColors.white,
        leftIcon: VFIcons.ic_arrow_left,
      ),
      body: FeedbackBody(),
    );
  }
}

class FeedbackBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FeedbackBodyState();
  }
}

class FeedbackBodyState extends State<FeedbackBody> {
  final _formKey = GlobalKey<FormState>();

  Widget buildTextField(TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
//            borderSide: BorderSide(color: Colors.red, width: 3.0, style: BorderStyle.solid)//没什么卵效果
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    controller.addListener(() {
      print('input ${controller.text}');
    });
    return Container(
      child: EasyRefresh(
        child: Padding(
          padding: EdgeInsets.all(VFDimens.padding_normal),
          child: buildTextField(controller),
        ),
        // child: Form(
        //   key: _formKey,
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: <Widget>[
        //       TextFormField(
        //         validator: (value) {
        //           if (value.isEmpty) {
        //             return '请输入内容';
        //           }
        //           return null;
        //         },
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.symmetric(vertical: 16.0),
        //         child: RaisedButton(
        //           onPressed: () {
        //             // Validate returns true if the form is valid, or false
        //             // otherwise.
        //             if (_formKey.currentState.validate()) {
        //               // If the form is valid, display a Snackbar.
        //               Scaffold.of(context)
        //                   .showSnackBar(SnackBar(content: Text('value')));
        //             }
        //           },
        //           child: Text('提交'),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ),
    );
  }
}
