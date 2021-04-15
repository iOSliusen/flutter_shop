import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/Base/LSBaseView.dart';
import 'package:flutter_shop/Business/ShopCart/shopcart_view_model.dart';
import 'package:provider/provider.dart';

class ShopcartView extends StatefulWidget {
  @override
  _ShopcartViewState createState() => _ShopcartViewState();
}

class _ShopcartViewState extends State<ShopcartView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LSBaseView<ShopcartViewModel>(
      model: ShopcartViewModel(api: Provider.of(context)),
      onModelReady: (model) {
        //请求数据
        print("购物车请求数据");
      },
      builde: (context, model, child) {
        return Scaffold(
          backgroundColor: Color(0xFFF5F5F5),
          appBar: AppBar(
            title: Text('购物车'),
          ),
          body: _buildContent(context, model),
        );
      },
    );
  }

  Widget _buildContent(BuildContext context, ShopcartViewModel model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("购物车"),
      ],
    );
  }
}
