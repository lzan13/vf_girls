import 'package:flutter/material.dart';

import 'package:vf_library/generated/i18n.dart';

class Find extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(S.of(context).tab_explore),
      ),
    );
  }
}
