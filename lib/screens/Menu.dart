import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_dash_animation/components/buttonLoginAnimation.dart';
import 'package:login_dash_animation/components/customTextfield.dart';
import 'package:login_dash_animation/screens/dashScreen.dart';
import 'package:login_dash_animation/screens/editProfile.dart';
import 'package:login_dash_animation/screens/loginScreen.dart';
import 'package:login_dash_animation/screens/Fincourse.dart';
import 'package:login_dash_animation/screens/modifierVehicule.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:login_dash_animation/SizeConfig.dart';
import 'package:login_dash_animation/SizeConfig.dart';



class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset("assets/images/bg2.jpg", fit: BoxFit.cover),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Color(0xFFF001117).withOpacity(0.7),
          ),
          Container(
            padding: EdgeInsets.only(left: SizeConfig.safeBlockVertical * 2, top: SizeConfig.safeBlockVertical *7, right: SizeConfig.safeBlockHorizontal *4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 33.0,
                  semanticLabel: '',
                ),
                Row(
                  children: <Widget>[
                    Text(
                      "Farah ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontFamily: "Pacificio",
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    Container(
                      width: SizeConfig.safeBlockHorizontal * 14,
                      height: SizeConfig.safeBlockVertical * 10,
                      child: CircleAvatar(
                        radius: 50.0,
                        backgroundImage: AssetImage('assets/images/farah.jpg'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                SizedBox(height:  SizeConfig.safeBlockVertical * 15),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(SizeConfig.safeBlockHorizontal * 20),
                      topRight: Radius.circular( SizeConfig.safeBlockHorizontal * 20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12.withOpacity(0.3),
                        spreadRadius: 4,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  padding: EdgeInsets.only( left: SizeConfig.safeBlockHorizontal * 4, top: SizeConfig.safeBlockVertical * 0),
                  height: MediaQuery.of(context).size.height * 0.80,
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(

                  child: Container(
                    padding: EdgeInsets.only(left: SizeConfig.safeBlockVertical * 2,right: SizeConfig.safeBlockHorizontal *4),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            new GestureDetector(
                              onTap: () {
                                /* AlertDialog(
                                  title: Text("Êtes-vous sur place ?"),
                                  content: Text("En cliquant sur OUI vous faite partie de la file d'attente."),
                                  actions: [
                                    FlatButton("Non"),
                                    FlatButton("Oui"),
                                  ],
                                  elevation : 24.0,
                                  shape: CircleBorder(),
                                );
                                showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(),
                                  barrierDismissible: true,
                                );*/
                                return Alert(
                                  context: context,
                                  type: AlertType.success,
                                  title: "Succès",
                                  desc: "Vous êtes ajoutés à la file d'attente.",
                                  buttons: [
                                    DialogButton(


                                      child: Text(

                                        "Ok",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),

                                      onPressed: () => Navigator.pop(context),
                                      width: 120,
                                    )
                                  ],
                                ).show();
                              },
                              child: Container(
                                padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 2),
                                margin: EdgeInsets.only(top: SizeConfig.safeBlockVertical * 11, right: SizeConfig.safeBlockHorizontal * 3),
                                width: SizeConfig.safeBlockHorizontal * 42,
                                height: SizeConfig.safeBlockVertical * 30,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                    bottomLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12.withOpacity(0.3),
                                      spreadRadius: 2,
                                      blurRadius: 7,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(top: SizeConfig.safeBlockVertical * 3),
                                      child: Text('Je suis pret',
                                          style: TextStyle(
                                            fontSize: 22,
                                          ),
                                          textAlign: TextAlign.center),
                                    ),

                                    Container(
                                        //width: 50.0,
                                        //height: 50.0,
                                        margin: EdgeInsets.only(top: SizeConfig.safeBlockVertical * 4),
                                        padding: const EdgeInsets.all(
                                            12), //I used some padding without fixed width and height
                                        decoration: new BoxDecoration(
                                          shape: BoxShape
                                              .circle, // You can use like this way or like the below line
                                          //borderRadius: new BorderRadius.circular(30.0),
                                          color: Color(0xffe6b301),
                                        ),
                                        child: Icon(Icons.check,
                                            color: Colors.white,
                                            size: 33)), //............
                                  ],
                                ),
                              ),
                            ),
                            new GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Fincourse()),
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 2),
                                margin: EdgeInsets.only(top: SizeConfig.safeBlockVertical * 11, right: SizeConfig.safeBlockHorizontal * 0),
                                width: SizeConfig.safeBlockHorizontal * 43,
                                height: SizeConfig.safeBlockVertical * 30,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                    bottomLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12.withOpacity(0.3),
                                      spreadRadius: 2,
                                      blurRadius: 7,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: <Widget>[
                                    Text('Course commencée',
                                        style: TextStyle(
                                          fontSize: 22,
                                        ),
                                        textAlign: TextAlign.center),
                                    Container(
                                        //width: 50.0,
                                        //height: 50.0,
                                        margin: EdgeInsets.only(top: SizeConfig.safeBlockVertical * 4),
                                        padding: const EdgeInsets.all(
                                            10), //I used some padding without fixed width and height
                                        decoration: new BoxDecoration(
                                          shape: BoxShape
                                              .circle, // You can use like this way or like the below line
                                          //borderRadius: new BorderRadius.circular(30.0),
                                          color: Color(0xffe6b301),
                                        ),
                                        child: Icon(Icons.check,
                                            color: Colors.white,
                                            size: 33)), //............
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            new GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ModifierVehicule()),
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 2),
                                margin: EdgeInsets.only(top: SizeConfig.safeBlockVertical * 3, right: SizeConfig.safeBlockHorizontal * 3),
                                width: SizeConfig.safeBlockHorizontal * 42,
                                height: SizeConfig.safeBlockVertical * 30,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                    bottomLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12.withOpacity(0.3),
                                      spreadRadius: 2,
                                      blurRadius: 7,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(top: SizeConfig.safeBlockVertical * 2),

                                      child: Text('Véhicule',
                                          style: TextStyle(
                                            fontSize: 22,
                                          ),
                                          textAlign: TextAlign.center),
                                    ),
                                    Container(
                                        //width: 50.0,
                                        //height: 50.0,
                                        margin: EdgeInsets.only(top: SizeConfig.safeBlockVertical * 4),
                                        padding: const EdgeInsets.all(
                                            12), //I used some padding without fixed width and height
                                        decoration: new BoxDecoration(
                                          shape: BoxShape
                                              .circle, // You can use like this way or like the below line
                                          //borderRadius: new BorderRadius.circular(30.0),
                                          color: Color(0xffe6b301),
                                        ),
                                        child: Icon(Icons.create,
                                            color: Colors.white,
                                            size: 33)), //............
                                  ],
                                ),
                              ),
                            ),
                            new GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditProfil()),
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 2),
                                margin: EdgeInsets.only(top: SizeConfig.safeBlockVertical * 3, right: SizeConfig.safeBlockHorizontal * 0),
                                width: SizeConfig.safeBlockHorizontal * 43,
                                height: SizeConfig.safeBlockVertical * 30,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                    bottomLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12.withOpacity(0.3),
                                      spreadRadius: 2,
                                      blurRadius: 7,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(top: SizeConfig.safeBlockVertical * 2),

                                      child: Text('Profile',
                                          style: TextStyle(
                                            fontSize: 22,
                                          ),
                                          textAlign: TextAlign.center),
                                    ),
                                    Container(
                                        //width: 50.0,
                                        //height: 50.0,
                                        margin: EdgeInsets.only(top: SizeConfig.safeBlockVertical * 4),
                                        padding: const EdgeInsets.all(
                                            12), //I used some padding without fixed width and height
                                        decoration: new BoxDecoration(
                                          shape: BoxShape
                                              .circle, // You can use like this way or like the below line
                                          //borderRadius: new BorderRadius.circular(30.0),
                                          color: Color(0xffe6b301),
                                        ),
                                        child: Icon(Icons.create,
                                            color: Colors.white,
                                            size: 33)), //............
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 40),
                      ],
                    ),
                  ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/*
Card(
child: Padding(
padding: EdgeInsets.only(top:30,left: 10,bottom:30,right: 10),
child: Row(
children: <Widget>[
Text('premiere option', style: TextStyle(
fontSize: 20,)),
SizedBox(
width: 150.0,
),
Container(
decoration: new BoxDecoration(
shape: BoxShape.circle,// You can use like this way or like the below line
//borderRadius: new BorderRadius.circular(30.0),
color: Color(0xffe6b301),
),
child:Icon(Icons.arrow_forward, color: Colors.white,size: 40)
),


],
),
),
color: Colors.white,
),


SizedBox(height: 5),
Card(
child: Padding(
padding: EdgeInsets.only(top:30,left: 10,bottom:30,right: 10),
child: Row(
children: <Widget>[
Text('premiere option', style: TextStyle(
fontSize: 20,)),
SizedBox(
width: 150.0,
),
Container(
decoration: new BoxDecoration(
shape: BoxShape.circle,// You can use like this way or like the below line
//borderRadius: new BorderRadius.circular(30.0),
color: Color(0xffe6b301),
),
child:Icon(Icons.arrow_forward, color: Colors.white,size: 40)
),


],
),
),
color: Colors.white,
),


SizedBox(height: 5),
Card(
child: Padding(
padding: EdgeInsets.only(top:30,left: 10,bottom:30,right: 10),
child: Row(
children: <Widget>[
Text('premiere option', style: TextStyle(
fontSize: 20,)),
SizedBox(
width: 150.0,
),
Container(
decoration: new BoxDecoration(
shape: BoxShape.circle,// You can use like this way or like the below line
//borderRadius: new BorderRadius.circular(30.0),
color: Color(0xffe6b301),
),
child:Icon(Icons.arrow_forward, color: Colors.white,size: 40)
),


],
),
),
color: Colors.white,
),


SizedBox(height: 5),
Card(
child: Padding(
padding: EdgeInsets.only(top:30,left: 10,bottom:30,right: 10),
child: Row(
children: <Widget>[
Text('premiere option', style: TextStyle(
fontSize: 20,)),
SizedBox(
width: 150.0,
),
Container(
decoration: new BoxDecoration(
shape: BoxShape.circle,// You can use like this way or like the below line
//borderRadius: new BorderRadius.circular(30.0),
color: Color(0xffe6b301),
),
child:Icon(Icons.arrow_forward, color: Colors.white,size: 40)
),


],
),
),
color: Colors.white,
),


SizedBox(height: 5),*/
