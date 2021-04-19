import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(new MaterialApp(
      home: MainPage(),
    ));

class MainPage extends StatefulWidget {
  @override
  State createState() => new _mainPage();
}

class _mainPage extends State<MainPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setInfo();
    Future.delayed(new Duration(milliseconds: 300)).then((value) {
      setState(() {
      });
    });
  }

  void setInfo()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.get('name');
    jobTitle = prefs.get('jobTitle');
    hospital = prefs.get('hospital');
    section = prefs.get('section');
    setState(() {

    });
  }

  String name = '姓名';
  String jobTitle = '职称';
  String hospital = '陕西省人民医院';
  String section = '内科';

  @override
  Widget build(BuildContext context) {


    double width_ = MediaQuery.of(context).size.width;

    Widget bar = new Container(
      //宽度
      width: width_,
      //高度
      height: width_ * 0.3,
      // 盒子样式
      decoration: new BoxDecoration(
        color: Colors.lightBlueAccent,
        //设置Border属性给容器添加边框
        border: new Border.all(
          //为边框添加颜色
          color: Colors.black54,
          width: 0, //边框宽度
        ),
      ),
      child: Container(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            new Container(),
            new Container(
              //宽度
              width: width_ * 0.3 * (4 / 7),
              //高度
              height: width_ * 0.3 * (4 / 7),
              // 盒子样式
              child: Icon(
                Icons.android,
                size: 60,
              ),
            ),
            new Container(),
            new Container(
              //宽度
              width: width_ * 0.4,
              //高度
              height: width_ * 0.3 * (4 / 7),
              child: Container(
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        new Text(
                          name,
                          style: new TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                        new Text(
                          jobTitle,
                          style: new TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        new Container(),
                      ],
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        new Text(
                          hospital,
                          style: new TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        new Text(
                          section,
                          style: new TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        new Container(),
                        new Container()
                      ],
                    ),
                  ],
                ),
              ),
            ),
            new Container()
          ],
        ),
      ),
    );

    Widget buttonBuilder(String text, IconData icondata, Function clickFunction) {
      return InkWell(
        onTap: clickFunction,
        child: new Container(
            child: Column(children: <Widget>[
              new SizedBox(
                  height: width_ / 5,
                  width: width_ / 5,
                  child: Card(
                      elevation: 15.0, //阴影
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(100.0)),
                      ),
                      child: new Container(
                          alignment: Alignment.center,
                          child: Icon(
                            icondata,
                            size: width_ / 8,
                            color: Colors.black,
                          )))),
              new Container(
                  child: Text(
                    text,
                    style: TextStyle(fontSize: width_ / 25),
                  ))
            ])),
      );
    }

    Widget menu = new Container(
      //宽度
      width: width_,
//      // 盒子样式
//      decoration: new BoxDecoration(
//        color: Colors.black12,
//        //设置Border属性给容器添加边框
//        border: new Border.all(
//          //为边框添加颜色
//          color: Colors.black,
//          width: 0, //边框宽度
//        ),
//      ),
      child: new Container(
        child: new Column(
          children: [
            Container(padding: EdgeInsets.only(top: 30),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buttonBuilder('患者查询', Icons.search, (){}),
                  Container(width: width_ / 5,),
                  Container(width: width_ / 5,)
                ],
              ),
            ),
          ],
        ),
      )
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '主界面',
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[bar,menu],
      ),
    );
  }
}
