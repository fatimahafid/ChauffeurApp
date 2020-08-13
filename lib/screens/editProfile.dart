import 'package:flutter/material.dart';
import 'package:login_dash_animation/components/buttonLoginAnimation.dart';
import 'package:login_dash_animation/components/customTextfield.dart';
import 'package:login_dash_animation/screens/Menu.dart';
import 'package:login_dash_animation/screens/ajouterVehicule.dart';
import 'package:login_dash_animation/SizeConfig.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:flutter/src/widgets/basic.dart' as row;
import 'package:login_dash_animation/screens/loginScreen.dart';
import 'package:mysql1/mysql1.dart';
import 'package:password/password.dart';
import 'package:crypto/crypto.dart' as crypto;
import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:shared_preferences/shared_preferences.dart';


class EditProfil extends StatefulWidget {
  @override
  _EditProfilState createState() => _EditProfilState();
}

enum SingingCharacter { homme, femme }

class _EditProfilState extends State<EditProfil> {
  int group = 1;
  int userId;
  String userName;
  String userPrenom;
  String userCin;
  String userTel;
  String userLogin;
  String userPassword;
  int userSexe;
  SingingCharacter _character ;
  final loginController = TextEditingController();
  final nomController = TextEditingController();
  final prenomController = TextEditingController();
  final cinController = TextEditingController();
  final telController = TextEditingController();
  final mdpController = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    loginController.dispose();
    nomController.dispose();
    prenomController.dispose();
    cinController.dispose();
    telController.dispose();
    mdpController.dispose();
    super.dispose();
  }

  _printLatestValue() {
    print("Second text field: ${loginController.text}");
  }

  getUser() async {
    var id = await FlutterSession().get("id");
    var nom = await FlutterSession().get("nom");
    var prenom = await FlutterSession().get("prenom");
    var cin = await FlutterSession().get("cin");
    var numTel = await FlutterSession().get("numTel");
    var login = await FlutterSession().get("login");
    var password = await FlutterSession().get("password");
    var sexe = await FlutterSession().get("sexe");
    var numTaxi = await FlutterSession().get("numTaxi");

    setState(() {
      userId = id;
    });
    setState(() {
      userName = nom;
      nomController.text = userName;
    });
    setState(() {
      userCin = cin;
      cinController.text = userCin;
    });
    setState(() {
      userTel = numTel;
      telController.text = userTel;
    });
    setState(() {
      userPrenom = prenom;
      prenomController.text = userPrenom;
    });
    setState(() {
      userLogin = login;
      loginController.text = userLogin;
    });
    setState(() {
      userPassword = password;
    });
    setState(() {
      userSexe = sexe;
    });
    print("test de session profil" +
        userId.toString() +
        " / " +
        userName +
        " / " +
        numTaxi.toString());
  }

  @override
  void initState() {
    loginController.addListener(() {
      _printLatestValue();
    });
    getUser();
    return super.initState();
  }

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
            children: <Widget>[],
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  SizedBox(height: SizeConfig.safeBlockHorizontal * 20),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.safeBlockHorizontal * 5,
                        vertical: SizeConfig.safeBlockHorizontal * 6),
                    margin: EdgeInsets.only(
                        left: SizeConfig.safeBlockHorizontal * 5,
                        right: SizeConfig.safeBlockHorizontal * 5,
                        bottom: SizeConfig.safeBlockHorizontal * 5),
                    height: MediaQuery.of(context).size.height * 0.8,
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
                            margin: EdgeInsets.only(
                                left: SizeConfig.safeBlockHorizontal * 5,
                                right: SizeConfig.safeBlockHorizontal * 5,
                                top: SizeConfig.safeBlockHorizontal * 0),
                            child: Text("Profil",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFFF032f41),
                                  fontSize: 30,
                                  fontFamily: "Pacificio",
                                )),
                          ),
                          SizedBox(height: SizeConfig.safeBlockHorizontal * 4),
                          Container(
                            height: SizeConfig.safeBlockHorizontal * 15,
                            child: CustomTextField(
                              label: "Login",
                              controller: loginController,
                              icon: Icon(
                                Icons.person_outline,
                                size: 27,
                                color: Color(0xFFF032f41),
                              ),
                            ),
                          ),
                          SizedBox(height: SizeConfig.safeBlockHorizontal * 2),
                          Container(
                            height: SizeConfig.safeBlockHorizontal * 15,
                            child: CustomTextField(
                              controller: nomController,
                              label: "Nom",
                              icon: Icon(
                                Icons.person,
                                size: 27,
                                color: Color(0xFFF032f41),
                              ),
                            ),
                          ),
                          SizedBox(height: SizeConfig.safeBlockHorizontal * 2),
                          Container(
                            height: SizeConfig.safeBlockHorizontal * 15,
                            child: CustomTextField(
                              label: "Prenom",
                              controller: prenomController,
                              icon: Icon(
                                Icons.person,
                                size: 27,
                                color: Color(0xFFF032f41),
                              ),
                            ),
                          ),
                          SizedBox(height: SizeConfig.safeBlockHorizontal * 2),
                          Container(
                            height: SizeConfig.safeBlockHorizontal * 15,
                            child: CustomTextField(
                              label: "CIN",
                              controller: cinController,
                              icon: Icon(
                                Icons.credit_card,
                                size: 27,
                                color: Color(0xFFF032f41),
                              ),
                            ),
                          ),
                          SizedBox(height: SizeConfig.safeBlockHorizontal * 2),
                          Container(
                            height: SizeConfig.safeBlockHorizontal * 15,
                            child: CustomTextField(
                              label: "Téléphone",
                              controller: telController,
                              icon: Icon(
                                Icons.phone,
                                size: 27,
                                color: Color(0xFFF032f41),
                              ),
                            ),
                          ),
                          SizedBox(height: SizeConfig.safeBlockHorizontal * 2),
                          Container(
                            height: SizeConfig.safeBlockHorizontal * 15,
                            child: CustomTextField(
                              // controller: TextEditingController(text: userPassword),
                              label: "Mot de passe",

                              controller: mdpController,

                              isPassword: true,
                              icon: Icon(
                                Icons.lock,
                                size: 27,
                                color: Color(0xFFF032f41),
                              ),
                            ),
                          ),

                          SizedBox(height: SizeConfig.safeBlockHorizontal * 4),
                          Container(
                            height: SizeConfig.safeBlockHorizontal * 13,
                            child: RaisedButton(
                              onPressed: () {
                                print('hdhsfs');
                               final hash=generateMd5(mdpController.text);
                                _updateProfile(loginController.text, cinController.text, nomController.text,
                                    prenomController.text, telController.text,hash);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Menu()),
                                );
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                  side: BorderSide(color: Colors.white)),
                              color: Color(0xffe6b301),
                              textColor: Colors.white,
                              child: Container(
                                height: SizeConfig.safeBlockVertical * 9,
                                width: double.infinity,
                                child: row.Row(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: SizeConfig.safeBlockHorizontal *
                                              10),
                                      padding: EdgeInsets.only(
                                          left: SizeConfig.safeBlockHorizontal *
                                              3,
                                          right:
                                              SizeConfig.safeBlockHorizontal *
                                                  7),
                                      child: Text("Modifier",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          )),
                                    ),
                                    SizedBox(width: 0),
                                    Container(
                                        //width: 50.0,
                                        //height: 50.0,
                                        margin: EdgeInsets.only(
                                            right:
                                                SizeConfig.safeBlockHorizontal *
                                                    5),
                                        padding: const EdgeInsets.all(
                                            2.0), //I used some padding without fixed width and height
                                        decoration: new BoxDecoration(
                                          shape: BoxShape
                                              .circle, // You can use like this way or like the below line
                                          //borderRadius: new BorderRadius.circular(30.0),
                                          color: Colors.white,
                                        ),
                                        child: Icon(Icons.arrow_forward,
                                            color: Color(0xffe6b301),
                                            size: 28)), //............
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
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

  _updateProfile(vlogin, vcin, vnom, vprenom, vtel,vmdp) async {
    // Open a connection (testdb should already exist)
    print('here' + vlogin);
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'shuttle.myguide.ma', user: 'myguidem', password: 'aqJ6gVU;6O79-y',db: 'myguidem_taxiapp'));

    // Update some data

    var result = await conn.query('update chauffeurs set login="' +
        vlogin +
        ' ",cin="' +
        vcin +
        '", nom="' +
        vnom +
        '", prenom="' +
        vprenom +
        '",numTel="' +
        vtel +
        '",password="' +
        vmdp +
        '" where id=' +
        userId.toString());
    await FlutterSession().set("nom",vnom);
    await FlutterSession().set("prenom",vprenom);
    await FlutterSession().set("cin",vcin);
    await FlutterSession().set("numTel",vtel);
    await FlutterSession().set("login",vlogin);
    await FlutterSession().set("password",vmdp);
    print(userId);
    // Finally, close the connection
    await conn.close();
    //logout();
  }
  generateMd5(String data) {
    var content = new Utf8Encoder().convert(data);
    var md5 = crypto.md5;
    var digest = md5.convert(content);
    return hex.encode(digest.bytes);
  }
  logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext ctx) => LoginScreen()));
  }
}
