import 'package:flutter/material.dart';
import 'package:login_dash_animation/animations/color_loader.dart';
import 'package:login_dash_animation/animations/fadeAnimation.dart';
import 'package:login_dash_animation/components/customButton.dart';
import 'package:login_dash_animation/components/customButtonAnimation.dart';
import 'package:login_dash_animation/screens/loginScreen.dart';
import 'package:login_dash_animation/screens/Menu.dart';




import 'loginScreen.dart';
import 'Menu.dart';



class Fincourse extends StatefulWidget {
  @override
  _FincourseState createState() => _FincourseState();
}
const jaune = const Color(0xfffed136);
const grisFon = const Color(0xff212529);
const jauneFon = const Color(0xffe6b301);
class _FincourseState extends State<Fincourse> {
  @override
  Widget build(BuildContext context) {
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
            padding: EdgeInsets.symmetric(horizontal: 30),
            margin: EdgeInsets.only(top: 80, bottom: 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: <Widget>[

                    Container(
                      margin: EdgeInsets.only( left: 40,top:100),
                      child: FadeAnimation(2.6,Text("Course en cours", style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold
                      ))),
                    ),
                Container(
                  margin: EdgeInsets.only( top:50,left:135),
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
                    SizedBox(height: 20),
                    FadeAnimation(3.2,CustomButtonAnimation(
                      label: "Fin de course",
                      backbround: Colors.white,
                      borderColor: Colors.white,
                      fontColor:jauneFon ,
                      child: Menu(),
                    )),
                    SizedBox(height: 30),
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