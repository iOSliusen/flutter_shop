
import 'dart:async';


import 'package:flutter/material.dart';
import 'package:flutter_shop/Base/LSBaseView.dart';
import 'package:flutter_shop/Business/MainPage/HomeViewModel.dart';
import 'package:provider/provider.dart';
import 'package:flutter_shop/Base/View_State.dart';
class HomeView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _ScrollHomePageState();
  }

}
class _ScrollHomePageState extends State with SingleTickerProviderStateMixin {

  TabController tabController;
  // String imageUrl = "https://user-gold-cdn.xitu.io/2018/11/13/1670c3e800cc185f?imageView2/0/w/1280/h/960/ignore-error/1";
  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: 3, vsync: this);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LSBaseView<HomeViewModel>(
      onModelReady: (model) async {
        model.loadData();
      },
      model: HomeViewModel(api: Provider.of(context)),
      builde: (context, model, child) => Scaffold(
        backgroundColor: Color(0xFFF5F5F5),

        body: _buildRefreshBody(context, model),
      ),
    );
  }


  Widget _buildRefreshBody(BuildContext context, HomeViewModel model) {
  return Scaffold(
    //下拉刷新
    body: RefreshIndicator(
      //可滚动组件在滚动时会发送ScrollNotification类型的通知
      notificationPredicate: (ScrollNotification notifation){
        //该属性包含当前ViewPort及滚动位置等信息
        ScrollMetrics scrollMetrics = notifation.metrics;
        if (scrollMetrics.minScrollExtent == 0){
          return true;
        }else{
          return false;
        }
    },
      //下拉刷新回调方法
      onRefresh: ()async{
        //模拟网络刷新 等待2秒
        await Future.delayed(Duration(milliseconds: 2000));
        //返回值以结束刷新
        return Future.value(true);
      },
      child: _buildBody(context,model),
    ),
  );
  }

  Widget _buildBody(BuildContext context, HomeViewModel model) {
    return NestedScrollView(headerSliverBuilder: (BuildContext context,bool b){
      return [_buildSliverAppBar(context,model)];
      ///主体部分
    }, body:  buidChildWidget());
  }

  //SliverAppBar
  //flexibleSpace可折叠的内容区域
Widget _buildSliverAppBar(BuildContext context, HomeViewModel model){

  return SliverAppBar(
    title: _buildAppBarHeader(context,model),
    //标题居中
    centerTitle: true,
    //当此值为true时 SliverAppBar 会固定在页面顶部
    //当此值为fase时 SliverAppBar 会随着滑动向上滑动
    ///true SliverAppBar 不会滑动
    pinned: true,
    ///是否随着滑动隐藏标题
    //当值为true时 SliverAppBar设置的title会随着上滑动隐藏
    //       //然后配置的bottom会显示在原AppBar的位置
    //       //当值为false时 SliverAppBar设置的title会不会隐藏
    //       //然后配置的bottom会显示在原AppBar设置的title下面
    floating: false,
    //当snap配置为true时，向下滑动页面，SliverAppBar（以及其中配置的flexibleSpace内容）会立即显示出来，
    //反之当snap配置为false时，向下滑动时，只有当ListView的数据滑动到顶部时，SliverAppBar才会下拉显示出来。
    snap: false,
    ///SliverAppBar展开的高度
    expandedHeight: 380,
    elevation: 0.0,
    flexibleSpace: buildFlexibleSpaceBar(),
    bottom: buildFlexibleTooBarWidget(context,model),
  );
}
  //构建SliverAppBar的标题title
  Widget _buildAppBarHeader(BuildContext context, HomeViewModel model){

    return Container(
      width:  double.infinity,
      padding: EdgeInsets.only(left: 10),
      height: 38,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_rounded,
            size: 18,
          ),
          SizedBox(
            width: 4,
          ),
          Text(
            "搜索",
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ],
      ),
    );

  }
  //通常在用到 PageView + BottomNavigationBar 或者 TabBarView + TabBar 的时候
  //大家会发现当切换到另一页面的时候, 前一个页面就会被销毁, 再返回前一页时, 页面会被重建,
  //随之数据会重新加载, 控件会重新渲染 带来了极不好的用户体验.
  //由于TabBarView内部也是用的是PageView, 因此两者的解决方式相同
  //页面的主体内容
  Widget buidChildWidget() {
    return TabBarView(
      controller: tabController,
      children: <Widget>[
        ItemPage1(1),
        ItemPage1(2),
        ItemPage1(3),
      ],
    );
  }


////AppBar下的内容区域
  FlexibleSpaceBar buildFlexibleSpaceBar() {

    return FlexibleSpaceBar(
      centerTitle: true,
      background: buildFlexibleSpaceWidget()
    );

  }
  //[SliverAppBar]的bottom属性配制
  Widget buildFlexibleTooBarWidget(BuildContext context, HomeViewModel model) {
    //[PreferredSize]用于配置在AppBar或者是SliverAppBar
    //的bottom中 实现 PreferredSizeWidget
    return PreferredSize(child: Container(
      alignment: Alignment.center,
      child: Container(
        color: Colors.grey[200],
        //随着向上滑动，TabBar的宽度逐渐增大
        //父布局Container约束为 center对齐
        //所以程现出来的是中间x轴放大的效果
        width: MediaQuery.of(context).size.width,
        child: TabBar(
          controller: tabController,
          tabs: <Widget>[
            new Tab(
              text: "标签一",
            ),
            new Tab(
              text: "标签二",
            ),
            new Tab(
              text: "标签三",
            ),
          ],
        ),
      ),

    ), preferredSize: Size(MediaQuery.of(context).size.width, 44));
  }
  //显示图片与角标区域Widget构建
  buildFlexibleSpaceWidget() {
    return Column(
      children: [
        Container(
          height: 240,
          child: BannerHomepage(isTitle: false,),
        ),
        Container(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 120,
                  color: Colors.blueGrey,
                  child: Image.asset("assets/images/banner5.jpeg"),
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.brown,
                  height: 120,
                  child: Image.asset("assets/images/banner6.jpeg"),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
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

class BannerHomepage extends StatefulWidget {
  final bool isTitle;


  BannerHomepage({this.isTitle=true});

  @override
  State<StatefulWidget> createState() {
    return _BannerHomepageState();
  }
}

class _BannerHomepageState extends State<BannerHomepage> {

  //轮播图 PageView 使用的控制器
  PageController _pageController;
  //定时器自动轮播
  Timer _timer;
  //本地资源图片
  List<String> imageList = [
    "assets/images/banner1.webp",
    "assets/images/banner2.webp",
    "assets/images/banner3.webp",
    "assets/images/banner4.webp",
  ];

  //当前显示的索引
  int currentIndex = 1000;

  @override
  void initState() {
    super.initState();
    //初始化控制器
    // initialPage 为初始化显示的子Item
    _pageController = new PageController(initialPage: currentIndex);

    ///当前页面绘制完第一帧后回调
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      startTimer();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }



  void startTimer() {
    //间隔两秒时间
    _timer = new Timer.periodic(Duration(milliseconds: 2000), (value) {
      print("定时器");
      currentIndex++;
      //触发轮播切换
      _pageController.animateToPage(currentIndex,
          duration: Duration(milliseconds: 200), curve: Curves.ease);
      //刷新
      setState(() {

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:widget.isTitle? AppBar(
        title: Text("轮播图"),
      ):null,
      body: Container(
        child: buildBanner(),
      ),
    );
  }

  Widget buildBanner() {
    return Container(
      // height: 200,
      width: double.infinity,
      child: Stack(
        children: [
          //轮播图片
          buildBannerWidget(),
          //指示器
          buildTipsWidget(),
        ],
      ),
    );
  }



  buildBannerWidget() {
    //懒加载方式构建
    return PageView.builder(
      //构建每一个子Item的布局
      itemBuilder: (BuildContext context, int index) {
        return buildPageViewItemWidget(index);
      },
      //控制器
      controller: _pageController,
      //轮播个数 无限轮播 ??
      itemCount: imageList.length * 10000,
      //PageView滑动时回调
      onPageChanged: (int index) {
        setState(() {
          currentIndex = index;
        });
      },
    );
  }

  //轮播显示图片
  buildPageViewItemWidget(int index) {
    return Image.asset(
      imageList[index % imageList.length],
      fit: BoxFit.fill,
    );
  }

  //指示器
  buildTipsWidget() {
    return Positioned(
      bottom: 20,
      right: 20,
      child: Container(
        //内边距
        padding: EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 2),
        //圆角边框
        decoration: BoxDecoration(
          //背景
            color: Colors.white,
            //边框圆角
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child:
        Text("${currentIndex % imageList.length + 1}/${imageList.length}"),
      ),
    );
  }
}