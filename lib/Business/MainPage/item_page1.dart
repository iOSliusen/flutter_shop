import 'package:flutter/cupertino.dart';

class ItemPage1 extends StatefulWidget {
  int pageIndex;

  ItemPage1(this.pageIndex);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<ItemPage1>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 44,
          child: Text("item $index"),
        );
      },
      itemCount: 100,
    );
  }
}