import 'package:flutter/material.dart';
import 'package:login_dash_animation/components/CustomButtonAnimation.dart';
import 'package:login_dash_animation/components/customTextfield.dart';
import 'package:login_dash_animation/screens/ajouterVehicule.dart';
import 'package:login_dash_animation/SizeConfig.dart';
import 'package:flutter/src/widgets/basic.dart' as row ;
import 'package:mysql1/mysql1.dart' ;
import 'package:password/password.dart';

class InscriptionScreen extends StatefulWidget {
  @override
  _InscriptionScreenState createState() => _InscriptionScreenState();
}
enum SingingCharacter { homme, femme }
class _InscriptionScreenState extends State<InscriptionScreen> {

  SingingCharacter _character = SingingCharacter.femme;

  final vlogin = TextEditingController();
  final vnom = TextEditingController();
  final vprenom = TextEditingController();
  final vcin = TextEditingController();
  final vmdp = TextEditingController();
  final vtel = TextEditingController();
  int vsexe=0;


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
                            child: Text("Inscription",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFFF032f41),
                                  fontSize: 30,
                                  fontFamily: "Pacificio",
                                )),
                          ),
                          SizedBox(height: SizeConfig.safeBlockHorizontal * 2),
                          Container(
                            height: SizeConfig.safeBlockHorizontal * 15,
                            child: CustomTextField(
                              controller:vlogin,
                              label: "Login",

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
                              controller:vnom,
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
                              controller:vprenom,
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
                              controller:vcin,

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
                              controller:vtel,

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

                              label: "Mot de passe",
                              controller:vmdp,
                              isPassword: true,
                              icon: Icon(
                                Icons.lock,
                                size: 27,
                                color: Color(0xFFF032f41),
                              ),
                            ),
                          ),
                          SizedBox(height: SizeConfig.safeBlockHorizontal * 2),
                    new row.Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                          new Radio(
                            value: SingingCharacter.femme,
                            groupValue: _character,
                            onChanged: (SingingCharacter value) {
                              setState(() { _character = value; });
                              print(_character);
                            },
                          ),
                          new Text(
                            'Femme',
                            style: new TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          new Radio(
                            value: SingingCharacter.homme,
                            groupValue: _character,
                            onChanged: (SingingCharacter value) {
                              setState(() { _character = value; });
                              print(_character);
                            },
                          ),
                          new Text(
                            'Homme',
                            style: new TextStyle(fontSize: 16.0),
                          ),
                            ],
                          ),

                          SizedBox(height: SizeConfig.safeBlockHorizontal * 4),
                          Container(
                              height: SizeConfig.safeBlockHorizontal * 13,
                              child: RaisedButton(
                                onPressed: (){
                                  print('hdhsfs');
                                  print(vlogin.toString());
                                  final algorithm = PBKDF2();
                                  final hash = Password.hash(vmdp.text, algorithm);
                                _inscription(vlogin.text, hash, vcin.text, vnom.text, vprenom.text, vtel.text,vsexe);

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

                                        margin: EdgeInsets.only(left: SizeConfig.safeBlockHorizontal * 10),

                                        padding: EdgeInsets.only(left:SizeConfig.safeBlockHorizontal * 3,right: SizeConfig.safeBlockHorizontal * 7),
                                        child: Text("se connecter", style: TextStyle(
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

   _inscription(vlogin, vmdp, vcin, vnom,vprenom,vtel,vsexe) async {
    // Open a connection (testdb should already exist)
     print('here'+vlogin);
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: '10.0.2.2', port: 3306, user: 'root', db: 'taxiapp'));

     if(_character==SingingCharacter.femme){
       vsexe=1;
     }else if(_character==SingingCharacter.homme){
       vsexe=2;
     }
    // Insert some data
    var result = await conn.query(

        'insert into chauffeurs (login, password, cin, nom, prenom,numTel,sexe, note, deleted_at, created_at, updated_at) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
        [vlogin, vmdp, vcin, vnom,vprenom,vtel,vsexe,null,null,null,null]);
    print('Inserted row id=${result.insertId}');

    // Finally, close the connection
    await conn.close();
  }
}


