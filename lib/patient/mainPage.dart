import 'package:cloudrecord/patient/MessageRecord.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'outPatientMedical/menu.dart' as outpatientMenu;
import 'inHospital/menu.dart' as inHospitalMenu;
import 'physicalExamination/menu.dart' as physicalExamination;
import 'diseaseHistory/diseaseHistory.dart';
import 'selfCheck/menu.dart' as selfCheckMenu;
import 'CheckRecord/menu.dart' as CheckRecordMenu;
import 'package:cloudrecord/patient/inquery/patient/inqueryPatient.dart';
import 'package:cloudrecord/patient/inquery/inhospital/inqueryinhospital.dart';
import 'package:cloudrecord/patient/inquery/bodycheck/inquerybodycheck.dart';
import 'package:cloudrecord/patient/inquery/check/inqueryCheck.dart';
import 'package:cloudrecord/patient/inquery/dieaseHistory/dieaseHistoryCheck.dart';
import 'package:cloudrecord/patient/inquery/selfCheck/menu.dart' as inqueryselfcheckmenu;
import 'package:cloudrecord/patient/myDoctor/menu.dart' as myDoctorPageMenu;

void main() => runApp(new MaterialApp(
      home: MainPage(),
    ));

class MainPage extends StatefulWidget {
  @override
  State createState() => new _mainPage();
}

class _mainPage extends State<MainPage> with SingleTickerProviderStateMixin {
  String name = '姓名';
  String age = '28';
  String sex = '男';
  String userid;
  void setPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString('name');
    age = prefs.get('age');
    sex = (prefs.get('sex') == '0')?'男':'女';
    userid = prefs.getString('uid');
    setState(() {

    });
  }

  var tabController; // 先声明变量

  @override
  void initState() {
    super.initState();
    this.tabController = new TabController(
        vsync: this, // 动画效果的异步处理
        length: 3 // tab 个数
        );
    setPage();
  }

  @override
  void dispose() {
    this.tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width_ = MediaQuery.of(context).size.width;

    Widget buttonBuilder(
        String text, IconData icondata, Function clickFunction) {
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

    Widget InquireMenu = new Container(
        width: width_,
        child: new Container(
          child: new Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 30),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    buttonBuilder('门诊记录查询', Icons.border_all, () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => InqueryPatient()));
                    }),
                    buttonBuilder('住院记录查询', Icons.book, () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => InqueryInhospital()));
                    }),
                    buttonBuilder('体检记录查询', Icons.card_travel, () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => InqueryBodycheck()));
                    }),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 30),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    buttonBuilder('检查记录查询', Icons.print, () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => InqueryCheck()));
                    }),
                    buttonBuilder('病症自检查询', Icons.beenhere, () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => inqueryselfcheckmenu.menu()));
                    }),
                    buttonBuilder('既往病史查询', Icons.perm_identity, () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DieaseHistoryCheck()));
                    }),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 30),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    buttonBuilder('留言查询', Icons.sms, () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MessageRecord(userid)));
                    }),
                    Container(width: width_/5,),
                    Container(width: width_/5,),
                  ],
                ),
              ),
            ],
          ),
        ));

    Widget menu = new Container(
        //宽度
        width: width_,
        child: new Container(
          child: new Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 30),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    buttonBuilder('门诊记录', Icons.border_all, () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => outpatientMenu.menu()));
                    }),
                    buttonBuilder('住院记录', Icons.book, () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => inHospitalMenu.menu()));
                    }),
                    buttonBuilder('体检记录', Icons.card_travel, () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  physicalExamination.menu()));
                    }),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 30),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    buttonBuilder('检查记录', Icons.print, () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CheckRecordMenu.menu()));
                    }),
                    buttonBuilder('病症自检', Icons.beenhere, () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => selfCheckMenu.menu()));
                    }),
                    buttonBuilder('既往病史', Icons.perm_identity, () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => diseaseHistory()));
                    }),


                  ],
                ),
              ),
            ],
          ),
        ));

    Widget myDoctorMenu = new Container(
      //宽度
        width: width_,
        child: new Container(
          child: new Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 30),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    buttonBuilder('我的医生', Icons.perm_identity, () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => myDoctorPageMenu.menu()));
                    }),
                    Container(width: width_ / 5,),
                    Container(width: width_ / 5,),
                  ],
                ),
              ),
            ],
          ),
        ));

    return Scaffold(
        appBar: AppBar(
          title: new TabBar(
            controller: this.tabController,
            indicatorColor: Colors.white,
            //这表示当标签栏内容超过屏幕宽度时是否滚动
            isScrollable: false,
            //标签颜色
            labelColor: Colors.orange,
            //未被选中的标签的颜色
            unselectedLabelColor: Colors.white,
            labelStyle: new TextStyle(fontSize: 16.0),
            tabs: <Tab>[
              new Tab(
                text: '记录录入',
              ),
              new Tab(
                text: '记录查询',
              ),
              new Tab(
                text: '我的医生',
              ),
            ],
          ),
          centerTitle: true,
        ),
        body: new TabBarView(controller: this.tabController, children: [
          //第一个页面 记录录入
          Container(
            child: Column(
              children: <Widget>[menu],
            ),
          ),

          //第二个页面 记录查询
          Container(
            child: Column(
              children: <Widget>[InquireMenu],
            ),
          ),

          //第三个页面 我的医生
          Container(
            child: Column(
              children: <Widget>[myDoctorMenu],
            ),
          )
        ]));
  }
}
