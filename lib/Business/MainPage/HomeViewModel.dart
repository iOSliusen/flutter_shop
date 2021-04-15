import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_shop/Base/LSBaseViewModel.dart';
import 'package:flutter_shop/Base/View_State.dart';
import 'package:flutter_shop/API/Api.dart';

class HomeViewModel extends LSBaseViewModel {

  HomeViewModel({@required Api api}) : super(api: api);

  Future<void> loadData() async {
    print('加载首页数据...');
    setState(ViewState.Busy);
    await Future.delayed(Duration(seconds: 2));
    setState(ViewState.Idle);
    print('加载首页数据完成');
  }

}