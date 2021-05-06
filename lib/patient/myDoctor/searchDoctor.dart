import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    title: '',
    theme: new ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: new DoctorSearch(),
  ));
}

class DoctorSearch extends StatefulWidget {
  @override
  _State createState() => new _State();
}

class _State extends State<DoctorSearch> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    doctorList = [
      {'id': '主治医师', 'name': '张一', 'info1': '陕西省第二人民医院', 'select': true},
      {'id': '主治医师', 'name': '张二', 'info1': '山西大学附属医院', 'select': false},
      {'id': '主治医师', 'name': '张三', 'info1': '校医院', 'select': false},
      {'id': '主治医师', 'name': '张四', 'info1': '西交附属医院', 'select': true},
      {'id': '主治医师', 'name': '张五', 'info1': '口腔整形医院', 'select': false},
      {'id': '主治医师', 'name': '张六', 'info1': '中日友好医院', 'select': true},
      {'id': '主治医师', 'name': '张七', 'info1': '协和医院', 'select': false}
    ];
  }

  List doctorList = new List();

  @override
  Widget build(BuildContext context) {
    double width_ = MediaQuery.of(context).size.width;


    Drawer rightDraw = Drawer(
        elevation: 16.0,
        child: Container(
          padding: EdgeInsets.only(right: 20,top: 40,left: 20),
          child:
          Column(
            children: <Widget>[
              new Row(
                children: [Text('姓名：'),Container()],
              ),
              new TextFormField(
                decoration: new InputDecoration(
                  labelText: '请输入医生姓名',
                  labelStyle: new TextStyle(
                      fontSize: 15.0,
                      color: Color.fromARGB(255, 93, 93, 93)),
                  border: InputBorder.none,
                ),
                onChanged: (value) {

                },
              ),
              new Row(
                children: [Text('科室：'),Container()],
              ),
              new TextFormField(
                decoration: new InputDecoration(
                  labelText: '请输入医生科室',
                  labelStyle: new TextStyle(
                      fontSize: 15.0,
                      color: Color.fromARGB(255, 93, 93, 93)),
                  border: InputBorder.none,
                ),
                onChanged: (value) {

                },
              ),
              new Row(
                children: [Text('单位：'),Container()],
              ),
              new TextFormField(
                decoration: new InputDecoration(
                  labelText: '请输入医生单位',
                  labelStyle: new TextStyle(
                      fontSize: 15.0,
                      color: Color.fromARGB(255, 93, 93, 93)),
                  border: InputBorder.none,
                ),
                onChanged: (value) {

                },
              ),
              new Container(
                padding: EdgeInsets.all(0),
                height: 50.0,
                margin: EdgeInsets.only(top: 40.0),
                child: new SizedBox.expand(
                  child: new RaisedButton(
                    elevation: 20,
                    onPressed: (){
                      doctorList.removeLast();
                      Navigator.pop(context);
                      setState(() {

                      });
                    },
                    color: Colors.blue,
                    child: new Text(
                      '确定',
                      style: TextStyle(
                          fontSize: 14.0,
                          color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(40.0)),
                  ),
                ),
              ),
            ],
          ),

        ));
    Column buildDoctorList() {
      var CheckoxListTitleList = List<Widget>();
      for (Map map in doctorList) {
        CheckoxListTitleList.add(new Card(
          margin: EdgeInsets.only(top: 10, right: 10, left: 10),
          child: new Row(
            children: [
              Container(
                padding: EdgeInsets.only(right: 15, left: 15),
                child: Image.network(
                  'https://www.easyicon.net/api/resizeApi.php?id=1281067&size=128',
                  scale: 2.5,
                ),
              ),
              Container(
                width: width_ * 0.1,
              ),
              new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(map['name']),
                      Container(
                        width: width_ * 0.1,
                      ),
                      Text(map['id'] == null ? '职称不详' : map['id'])
                    ],
                  ),
                  Text(map['info1'] == null ? '医院不详' : map['info1']),
                ],
              ),
            ],
          ),
        ));
      }
      return new Column(
        children: CheckoxListTitleList,
      );
    }

    return new Scaffold(
        endDrawer: rightDraw,
        appBar: new AppBar(
          title: new Text('医生搜索'),
          centerTitle: true,
          actions: <Widget>[
            Builder(
              builder: (context) => Center(
                child: RaisedButton(
                  child: Text('筛选'),
                  onPressed: () => Scaffold.of(context).openEndDrawer(),
                ),
              ),
            ),
          ],
        ),
        body: ListView(
          children: <Widget>[buildDoctorList()],
        ));
  }
}
