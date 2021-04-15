import 'package:flutter/material.dart';
import 'package:flutter_shop/API/Api.dart';
import 'package:flutter_shop/Base/LSBaseViewModel.dart';
import 'package:flutter_shop/Business/Cover/Model/i_t_home_cover_entity.dart';
import 'package:flutter_shop/generated/json/base/json_convert_content.dart';

class ITCoverViewModel extends LSBaseViewModel {
  List<ITHomeCoverEntity> models;

  ITCoverViewModel({@required Api api}) : super(api: api);

  void requestCoverData() {
    models = [];
    api.requestITCover().then((value) {
      print(value);

      if (value is Map) {
        var data  =  value["data"];
        print('data 是个 list');
        var datas = data as List;
        for (var item in datas) {
          if (item is Map) {
            var model = item as Map;

            var entity = new ITHomeCoverEntity().fromJson(model);
            models.add(entity);
          }
        }
      }
      notifyListeners();//刷新UI
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    print("封面VM 被释放");
    super.dispose();
  }
}
