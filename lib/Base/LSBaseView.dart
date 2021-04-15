import 'package:flutter/material.dart';
import 'package:flutter_shop/Base/LSBaseViewModel.dart';
import 'package:provider/provider.dart';

class LSBaseView<T extends LSBaseViewModel> extends StatefulWidget{

  final Widget Function(BuildContext context,T model,Widget child) builde;

  final T model;

  final Widget child;
  final Function(T) onModelReady;

  LSBaseView({Key  key,this.model,this.builde,this.child,this.onModelReady }) : super(key : key);

@override
_LSBaseViewState<T> createState() => _LSBaseViewState<T>();

}

class _LSBaseViewState<T extends LSBaseViewModel> extends State<LSBaseView<T>>{


  T model;

  @override
  void initState() {
    // TODO: implement initState
    model = widget.model;
    if (widget.onModelReady != null){
      widget.onModelReady(model);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      child: Consumer<T>(
        builder: widget.builde,
        child: widget.child,
      ),
      create: (BuildContext context){
        return model;
      },
    );
  }


}