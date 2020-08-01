import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:login_dash_animation/animations/color_loader.dart';
import 'package:login_dash_animation/animations/fadeAnimation.dart';
import 'package:login_dash_animation/components/customButton.dart';
import 'package:login_dash_animation/components/customButtonAnimation.dart';
import 'package:login_dash_animation/screens/loginScreen.dart';
import 'package:login_dash_animation/screens/Menu.dart';
import 'package:login_dash_animation/SizeConfig.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:mysql1/mysql1.dart' hide Row;






class Fincourse extends StatefulWidget {

  @override
  _FincourseState createState() => _FincourseState();
}
const jauneFon = const Color(0xffe6b301);

class _FincourseState extends State<Fincourse> {

  var courseId;
  var tablename='';



  static Future<MySqlConnection> getConnection() async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: '10.0.2.2', port: 3306, user: 'root', db: 'taxiapp'));
    return conn;
  }

  getTablename() async
  {
    var nom=await FlutterSession().get("tablename");
    setState(() {
      tablename = nom;
    });

    print("session : "+tablename.toString());
  }

  getCourseId() async
  {
    var id=await FlutterSession().get("courseId");
    setState(() {
      courseId = id;
    });

    print("test de session"+courseId.toString());
  }

  fincourse(){
    getTablename();
    getCourseId();
    getConnection().then((conn) async {
      var result = await conn.query(

          'delete from ${tablename} where id=?',
          [courseId
          ]);

    });

  }


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Color(0xffe6b301).withOpacity(0.7),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.safeBlockHorizontal * 9),
            margin: EdgeInsets.only(top: SizeConfig.safeBlockVertical * 5, bottom: SizeConfig.safeBlockVertical * 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: <Widget>[

                    Container(
                      margin: EdgeInsets.only( left: SizeConfig.safeBlockHorizontal * 4,top:SizeConfig.safeBlockHorizontal * 20),
                      child: FadeAnimation(2.6,Text("Course en cours", style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold
                      ))),
                    ),
                Container(
                  margin: EdgeInsets.only( top:SizeConfig.safeBlockHorizontal * 20,left: SizeConfig.safeBlockHorizontal * 29),
                  width: 100,
                  height: 100,

                    child: ColorLoader3(
                    //  colors: [Colors.white,Colors.white,Colors.white,Colors.white,Colors.white],duration: Duration(microseconds: 50000),
                radius: 50,
                      dotRadius:6,

                    ),

                ),


                  ],
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () {
                        fincourse();

                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          side: BorderSide(color: Colors.white)),
                      color: Colors.white ,
                      textColor: Color(0xffe6b301),

                      child: Container(
                        height: SizeConfig.safeBlockVertical * 9,
                        width: double.infinity,
                        child: Row(
                          children: <Widget>[
                            Center(
                              child: Container(

                                margin: EdgeInsets.only(left: SizeConfig.safeBlockHorizontal * 18),

                                padding: EdgeInsets.only(left:SizeConfig.safeBlockHorizontal * 3,right: SizeConfig.safeBlockHorizontal * 7),
                                child: Text("Fin de course", style: TextStyle(
                                  color: Color(0xffe6b301),
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,


                                )),
                              ),
                            ),
                            SizedBox(width: 0),

                          ],
                        ),
                      ),),
                    SizedBox(height: SizeConfig.safeBlockHorizontal * 2),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}