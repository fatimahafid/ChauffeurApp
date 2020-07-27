import 'package:flutter/material.dart';
import 'package:login_dash_animation/animations/color_loader.dart';
import 'package:login_dash_animation/animations/fadeAnimation.dart';
import 'package:login_dash_animation/components/customButton.dart';
import 'package:login_dash_animation/components/customButtonAnimation.dart';
import 'package:login_dash_animation/screens/loginScreen.dart';
import 'package:login_dash_animation/screens/Menu.dart';
import 'package:login_dash_animation/SizeConfig.dart';





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
                    FadeAnimation(3.2,CustomButtonAnimation(

                      label: "Fin de course",
                      backbround: Colors.white,
                      borderColor: Colors.white,
                      fontColor:jauneFon ,
                      child: Menu(),
                    )),
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