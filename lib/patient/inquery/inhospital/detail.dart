
import 'package:flutter/material.dart';
import 'package:cloudrecord/untils/picWidget.dart';

//void main() {
//  runApp(new MaterialApp(
//    title: '',
//    theme: new ThemeData(
//      primarySwatch: Colors.blue,
//    ),
//    home: new (),
//  ));
//}

class detailPage extends StatefulWidget {
  detailPage(Map map) {
    this.map = map;
  }
  Map map;
  @override
  _State createState() => new _State(map);
}

class _State extends State<detailPage> {

  _State(Map map) {
    this.map = map;
    print(map);
  }

  Map map = new Map();

//  {
//    id: 6,
//    sDate: 2021-04-14,
//    oDate: 2021-04-14,
//    hospital: 123,
//    section: 妇产科,
//    description: 123,
//    userId: 30,
//    address: [], class: 住院病历
//  }


  @override
  Widget build(BuildContext context) {

    Widget basicInfo = Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 30),
      child: Container(
        child: Column(
          children: <Widget>[
            InkWell(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '开始日期:',
                    style: TextStyle(fontSize: 19),
                  ),
                  Text(
                    map['sDate'],
                    style: TextStyle(fontSize: 19),
                  ),
                ],
              ),
            ),
            InkWell(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '结束日期:',
                    style: TextStyle(fontSize: 19),
                  ),
                  Text(
                    map['oDate'],
                    style: TextStyle(fontSize: 19),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 2,
            ),
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '医院:',
                      style: TextStyle(fontSize: 19),
                    ),
                    Flexible(child: Text(
                      map['hospital'],
                      style: TextStyle(fontSize: 19),
                    ),)
                  ],
                ),
                Divider(
                  thickness: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        '就诊科室:',
                        style: TextStyle(fontSize: 19),
                      ),
                    ),
                    Text(
                      map['section'],
                      style: TextStyle(fontSize: 19),
                    ),
                  ],
                ),
                Divider(
                  thickness: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '病例内容:',
                      style: TextStyle(fontSize: 19),
                    ),
                    Container(
                      width: 10,
                    ),
                  ],
                ),
                new Row(
                  children: [
                    Flexible(
                      child: Text(
                        map['description']==null?'无':map['description'],
                        style: TextStyle(fontSize: 19),
                      ),
                    ),
                  ],
                ),
                Divider(
                  thickness: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '附带图片:',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                smallPicGridViewNet(map['address'])
              ],
            )
          ],
        ),
      ),
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(map['class']),
        centerTitle: true,
      ),
      body: Container(
        child: basicInfo,
      ),
    );
  }
}
