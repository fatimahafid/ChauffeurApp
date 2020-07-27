import 'package:flutter/material.dart';
import 'package:login_dash_animation/components/buttonLoginAnimation.dart';
import 'package:login_dash_animation/components/customTextfield.dart';
import 'package:login_dash_animation/screens/dashScreen.dart';
import 'package:login_dash_animation/screens/Menu.dart';
import 'package:login_dash_animation/SizeConfig.dart';



class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset("assets/images/bg2.jpg", fit: BoxFit.cover),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Color(0xFFF001117).withOpacity(0.8),
          ),
          Column(

              children: <Widget>[


],
          ),
        SafeArea(
          child: SingleChildScrollView(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              SizedBox(height: SizeConfig.safeBlockVertical * 5),

              Container(
                padding: EdgeInsets.symmetric(horizontal: SizeConfig.safeBlockHorizontal * 5, vertical: SizeConfig.safeBlockVertical *  5),
                margin:EdgeInsets.only(left:SizeConfig.safeBlockHorizontal * 6,right:SizeConfig.safeBlockHorizontal * 6,bottom: SizeConfig.safeBlockVertical * 8,top: SizeConfig.safeBlockVertical * 10) ,
                height: MediaQuery.of(context).size.height * 0.70,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(SizeConfig.safeBlockHorizontal * 7),
                        topRight: Radius.circular(SizeConfig.safeBlockHorizontal * 7),
                      bottomLeft: Radius.circular(SizeConfig.safeBlockHorizontal * 7),
                      bottomRight: Radius.circular(SizeConfig.safeBlockHorizontal * 7),
                    )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(

                      margin:EdgeInsets.only(left: SizeConfig.safeBlockHorizontal * 5,right:SizeConfig.safeBlockHorizontal * 5,top: SizeConfig.safeBlockVertical * 0) ,
                      child: Text("Authentifier-vous ",
                          textAlign: TextAlign.center,


                          style: TextStyle(
                              color: Color(0xFFF032f41),
                              fontSize: 30,
                            fontFamily: "Pacificio",

                              )),
                    ),
                    SizedBox(height: SizeConfig.safeBlockVertical * 5),
                    Container(
                      height: SizeConfig.safeBlockVertical * 10,
                      child: CustomTextField(
                        label: "Email",
                        icon: Icon(
                          Icons.mail,
                          size: 27,
                          color: Color(0xFFF032f41),
                        ),
                      ),
                    ),

                    SizedBox(height: SizeConfig.safeBlockVertical * 4),
                    Container(
                      height: SizeConfig.safeBlockVertical * 10,

                      child: CustomTextField(
                        label: "Password",
                        isPassword: true,
                        icon: Icon(
                          Icons.https,
                          size: 27,
                          color: Color(0xFFF032f41),
                        ),
                      ),
                    ),
                    SizedBox(height: SizeConfig.safeBlockVertical * 5),
                    ButtonLoginAnimation(
                      label: "Se connecter",
                      fontColor: Colors.white,
                      background: Color(0xffe6b301),
                      borderColor: Color(0xffe6b301),
                      child: Menu(),
                    )
                            ],
                ),

              )
            ],
          ),
          ),
        ),
    ],
      ),
    );


  }
}
