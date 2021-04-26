import 'package:flutter/material.dart';
import 'package:cloudrecord/untils/picWidget.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:yaml/yaml.dart';
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
  List checkClass = [
    'other',
    'labortory',
    'picture',
    'invasive',
    'pathology',
    'other'
  ];
  List checkClassCN = ['其他', '化验检查', '影像检查', '侵入式检查', '病理学检查', '其他'];
  Map checkSubClass = new Map();

  _State(Map map) {
    this.map = map;
    print(map);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getYamlData().then((value) {
      checkSubClass = value;
      print(value);
      setState(() {

      });
    });
  }

  Future getYamlData() async {
    var yamlstr = await rootBundle.loadString('assets/userConfig.yaml');
    var doc = loadYaml(yamlstr);
    Map list = doc['checkClassfyNum'];
    return list;
  }

  Map map = new Map();

//  {
//    id: 5,
//    date: 2021-04-15,
//    hospital: 123,
//    section: 五官科,
//    items: 1,
//    subItems: 5,
//    subSubItems: 0,
//    description: 123,
//    userId: 30,
//    address: [39.100.100.198/picture/5/scaled_76b7e937-07aa-4588-b40e-bb4bdeebfecc175662189061542615.jpg]
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
                    '检查日期:',
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
                    Flexible(
                      child: Text(
                        map['hospital'],
                        style: TextStyle(fontSize: 19),
                      ),
                    )
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
                    Flexible(
                      child: Text(
                        '检查分类:',
                        style: TextStyle(fontSize: 19),
                      ),
                    ),
                    Text(
                      checkClassCN[map['items']],
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
                    Flexible(
                      child: Text(
                        '检查种类:',
                        style: TextStyle(fontSize: 19),
                      ),
                    ),
                    Text(
                      checkSubClass[checkClass[map['items']]][map['subItems']],
//                      checkSubClass[checkClass[map['items']]][map['subItems']].toString(),
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
                      '检查描述:',
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
                        map['description'] == null ? '无' : map['description'],
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
        title: new Text('检查记录查询'),
        centerTitle: true,
      ),
      body: Container(
        child: basicInfo,
      ),
    );
  }
}
