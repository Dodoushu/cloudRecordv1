
import 'package:flutter/material.dart';
import 'package:cloudrecord/untils/picWidget.dart';

void main() {
  Map map = {
    "id": "13",
    "date": "2022-02-05",
    "hospital": "西安市第四人民医院",
    "doctorName": "贾雨阳",
    "section": "内科",
    "description": "患者主诉：不规律腹痛6小时，20分钟前入院。检查所见及意见：白细胞偏高，无其他异常，肌酐值偏高，结合CT检查及尿常规检查结果白细胞值超标。判断为急性肾炎",
    "userId": "30",
    "address": ["39.100.100.198/picture/13/scaled_3dfc362d-bfb7-432b-a5d2-97d41842f25f7642161268896835984.jpg"],
    "class": "门诊病历"
  };
  runApp(new MaterialApp(
    title: '',
    theme: new ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: new detailPage(map),
  ));
}

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
                      '医生姓名:',
                      style: TextStyle(fontSize: 19),
                    ),
                    Flexible(
                      child: Text(
                        map['doctorName'],
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
