

import 'package:flutter/material.dart';

//void main() {
//  runApp(new MaterialApp(
//    title: 'patientResult',
//    theme: new ThemeData(
//      primarySwatch: Colors.blue,
//    ),
//    home: new PatientResult(),
//  ));
//}

class PatientResult extends StatefulWidget {
  @override
  PatientResult(List list) {
    this.list = list;
  }
  List list;
  @override
  _State createState() => new _State(list);
}

class _State extends State<PatientResult> {
  @override
  _State(List list) {
    patientList = list;
  }

  @override
  void initState() {
    setState(() {

    });
  }

  List patientList;

  List<Widget> cardBuild() {
    List<Widget> temp = new List();
    for (Map map in patientList) {

      DateTime now = DateTime.now();
      print(map['birthday']);
      String birthday2;
      if(map['birthday'].toString().length>=10){
        birthday2 = map['birthday'].substring(0,10);
      }else{
        birthday2 = '1970-01-01';
      }

      DateTime birth = DateTime.parse(birthday2);
      var diff = now.difference(birth);
      int age = (diff.inDays/365).toInt();

      Widget w = InkWell(
        onTap: (){
//          Navigator.push(context, MaterialPageRoute(builder: (context)=>new detailPage(map)));
        },
        child: new Card(
            margin: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
            child: Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: new Column(
                children: [
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '姓名：',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        map['name'],
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '年龄：',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        age.toString(),
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '性别：',
                        style: TextStyle(fontSize: 18),
                      ),
                      Flexible(
                        child: Text(
                          (map['sex'] == '0')?'男':'女',
                          style: TextStyle(fontSize: 18),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )),
      );
      temp.add(w);
    }
    return temp;
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('我的患者'),
      ),
      body: ListView(children: cardBuild(),),
    );
  }
}
