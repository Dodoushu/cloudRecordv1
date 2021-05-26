
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
//    id: 13,
//    date: 2021-04-22,
//    hospital: 123,
//    doctorName: 123,
//    section: 妇产科,
//    description: 123,
//    userId: 30,
//    address: [39.100.100.198/picture/13/scaled_3dfc362d-bfb7-432b-a5d2-97d41842f25f7642161268896835984.jpg],
//    class: 门诊病历
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
                    '日期:',
                    style: TextStyle(fontSize: 19),
                  ),
                  Text(
                    map['date'],
                    style: TextStyle(fontSize: 19),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 2,
            ),
            InkWell(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '时间:',
                    style: TextStyle(fontSize: 19),
                  ),
                  Text(
                    map['time'],
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
                      '拍照部位:',
                      style: TextStyle(fontSize: 19),
                    ),
                    Flexible(child: Text(
                      map['position'],
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
                    Text(
                      '自拍描述:',
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
        title: new Text('病症自拍详情'),
        centerTitle: true,
      ),
      body: Container(
        child: basicInfo,
      ),
    );
  }
}
