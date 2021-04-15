import 'package:flutter/material.dart';
import 'package:flutter_shop/Business/Classify/classify_view.dart';
import 'package:flutter_shop/Business/Cover/View/it_cover_view.dart';
import 'package:flutter_shop/Business/MainPage/HomeView.dart';
import 'package:flutter_shop/Business/Mine/mine_view.dart';
import 'package:flutter_shop/Business/ShopCart/shopcart_view.dart';
import 'package:flutter_shop/Business/Classify/classify_view.dart';
List<Widget> pages = <Widget>[
  HomeView(),
  ClassifyView(),
  ShopcartView(),
  MineView(),
];

class LSTabbarNavigator extends StatefulWidget {
  LSTabbarNavigator({Key key}) : super(key: key);

  @override
  _LSTabbarNavigatorState createState() {
    return _LSTabbarNavigatorState();
  }
}

class _LSTabbarNavigatorState extends State<LSTabbarNavigator> {
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
        selectedItemColor: Colors.redAccent,
        unselectedItemColor: Colors.black87,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/tabbar_home_unselected.png'),
            activeIcon: Image.asset('assets/images/tabbar_home_selected.png'),
            label: "主页",
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/tabbar_classify_unselected.png'),
            activeIcon: Image.asset('assets/images/tabbar_classify_selected.png'),
            label: "分类",
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/tabbar_shopcart_unselected.png'),
            activeIcon: Image.asset('assets/images/tabbar_shopcart_selected.png'),
            label: "购物车",
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/tabbar_mine_unselected.png'),
            activeIcon: Image.asset('assets/images/tabbar_mine_selected.png'),
            label: "我的",
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
    super.initState();
  }
}
