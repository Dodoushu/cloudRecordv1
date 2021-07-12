import 'package:cloudrecord/doctor/patientManager/patientQuery/patientResult.dart';
import 'package:flutter/material.dart';

import 'package:cloudrecord/untils/showToast.dart';
import 'package:cloudrecord/doctor/patientManager/patientQuery/query.dart';
import 'authorized.dart';
import 'applyingList.dart';

void main() {
  runApp(new MaterialApp(
    title: '',
    theme: new ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: new menu(),
  ));
}

class menu extends StatefulWidget {
  @override
  _State createState() => new _State();
}

class _State extends State<menu> {
  @override
  Widget build(BuildContext context) {

    double width_ = MediaQuery.of(context).size.width;

    Widget buttonBuilder(String text, IconData icondata, Function clickFunction) {
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

    Widget menu = new Container(
        width: width_,
        child: new Container(
          child: new Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 30),
                child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        buttonBuilder('患者查询', Icons.search, (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Query()));
                        }),
                        buttonBuilder('查看患者列表', Icons.people, (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Authorized(1)));
                        }),
                        buttonBuilder('查看授权申请', Icons.menu, (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Applying()));
                        }),

//                    Container(width: width_ / 5,),
//                    buttonBuilder('检查记录', Icons.keyboard, (){
//                      ShowToast.getShowToast().showToast('尚未开放');
//                    }),
//                    Container(width: width_ / 5,),
                      ],
                    ),
//                    Row(
//                      mainAxisAlignment: MainAxisAlignment.spaceAround,
//                      children: <Widget>[
//                        buttonBuilder('患者留言', Icons.search, (){
//                          Navigator.push(context, MaterialPageRoute(builder: (context) => Query()));
//                        }),
//                        buttonBuilder('留言记录', Icons.people, (){
//                          Navigator.push(context, MaterialPageRoute(builder: (context) => Authorized()));
//                        }),
//                        Container(width: width_ / 5,),
//                      ],
//                    ),


              ),
              Container(
                padding: EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      buttonBuilder('患者留言', Icons.sms, (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Authorized(3)));
                      }),
                      buttonBuilder('留言记录', Icons.list, (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Authorized(2)));
                      }),
                      Container(width: width_ / 3.9,),
                    ],
                ),



              ),
            ],
          ),
        )
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '患者管理',
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[menu],
      ),
    );
  }
}


