import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:yaml/yaml.dart';
import 'package:cloudrecord/untils/http_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'detail.dart';
import 'package:cloudrecord/untils/showAlertDialogClass.dart';

void main() {
  runApp(new MaterialApp(
    title: '',
    theme: new ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: new InqueryCheck(),
  ));
}

class InqueryCheck extends StatefulWidget {
  @override
  _State createState() => new _State();
}

class _State extends State<InqueryCheck> {

  List checkClass = ['other','labortory','picture','invasive','pathology','other'];
  List checkClassCN = ['其他','化验检查','影像检查','侵入式检查','病理学检查','其他'];
  Map checkSubClass = new Map();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getYamlData().then((value){
      checkSubClass = value;
      print(value);
      getId();
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

  var timeValue;
  String uid;
  int timeInt = 1;
  List list = new List();
  getId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('puid')) {
      uid = prefs.getString('puid');
//      getInfo();
      setState(() {

      });
    }
  }

  DateTime sDate = new DateTime.now();
  DateTime eDate = new DateTime.now();
  Future<void> _selectsDate() async //异步
  {
    final DateTime selectdate = await showDatePicker(
      //等待异步处理的结果
      //等待返回
      context: context,
      initialDate: sDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (selectdate == null) return; //点击DatePicker的cancel

    setState(() {
      //点击DatePicker的OK
      sDate = selectdate;
    });
  }
  Future<void> _selecteDate() async //异步
  {
    final DateTime selectdate = await showDatePicker(
      //等待异步处理的结果
      //等待返回
      context: context,
      initialDate: eDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (selectdate == null) return; //点击DatePicker的cancel

    setState(() {
      //点击DatePicker的OK
      eDate = selectdate;
    });
  }

  getDateInfo() async{
    if(sDate.isAfter(eDate)){
      Widget okButton = FlatButton(
        child: Text("好的"),
        onPressed: () {
          Navigator.pop(context);
        },
      );

      List<FlatButton> bottonList = new List();
      bottonList.add(okButton);
      showAlertDialog(context,
          titleText: '日期错误', contentText: '开始日期晚于结束日期', ButtonList: bottonList);
      return;
    }
    Map<String, dynamic> formData = new Map();
    formData['userId'] = uid;
    formData['checkType'] = 5;
    formData['sDate'] = sDate.toIso8601String().substring(0,10);
    formData['eDate'] = eDate.add(Duration(days: 1)).toIso8601String().substring(0,10);
    print(formData);
    DioManager.getInstance().post(
      'CheckRecords',
      formData,
          (data) {
        list.clear();
        list = data["checkRecords"];
        print(list);
        setState(() {

        });
      },
          (error) {
        print(error);
      },
    );
  }



  getInfo() async{
    Map<String, dynamic> formData = new Map();
    formData['userId'] = uid;
    formData['checkType'] = timeInt;
    print(formData);
    DioManager.getInstance().post(
      'CheckRecords',
      formData,
          (data) {
        list.clear();
        list = data["checkRecords"];
        print(list);
        setState(() {

        });
      },
          (error) {
        print(error);
      },
    );
  }

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
    double width_ = MediaQuery.of(context).size.width;

    Container timeScope = new Container(
      color: Colors.lightBlueAccent,
      width: width_,
//      height: width_ * 0.15,
      child: new Column(
        children: [
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                '时间范围:',
                style: TextStyle(fontSize: 18),
              ),
              DropdownButton(
                  value: timeInt,
                  icon: Icon(Icons.arrow_right),
                  iconSize: 40,
                  iconEnabledColor: Colors.green.withOpacity(0.7),
                  hint: Text('请选择时间范围'),
                  items: [
                    DropdownMenuItem(child: Text('三个月'), value: 1),
                    DropdownMenuItem(child: Text('半年'), value: 2),
                    DropdownMenuItem(child: Text('一年'), value: 3),
                    DropdownMenuItem(child: Text('三年'), value: 4)
                  ],
                  onChanged: (value) {
                    timeInt = value;
//                getInfo();
                    print(timeInt);
                    setState(() {
                      timeValue = value;
                    });
                  }),
              RaisedButton(
                onPressed: () {
                  getInfo();
                  print(timeInt);
                  setState(() {});
                },
                color: Colors.blue,
                child: Text(
                  '查询',
                  style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                ),
              )
            ],
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                '自定义:',
                style: TextStyle(fontSize: 18),
              ),
              InkWell(
                child: Text(sDate.toIso8601String().substring(0,10)),
                onTap: _selectsDate,
              ),

              InkWell(
                child: Text(eDate.toIso8601String().substring(0,10)),
                onTap: _selecteDate,
              ),
              RaisedButton(
                onPressed: () {
                  getDateInfo();
                  print(timeInt);
                  setState(() {});
                },
                color: Colors.blue,
                child: Text(
                  '查询',
                  style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                ),
              )
            ],
          ),
        ],
      ),
    );

    List<Widget> cardBuild() {
      List<Widget> temp = new List();
      temp.add(timeScope);
      for (Map map in list) {
        Widget w = InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>new detailPage(map)));
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
                          '检查时间：',
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          map['date'],
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '医院：',
                          style: TextStyle(fontSize: 18),
                        ),
                        Flexible(
                          child: Text(
                            map['hospital'],
                            style: TextStyle(fontSize: 18),
                          ),
                        )
                      ],
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '科室：',
                          style: TextStyle(fontSize: 18),
                        ),
                        Flexible(
                          child: Text(
                            map['section'],
                            style: TextStyle(fontSize: 18),
                          ),
                        )
                      ],
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '检查分类：',
                          style: TextStyle(fontSize: 18),
                        ),
                        Flexible(
                          child: Text(
                            checkClassCN[map['items']],
                            style: TextStyle(fontSize: 18),
                          ),
                        )
                      ],
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '检查种类：',
                          style: TextStyle(fontSize: 18),
                        ),
                        Flexible(
                          child: Text(
                            checkSubClass[checkClass[map['items']]][map['subItems']],
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

    return new Scaffold(
        appBar: new AppBar(
          title: new Text('检查记录查询'),
          centerTitle: true,
        ),
        body: new ListView(
          children: cardBuild(),
        ));
  }
}