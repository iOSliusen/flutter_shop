import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_shop/Base/LSBaseView.dart';
import 'package:flutter_shop/Business/MainPage/HomeViewModel.dart';
import 'package:flutter_shop/Untils/BannerHomepage.dart';
import 'package:provider/provider.dart';
import 'package:flutter_shop/Base/View_State.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'item_page1.dart';

class HomeView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ScrollHomePageState();
  }
}

class _ScrollHomePageState extends State with SingleTickerProviderStateMixin {
  TabController tabController;
  double topHeight = 500.0;
  List<Image> imgs = [
    //建立了一个图片数组
    Image.network(
      "https://images.unsplash.com/photo-1477346611705-65d1883cee1e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
      fit: BoxFit.cover,
    ),
    Image.network(
      "https://images.unsplash.com/photo-1498550744921-75f79806b8a7?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80",
      fit: BoxFit.cover,
    ),
    Image.network(
      "https://images.unsplash.com/photo-1451187580459-43490279c0fa?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
      fit: BoxFit.cover,
    ),
  ];
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
    //开始创建界面
    return LSBaseView<HomeViewModel>(
      onModelReady: (model) async {
        //在这里请求数据
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
        notificationPredicate: (ScrollNotification notifation) {
          //该属性包含当前ViewPort及滚动位置等信息
          ScrollMetrics scrollMetrics = notifation.metrics;
          if (scrollMetrics.minScrollExtent == 0) {
            return true;
          } else {
            return false;
          }
        },
        //下拉刷新回调方法
        onRefresh: () async {
          //模拟网络刷新 等待2秒
          await Future.delayed(Duration(milliseconds: 2000));
          //返回值以结束刷新
          return Future.value(true);
        },
        child: _buildBody(context, model),
      ),
    );
  }

  Widget _buildBody(BuildContext context, HomeViewModel model) {
    return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool b) {
          return [_buildSliverAppBar(context, model)];

          ///主体部分
        },
        body: buidChildWidget());
  }

  //SliverAppBar
  //flexibleSpace可折叠的内容区域
  Widget _buildSliverAppBar(BuildContext context, HomeViewModel model) {
    return SliverAppBar(
      title: _buildAppBarHeader(context, model),
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
      expandedHeight: topHeight,
      elevation: 0.0,
      flexibleSpace: buildFlexibleSpaceBar(),
      bottom: buildFlexibleTooBarWidget(context, model),
      brightness: Brightness.dark,
    );
  }

  //构建SliverAppBar的标题title
  Widget _buildAppBarHeader(BuildContext context, HomeViewModel model) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 10),
      height: 38,
      decoration: BoxDecoration(
        color: Colors.transparent,
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
        centerTitle: true, background: buildFlexibleSpaceWidget());
  }

  //[SliverAppBar]的bottom属性配制
  Widget buildFlexibleTooBarWidget(BuildContext context, HomeViewModel model) {
    //[PreferredSize]用于配置在AppBar或者是SliverAppBar
    //的bottom中 实现 PreferredSizeWidget
    return PreferredSize(
        child: Container(
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
        ),
        preferredSize: Size(MediaQuery.of(context).size.width, 44));
  }

  //显示图片与角标区域Widget构建
  buildFlexibleSpaceWidget() {
    // Container(
    // decoration: new BoxDecoration(image:DecorationImage(image: AssetImage('assets/images/home_page_top_back.png'),fit: BoxFit.fitWidth)),
    // height: topHeight,
    // child:
    return Column(
      children: [
        Container(
          decoration: new BoxDecoration(color: Colors.white,image:DecorationImage(image: AssetImage('assets/images/home_page_top_back.png'),fit: BoxFit.fill)),
          height: 360,
          child:Column(
            children: [
              Container(
                decoration: new BoxDecoration(color: Colors.transparent),
                height: 120,
              ),
              Container(
                decoration: new BoxDecoration(color: Colors.transparent),
                height: 240,
                child: Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    //条目构建函数传入了index,根据index索引到特定图片
                    return imgs[index];
                  },
                  itemCount: imgs.length,
                  autoplay: false, //
                  pagination: new SwiperPagination(), //页码，通俗讲就是下边的圆点  这些都是控件默认写好的,直接用
                  // control: new SwiperControl(), //控制器，通俗讲就是两边的箭头
                  // layout: SwiperLayout.STACK,
                  viewportFraction: 0.8,
                  scale: 0.9,
                ),
              ),
            ],
          )
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
