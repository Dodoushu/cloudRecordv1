
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

  _State(Map map) {
    this.map = map;
    print(map);
    getYamlData().then((value) {
      dieaseHistory = value;
      print(value);
      setState(() {

      });
    });
  }

  Map map = new Map();

  List dieaseHistory = new List();

  Future getYamlData() async {
    var yamlstr = await rootBundle.loadString('assets/userConfig.yaml');
    var doc = loadYaml(yamlstr);
    List list = doc['deseaseHistoryClass'];
    return list;
  }

//  {id: 3, date: 2021-04-12, diseaseType: 4, description: null, userId: 30, address: []}]


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
                      '既往病史分类:',
                      style: TextStyle(fontSize: 19),
                    ),
                    Flexible(child: Text(
                      dieaseHistory[map['diseaseType']].toString(),
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
                      '文字描述内容:',
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
        title: new Text('既往病史'),
        centerTitle: true,
      ),
      body: Container(
        child: basicInfo,
      ),
    );
  }
}
