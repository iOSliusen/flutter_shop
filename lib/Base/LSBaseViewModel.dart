import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_shop/API/Api.dart';
import 'package:flutter_shop/Base/View_State.dart';
import 'package:rxdart/rxdart.dart';

class LSBaseViewModel extends ChangeNotifier {
  Api api;
  bool disposed = false;
  LSBaseViewModel({@required Api api}) : api = api;

  ViewState _state = ViewState.Idle;
  ViewState get state => _state;
  void setState(ViewState state) {
    _state = state;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    disposed = true;
  }

  @override
  void notifyListeners() {
    // TODO: implement notifyListeners
    if (!disposed) {
      super.notifyListeners();
    }
  }
}
