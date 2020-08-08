import 'package:flutter/material.dart';
import 'package:login_dash_animation/components/buttonLoginAnimation.dart';
import 'package:login_dash_animation/components/customTextfield.dart';
import 'package:login_dash_animation/models/mysql.dart';
import 'package:login_dash_animation/screens/Menu.dart';
import 'package:login_dash_animation/SizeConfig.dart';
import 'package:login_dash_animation/screens/ajouterVehicule.dart';
import 'package:mysql1/mysql1.dart' hide Row;
import 'package:password/password.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:crypto/crypto.dart' as crypto;
import 'package:crypto/crypto.dart' as crypto;
import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:flutter/src/widgets/basic.dart' as row ;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String msg = '';
  var session = FlutterSession();

  final login = TextEditingController();
  final password = TextEditingController();

  Future<MySqlConnection> getConnection() async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'shuttle.myguide.ma', user: 'myguidem', password: 'aqJ6gVU;6O79-y',db: 'myguidem_taxiapp'));
    return conn;
  }

  generateMd5(String data) {
    var content = new Utf8Encoder().convert(data);
    var md5 = crypto.md5;
    var digest = md5.convert(content);
    return hex.encode(digest.bytes);
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
                  SizedBox(height: SizeConfig.safeBlockVertical * 5),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.safeBlockHorizontal * 5,
                        vertical: SizeConfig.safeBlockVertical * 5),
                    margin: EdgeInsets.only(
                        left: SizeConfig.safeBlockHorizontal * 6,
                        right: SizeConfig.safeBlockHorizontal * 6,
                        bottom: SizeConfig.safeBlockVertical * 8,
                        top: SizeConfig.safeBlockVertical * 10),
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
                        Container(
                          margin: EdgeInsets.only(
                              left: SizeConfig.safeBlockHorizontal * 5,
                              right: SizeConfig.safeBlockHorizontal * 5,
                              top: SizeConfig.safeBlockVertical * 0),
                          child: Text("Authentifiez-vous ! ",
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
                            controller:login,
                            label: "Login",
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
                            controller:password,
                            label: "Mot de passe",
                            isPassword: true,
                            icon: Icon(
                              Icons.https,
                              size: 27,
                              color: Color(0xFFF032f41),
                            ),
                          ),
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
                        SizedBox(height: SizeConfig.safeBlockVertical * 2),
                        RaisedButton(
                          onPressed: () {
                            String log='';
                            print("heey1");
                            var id;
                            var nom='';
                            var prenom = '';
                            var cin = '';
                            var numTel = '';
                            var sexe = '';
                            var vehic_id;
                            var numTaxi = '';
                            var numImmatriculation = '';
                            var numAgrement = '';
                            var image = '';
                            var marque_id;
                            var type_id;

                            getConnection().then((conn) async {
                              var passw = '';
                              if( login.text==''|| password.text=='') {
                                setState(() {
                                  msg ="Saisissez le login et le mot de passe s'il vous plait!";
                                });

                              }
                              else{
                                log=login.text.replaceAll(new RegExp(r"\s+"), "");
                                var results = await conn.query(
                                    'select login, password,id,nom,prenom,cin,numTel,sexe from chauffeurs where login = ?',
                                    [login.text]);

                                var resultsVehic = await conn.query(
                                    'select numTaxi, numAgrement,numImmatriculation,image,marque_id,type_id,chauffeur_id,id from vehicules where chauffeur_id in (select id from chauffeurs where login= ?)',
                                    [login.text]);


                                if (results.isEmpty) {
                                  setState(() {
                                    msg = "Authetificateur erroné";
                                  });
                                } else {
                                  for (var row in results) {
                                    log = row[0];
                                    passw = row[1];
                                    id = row[2];
                                    nom = row[3];
                                    prenom = row[4];
                                    cin = row[5];
                                    numTel = row[6];
                                    sexe = row[7];
                                  }
                                  for (var rowvehic in resultsVehic) {
                                    numTaxi = rowvehic[0];
                                    numAgrement = rowvehic[1];
                                    numImmatriculation = rowvehic[2];
                                    image = rowvehic[3];
                                    marque_id = rowvehic[4];
                                    type_id = rowvehic[5];
                                    vehic_id = rowvehic[6];
                                  }
                                  //final algorithm = PBKDF2();
                                  // String hash = Password.hash(password.text ,algorithm);
                                  //  if (hash==passw)
                                  //  print("the password in data base is "+passw);
                                  //  print("the same password in input  is "+hash);
                                  var input_password=generateMd5(password.text);

                                 // if(Password.verify(password.text, passw)    )                              {
                                  if(passw==input_password )                              {

                                    print("infos" +id.toString()+"/"+nom);
                                    await session.set("id", id.toString());
                                    await session.set("nom", nom);
                                    await session.set("prenom", prenom);
                                    await session.set("cin", cin);
                                    await session.set("numTel", numTel);
                                    await session.set("login", log);
                                    await session.set("password", passw);
                                    await session.set("sexe", sexe);
                                    if(numTaxi==null)
                                      numTaxi='';
                                    await session.set("numTaxi", numTaxi);
                                    if(numAgrement==null)
                                      numAgrement='';
                                    await session.set( "numAgrement", numAgrement);
                                    await session.set("numImmatriculation",
                                        numImmatriculation);
                                    // await session.set("image", image);
                                    await session.set(
                                        "marque_id", marque_id.toString());
                                    await session.set(
                                        "type_id", type_id.toString());




                                    print('avant');
                                    SharedPreferences   prefs = await SharedPreferences.getInstance();
                                    prefs?.setBool("isLoggedIn", true);
                                    prefs.commit();
                                    var status = prefs.getBool('isLoggedIn') ?? false;

                                    print('apres '+status.toString());
                                    //setState(() {
                                    //
                                    //  });
                                    setState(() {
                                      msg = "";

                                    });
                                    var vid;

                                    var type_libelle;


                                    var result1 = await conn.query(
                                        'select id,type_id from vehicules where chauffeur_id=?', [ id ]);

                                    for (var row in result1) {
                                      vid=row[0];
                                      type_id=row[1];
                                      print("vid :"+vid.toString());
                                    }
                                    await session.set(
                                        "type_id", type_id.toString());
                                    if(vid==null)
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => AjouterVehicule()),
                                      );
                                    else {

                                      print("type :"+type_id.toString());
                                      print("id :"+type_id.toString());

                                      var result2 = await conn.query("select libelle from types where id=?",[type_id]);

                                      for (var row in result2) {
                                        type_libelle=row[0];

                                        print("type :"+type_libelle);
                                      }
                                      await session.set("categorie",type_libelle);

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Menu()),
                                      );
                                    }
                                    //Navigator.pushReplacementNamed(context, '/ajouterVéhicule');
                                  } else {
                                    setState(() {
                                      msg = "Mot de passe erroné";
                                    });
                                  }
                                }}
                            });
                            print("heey" + msg);
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
                                          0),

                                  padding: EdgeInsets.only(
                                      left: SizeConfig.safeBlockHorizontal *
                                          4,
                                      right: SizeConfig
                                          .safeBlockHorizontal * 3),
                                  child: Text(
                                      "Se Connecter", style: TextStyle(
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
                                        right: SizeConfig
                                            .safeBlockHorizontal * 5),
                                    padding: const EdgeInsets.all(2.0),
                                    //I used some padding without fixed width and height
                                    decoration: new BoxDecoration(
                                      shape: BoxShape.circle,
                                      // You can use like this way or like the below line
                                      //borderRadius: new BorderRadius.circular(30.0),
                                      color: Colors.white,
                                    ),
                                    child: Icon(Icons.arrow_forward,
                                        color: Color(0xffe6b301), size: 28)
                                ), //............

                              ],
                            ),

                          ),
                        ),
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