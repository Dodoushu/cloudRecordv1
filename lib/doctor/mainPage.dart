import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'doctorCheck.dart';
import 'patientManager/patientQuery/query.dart';
import 'package:cloudrecord/doctor/patientManager/menu.dart' as patientManagerMenu;

void main() => runApp(new MaterialApp(
      home: MainPage(),
    ));

class MainPage extends StatefulWidget {
  @override
  State createState() => new _mainPage();
}

class _mainPage extends State<MainPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setInfo();
    Future.delayed(new Duration(milliseconds: 300)).then((value) {
      setState(() {
      });
    });
  }

  void setInfo()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = name + prefs.get('name')+"1312313231";
    jobTitle = jobTitle + prefs.get('jobTitle') +"1312313231";
    hospital = hospital + prefs.get('hospital') +"1312313231";
    section = section + prefs.get('section') +"1312313231";
    approve = prefs.get("approve");
//    name = CutString(name);
//    jobTitle = CutString(jobTitle);
//    hospital = CutString(hospital);
//    section = CutString(section);
    setState(() {

    });
  }
  String CutString(String string)
  {
    if(string.length > 6)
      {
        return string.substring(0,6) + "..";
      }
  }

  String name = '姓名: 222222';
  String jobTitle = '职称: 222222';
  String hospital = '医院: 222222';
  String section = '科室: ';
  String approve = '0';

  @override
  Widget build(BuildContext context) {


    Widget buildApprove(){
      if(approve == '1'){
        return Container(
//          padding: EdgeInsets.all(20),
          child: RaisedButton(
            child: new Text(
              '已认证',
              style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.black54),
            ),
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(10.0)), onPressed: () {  },
          ),
        );
      }else{
        return Container(
          margin: EdgeInsets.all(5),
          child: RaisedButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> new DoctorCheck()));
            },
            child: new Text(
              '点击认证',
              style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.black54),
            ),
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(10.0)),
          ),
        );
      }
    }
    double width_ = MediaQuery.of(context).size.width;
    Widget bar = new Container(
      //宽度
      width: width_,
      //高度
      height: width_ * 0.4,
      // 盒子样式
      decoration: new BoxDecoration(
        color: Colors.lightBlueAccent,
        //设置Border属性给容器添加边框
        border: new Border.all(
          //为边框添加颜色
          color: Colors.black54,
          width: 0, //边框宽度
        ),
      ),
      child: Container(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            new Container(
              //宽度
              width: width_ * 0.1 * (4 / 7),
              //高度
              height: width_ * 0.3 * (4 / 7),
              // 盒子样式
              child: Icon(
                Icons.android,
                size: 60,
              ),
            ),
            new Container(
              width: width_* 0.5,
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                          name,
                          maxLines: 1,
                          style: new TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                    Text(
                          jobTitle,
                          maxLines: 1,
                          style: new TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                      ),

                    Text(
                          hospital,
                          maxLines: 1,
                          style: new TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                    Text(
                          section,
                          maxLines: 1,
                          style: new TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                  ],
                ),
            ),
          ],
        ),
      ),
    );

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
      //宽度
      width: width_,
//      // 盒子样式
//      decoration: new BoxDecoration(
//        color: Colors.black12,
//        //设置Border属性给容器添加边框
//        border: new Border.all(
//          //为边框添加颜色
//          color: Colors.black,
//          width: 0, //边框宽度
//        ),
//      ),
      child: new Container(
        child: new Column(
          children: [
            Container(padding: EdgeInsets.only(top: 30),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buttonBuilder('患者管理', Icons.beenhere, (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => new patientManagerMenu.menu()));
                  }),
                  Container(width: width_ / 5,),
                  Container(width: width_ / 5,)
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
          '主界面',
        ),
        centerTitle: true,
        actions: <Widget>[
          buildApprove()
        ],
      ),
      body: ListView(
        children: <Widget>[bar,menu],
      ),
    );
  }
}
