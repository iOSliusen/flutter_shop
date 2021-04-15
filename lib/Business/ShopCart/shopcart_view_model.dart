import 'package:flutter/cupertino.dart';
import 'package:flutter_shop/API/Api.dart';
import 'package:flutter_shop/Base/LSBaseViewModel.dart';

class ShopcartViewModel extends LSBaseViewModel{

  ShopcartViewModel({@required Api api}) : super(api: api);

  @override
  void dispose() {
    // TODO: implement dispose
    print("封面VM 被释放");
    super.dispose();
  }

}