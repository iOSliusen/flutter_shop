import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/Base/LSBaseView.dart';
import 'package:flutter_shop/Base/LSScreen.dart';
import 'package:flutter_shop/Business/Cover/ViewModel/it_cover_view_model.dart';
import 'package:provider/provider.dart';

class ITCoverView extends StatefulWidget{

  @override
  _ITCoverViewState createState() => _ITCoverViewState();
}

class _ITCoverViewState extends State<ITCoverView> with AutomaticKeepAliveClientMixin{


  @override
  Widget build(BuildContext context) {
super.build(context);
    return  LSBaseView<ITCoverViewModel> (
      model: ITCoverViewModel(api: Provider.of(context)),
      onModelReady: (model){
        //请求数据
        print("请求数据");
        model.requestCoverData();
      },
      builde: (context, model, child){
        return Scaffold(
          backgroundColor: Color(0xFFF5F5F5),
          appBar: AppBar(
            title: Text('IT之家封面'),
          ),
          body: _buildContent(context, model),
        );
      },
    );
  }

Widget _buildContent(BuildContext context,ITCoverViewModel model){
    // return Row(
    // mainAxisAlignment: MainAxisAlignment.center,
    //   children: _createImage(model),
    // );
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    physics: PageScrollPhysics(parent: BouncingScrollPhysics()),
    padding: EdgeInsets.all(0.0),
    child: Row(
      children: _createImage(model),
    ),
  );
}
List<Widget> _createImage(ITCoverViewModel model){
    List<Widget> lists = [];
    double width = LSScreen.screenWidthDp - 0.0;
    if (model.models.length > 0){
      for (var entity in model.models){
        Widget image = CachedNetworkImage(imageUrl: entity.ux,width: width,height: LSScreen.screenHeightDp,fit: BoxFit.fill,);
        lists.add(image);
      }
    }else{

      Widget text = Text("暂无图片内容");

      lists.add(text);
    }
    return lists;
}

  @override
  bool get wantKeepAlive => true;

}