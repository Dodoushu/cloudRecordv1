import 'package:flutter/material.dart';

import 'package:cloudrecord/untils/showToast.dart';
import 'laboratory.dart';
import 'invasive.dart';
import 'other.dart';
import 'picture.dart';
import 'pathology.dart';

void main() {
  runApp(new MaterialApp(
    title: '',
    theme: new ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: new menu(),
  ));
}

class menu extends StatefulWidget {
  @override
  _State createState() => new _State();
}

class _State extends State<menu> {
  @override
  Widget build(BuildContext context) {

    double width_ = MediaQuery.of(context).size.width;

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
                    buttonBuilder('化验检查', Icons.book, (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => laboratory()));
                    }),
                    buttonBuilder('影像检查', Icons.add_to_photos, (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => picture()));
                    }),
                    buttonBuilder('侵入式检查', Icons.assignment, (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => invasive()));
                    }),
                  ],
                ),
              ),
              Container(padding: EdgeInsets.only(top: 30),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    buttonBuilder('病理学检查', Icons.alarm_add, (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => pathology()));
                    }),
                    buttonBuilder('其他检查', Icons.art_track, (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => other()));
                    }),
                    Container(width: width_ / 5,),
                    //检查记录提出来做一个单独的二级页面的话需要把接口
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
          '检查记录菜单',
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[menu],
      ),
    );
  }
}


