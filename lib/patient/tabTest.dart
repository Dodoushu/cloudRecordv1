import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new NewsPageState();
}

class NewsPageState extends State<NewsPage> {
  //定义一个widget数组，用于存放标签栏的内容,这里我定义了8个标签栏，分别对应不同的新闻类型
  final List<Tab> tabs = <Tab>[
    new Tab(
      text: '记录录入',
    ),
    new Tab(
      text: '记录查询',
    ),
    new Tab(
      text: '我的医生',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    //返回一个默认的tab控制器，用于tabBar和tabBarView的联动控制
    return new DefaultTabController(
      //length表示一个有几个标签栏
      length: tabs.length,
      //返回一个包含了appBar和body内容区域的脚手架
      child: new Scaffold(
        appBar: new AppBar(
          title: new Text('TabBar'),
          //标签栏位置存于appBar的底部，tabs是一个widget数组，就是每个标签栏的内容
          bottom: new TabBar(
            tabs: tabs,
            //这表示当标签栏内容超过屏幕宽度时是否滚动，因为我们有8个标签栏所以这里设置是
            isScrollable: false,
            //标签颜色
            labelColor: Colors.orange,
            //未被选中的标签的颜色
            unselectedLabelColor: Colors.white,
            labelStyle: new TextStyle(fontSize: 18.0),
          ),
        ),
        //根据tab内容，我在每个标签对应的视图里放了一个简单的文本，内容就是对应的标签名称。
        body: new TabBarView(
          children: tabs.map((Tab tab) {
            return new Center(
              child: new Text(
                '内容',
                style: new TextStyle(fontSize: 30.0),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

//import 'package:flutter/material.dart';
//import 'news_page.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Simple News',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new NewsPage(),
    );
  }
}