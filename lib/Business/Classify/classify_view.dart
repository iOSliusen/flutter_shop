import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/Base/LSBaseView.dart';
import 'package:flutter_shop/Business/Classify/classify_view_model.dart';
import 'package:provider/provider.dart';

class ClassifyView extends StatefulWidget {
  @override
  _ClassifyViewState createState() => _ClassifyViewState();
}

class _ClassifyViewState extends State<ClassifyView>
    with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LSBaseView<ClassifyViewModel>(
      model: ClassifyViewModel(api: Provider.of(context)),
      onModelReady: (model) {
        //请求数据
        print("请求数据");
      },
      builde: (context, model, child) {
        return Scaffold(
          backgroundColor: Color(0xFFF5F5F5),
          appBar: AppBar(
            title: Text('分类'),
          ),
          body: _buildContent(context, model),
        );
      },
    );
  }

  Widget _buildContent(BuildContext context, ClassifyViewModel model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("分类"),
      ],
    );
  }
}
