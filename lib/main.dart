import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_shop/Base/LSScreen.dart';
import 'package:flutter_shop/Route/LSRoute.dart';
import 'package:flutter_shop/Net/LSHttpRequestManager.dart';
import 'package:flutter_shop/provider_setup.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'Route/RoutePaths.dart';
void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LSScreen.init();

   return MultiProvider(providers: providers,

   child: MaterialApp(
     title: 'Flutter MVVM',
     theme: ThemeData(
       primarySwatch: Colors.blue,
       visualDensity: VisualDensity.adaptivePlatformDensity,
     ),
     initialRoute: RoutePaths.TABBAR,
     onGenerateRoute: LSRouter.generateRoute,
   ),
   );
  }

}
