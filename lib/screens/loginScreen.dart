import 'package:flutter/material.dart';
import 'package:login_dash_animation/components/buttonLoginAnimation.dart';
import 'package:login_dash_animation/components/customTextfield.dart';
import 'package:login_dash_animation/screens/dashScreen.dart';
import 'package:login_dash_animation/screens/Menu.dart';


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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              SizedBox(height: 20),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                margin:EdgeInsets.only(left:20,right:20,bottom: 50) ,
                height: MediaQuery.of(context).size.height * 0.70,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    )),
                child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(

                      margin:EdgeInsets.only(left:20,right:20,top: 0) ,
                      child: Text("Authentifier-vous ",
                          textAlign: TextAlign.center,


                          style: TextStyle(
                              color: Color(0xFFF032f41),
                              fontSize: 30,
                            fontFamily: "Pacificio",

                              )),
                    ),
                    SizedBox(height: 40),
                    CustomTextField(
                      label: "Email",
                      icon: Icon(
                        Icons.mail,
                        size: 27,
                        color: Color(0xFFF032f41),
                      ),
                    ),

                    SizedBox(height: 20),
                    CustomTextField(
                      label: "Password",
                      isPassword: true,
                      icon: Icon(
                        Icons.https,
                        size: 27,
                        color: Color(0xFFF032f41),
                      ),
                    ),
                    SizedBox(height: 40),
                    ButtonLoginAnimation(
                      label: "Se connecter",
                      fontColor: Colors.white,
                      background: Color(0xffe6b301),
                      borderColor: Color(0xffe6b301),
                      child: Menu(),
                    )
                            ],
                ),
                ),
              )
            ],
          ),
        ),
    ],
      ),
    );


  }
}
