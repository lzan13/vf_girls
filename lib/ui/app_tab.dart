import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vf_library/generated/i18n.dart';

import 'home/home.dart';
import 'find/find.dart';
import 'mine/mine.dart';

List<Widget> pages = <Widget>[
  Home(),
  Find(),
  Mine(),
];

class AppTab extends StatefulWidget {
  AppTab({Key key}) : super(key: key);

  @override
  AppTabState createState() => AppTabState();
}

class AppTabState extends State<AppTab> {
  var _pageController = PageController();
  int _selectedIndex = 0;
  DateTime _lastPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          if (_lastPressed == null ||
              DateTime.now().difference(_lastPressed) > Duration(seconds: 1)) {
            //两次点击间隔超过1秒则重新计时
            _lastPressed = DateTime.now();
            return false;
          }
          return true;
        },
        child: PageView.builder(
          itemBuilder: (ctx, index) => pages[index],
          itemCount: pages.length,
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text(S.of(context).tab_home),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            title: Text(S.of(context).tab_explore),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text(S.of(context).tab_mine),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          _pageController.jumpToPage(index);
        },
      ),
    );
  }

  @override
  void initState() {
//    checkAppUpdate(context);
    super.initState();
  }
}
