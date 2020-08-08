import 'package:flutter/material.dart';
import 'package:login_dash_animation/components/buttonLoginAnimation.dart';
import 'package:login_dash_animation/components/customTextfield.dart';
import 'package:login_dash_animation/models/mysql.dart';
import 'package:login_dash_animation/screens/Menu.dart';
import 'package:login_dash_animation/SizeConfig.dart';
import 'package:login_dash_animation/screens/ajouterVehicule.dart';
import 'package:login_dash_animation/screens/loginScreen.dart';
import 'package:mysql1/mysql1.dart' hide Row;
import 'package:password/password.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'dart:math' as Math;
import 'package:crypto/crypto.dart' as crypto;
import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:http/http.dart' as http;






class mdpoublie extends StatefulWidget {
  @override
  _mdpoublieState createState() => _mdpoublieState();
}

class _mdpoublieState extends State<mdpoublie> {

  var titre="Génération du mot de passe ";
  var password ;
  final login = TextEditingController();
  int rand;
  String msg='';
  var iscorrect;
  String text='';
  var hide=false;
  AlertType res=AlertType.success;
  generateMd5(String data) {
    var content = new Utf8Encoder().convert(data);
    var md5 = crypto.md5;
    var digest = md5.convert(content);
    return hex.encode(digest.bytes);
  }
  updatepassword(){


    rand= new Math.Random().nextInt(100000);

    var hash= generateMd5(rand.toString());

    setState(() {
      password=hash;
    });
     getConnection().then((conn) async {
      var results = await conn.query(
          'select login from chauffeurs where login = ?',
          [login.text]);



      if (results.isEmpty) {
        print('result is empty');

        setState(() {

          hide=false;
          msg = 'login erroné';
          iscorrect=false;

          res = AlertType.error;
          text="Login erroné";
          text=msg;


        });
      } else{

        print('result is not empty');

        setState(() {
          hide=true;

          iscorrect=true;
          msg = '';
          res = AlertType.success;
          text="Votre nouveau mot de passe est :"+rand.toString();

        });
      var result = await conn.query(

          'update chauffeurs set password=? where login=?',
          [

            password,
            login.text,

          ]);
      setState(() {
        titre="Votre nouveau mot de passe est :"+rand.toString();
      });
      conn.close();}
    });


  }



  Future<MySqlConnection> getConnection() async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
    //    host: 'shuttle.myguide.ma', port: 3306, user: 'myguidem', password: 'aqJ6gVU;6O79-y',db: 'myguidem_taxiapp'));
        host: 'shuttle.myguide.ma', user: 'myguidem', password: 'aqJ6gVU;6O79-y',db: 'myguidem_taxiapp'));

    return conn;
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

          Container(
            padding: EdgeInsets.only(left: SizeConfig.safeBlockVertical * 5, top: SizeConfig.safeBlockVertical *7, right: SizeConfig.safeBlockHorizontal *4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[

                Row(
                  children: <Widget>[

                    SizedBox(width:  SizeConfig.safeBlockVertical * 2),


                  ],
                ),
              ],
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  SizedBox(height: SizeConfig.safeBlockVertical * 5),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.safeBlockHorizontal * 5,
                        vertical: SizeConfig.safeBlockVertical * 5),
                    margin: EdgeInsets.only(
                        left: SizeConfig.safeBlockHorizontal * 6,
                        right: SizeConfig.safeBlockHorizontal * 6,
                        bottom: SizeConfig.safeBlockVertical * 8,
                        top: SizeConfig.safeBlockVertical * 15),
                    height: MediaQuery.of(context).size.height * 0.70,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                              SizeConfig.safeBlockHorizontal * 7),
                          topRight: Radius.circular(
                              SizeConfig.safeBlockHorizontal * 7),
                          bottomLeft: Radius.circular(
                              SizeConfig.safeBlockHorizontal * 7),
                          bottomRight: Radius.circular(
                              SizeConfig.safeBlockHorizontal * 7),
                        )),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new GestureDetector(

                          onTap: () {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (BuildContext ctx) => LoginScreen()));

                          },
                          child: Container(
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                              size: 33.0,
                              semanticLabel: '',
                            ),
                          ),
                        ),
                        SizedBox(height: SizeConfig.safeBlockVertical * 2),

                        Container(
                          margin: EdgeInsets.only(
                              left: SizeConfig.safeBlockHorizontal * 5,
                              right: SizeConfig.safeBlockHorizontal * 5,
                              top: SizeConfig.safeBlockVertical * 0),
                          child: Text(titre,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFFF032f41),
                                fontSize: 30,
                                fontFamily: "Pacificio",
                              )),
                        ),

                      Container(
                        child:Center(
                         child: Text(msg, style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 16,
                           //fontWeight: FontWeight.bold,
                              )),
                              ),
                              ),
      SizedBox(height: SizeConfig.safeBlockVertical * 5),

      Container(
                          height: SizeConfig.safeBlockVertical * 10,
                          child: CustomTextField(
                            controller:login,
                            label: "Login",
                            icon: Icon(
                              Icons.mail,
                              size: 27,
                              color: Color(0xFFF032f41),
                            ),
                            enabled: !hide,
                          ),

                        ),
                        SizedBox(height: SizeConfig.safeBlockVertical * 4),

                        RaisedButton(
    onPressed: hide ? null : () =>  updatepassword(),

                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                              side: BorderSide(color: Colors.white)),
                          color: Color(0xffe6b301),
                          textColor: Colors.white,

                          child: Container(
                            height: SizeConfig.safeBlockVertical * 9,
                            width: double.infinity,
                            child: Row(
                              children: <Widget>[
                                Container(

                                  margin: EdgeInsets.only(left: SizeConfig.safeBlockHorizontal * 10),

                                  padding: EdgeInsets.only(left:SizeConfig.safeBlockHorizontal * 3,right: SizeConfig.safeBlockHorizontal * 7),
                                  child: Text("Valider", style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,


                                  )),
                                ),
                                SizedBox(width: 0),
                                Container(
                                  //width: 50.0,
                                  //height: 50.0,
                                    margin: EdgeInsets.only(right: SizeConfig.safeBlockHorizontal * 5),
                                    padding: const EdgeInsets.all(2.0),//I used some padding without fixed width and height
                                    decoration: new BoxDecoration(
                                      shape: BoxShape.circle,// You can use like this way or like the below line
                                      //borderRadius: new BorderRadius.circular(30.0),
                                      color: Colors.white,
                                    ),
                                    child:Icon(Icons.arrow_forward, color: Color(0xffe6b301),size: 28)
                                ),//............

                              ],
                            ),
                          ),),
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