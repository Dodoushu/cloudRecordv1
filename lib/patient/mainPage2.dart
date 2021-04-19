import 'package:flutter/material.dart';
import 'package:cloudrecord/patient/mainPage2/checkInfo.dart';
import 'register2.dart';

//void main() {
//  runApp(new MaterialApp(
//    title: '',
//    theme: new ThemeData(
//      primarySwatch: Colors.blue,
//    ),
//    home: new (),
//  ));
//}

class mainPage2 extends StatefulWidget {
  @override
  _State createState() => new _State();
}

class _State extends State<mainPage2> {
  @override
  Widget build(BuildContext context) {
    double width_ = MediaQuery.of(context).size.width;

    Widget checkInfo = new Container(
        padding: EdgeInsets.only(top: 10, left: 5, right: 5),
        child: SizedBox(
            height: width_*0.15,
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => checkInfoPage()));
              },
              child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      side: BorderSide(width: 0.5)),
                  child: Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                '查看个人信息',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            Container(
                              child: new Icon(
                                Icons.arrow_forward_ios,
                                size: 26,
                              ),
                            ),
                          ]))),
            )));

    Widget reWrite = new Container(
        padding: EdgeInsets.only(top: 10, left: 5, right: 5),
        child: SizedBox(
            height: width_*0.15,
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => register2()));
              },
              child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      side: BorderSide(width: 0.5)),
                  child: Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                '重新填写个人信息',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            Container(
                              child: new Icon(
                                Icons.arrow_forward_ios,
                                size: 26,
                              ),
                            ),
                          ]))),
            )));

    Widget functionList = new Container(
      width: width_ * 0.9,
      child: new Column(
        children: [],
      ),
    );

    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text('我的'),
      ),
      body: new ListView(
        children: <Widget>[checkInfo,reWrite],
      ),
    );
  }
}
