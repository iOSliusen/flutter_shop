import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_shop/Business/Cover/View/it_cover_view.dart';
import 'package:flutter_shop/Business/Login/View/Login.dart';
import 'package:flutter_shop/Business/MainPage/HomeView.dart';
import 'package:flutter_shop/Business/Tabbar/LSTabbarNavigator.dart';

import 'RoutePaths.dart';

class LSRouter {

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.LOGIN:
        return MaterialPageRoute(builder: (_) => LoginView());
      case RoutePaths.HOME:
        return MaterialPageRoute(builder: (_) => HomeView());
      case RoutePaths.COVER:
        return MaterialPageRoute(builder: (_) => ITCoverView());
      case RoutePaths.TABBAR:
        return MaterialPageRoute(builder: (_) => LSTabbarNavigator());

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                child: Text('没有找到对应的页面：${settings.name}'),
              ),
            ));
    }
  }

}
