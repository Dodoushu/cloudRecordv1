import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:cloudrecord/patient/inquery/patient/inqueryPatient.dart';
import 'package:cloudrecord/patient/inquery/inhospital/inqueryinhospital.dart';
import 'package:cloudrecord/patient/inquery/bodycheck/inquerybodycheck.dart';
import 'package:cloudrecord/patient/inquery/check/inqueryCheck.dart';
import 'package:cloudrecord/patient/inquery/dieaseHistory/dieaseHistoryCheck.dart';
import 'package:cloudrecord/patient/inquery/selfCheck/menu.dart' as inqueryselfcheckmenu;
import 'package:cloudrecord/patient/myDoctor/menu.dart' as myDoctorPageMenu;

void main() => runApp(new MaterialApp(
  home: RecordInquery('11'),
));

class RecordInquery extends StatefulWidget {
  String uid;
  RecordInquery(String uid){
    this.uid = uid;
  }
  @override
  State createState() => new _mainPage(uid);
}

class _mainPage extends State<RecordInquery> with SingleTickerProviderStateMixin {

  _mainPage(String uid){
    this.uid = uid;
    setId();
  }

  setId()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("puid", uid);
  }

  String name = '姓名';
  String age = '28';
  String sex = '男';
  String uid;


  @override
  void initState() {
    super.initState();
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
            ],
          ),
        ));



    return Scaffold(
        appBar: AppBar(
          title: new Text('病历查询'),
          centerTitle: true,
        ),
        body: Container(
          child: Column(
            children: <Widget>[InquireMenu],
          ),
        ),);
  }
}
