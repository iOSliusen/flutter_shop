import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/Base/LSBaseView.dart';
import 'package:flutter_shop/Business/Mine/mine_view_model.dart';
import 'package:provider/provider.dart';

class MineView extends StatefulWidget {
  @override
  _MineViewState createState() => _MineViewState();
}

class _MineViewState extends State<MineView>
    with AutomaticKeepAliveClientMixin {
  @override

  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LSBaseView<MineViewModel>(
      model: MineViewModel(api: Provider.of(context)),
      onModelReady: (model) {
        //请求数据
        print("我的请求数据");
      },
      builde: (context, model, child) {
        return Scaffold(
          backgroundColor: Color(0xFFF5F5F5),
          appBar: AppBar(
            title: Text('我的'),
          ),
          body: _buildContent(context, model),
        );
      },
    );
  }

  Widget _buildContent(BuildContext context, MineViewModel model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("我的"),
      ],
    );
  }
}
