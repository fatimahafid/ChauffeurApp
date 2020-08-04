import 'package:flutter/material.dart';
import 'package:login_dash_animation/animations/fadeAnimation.dart';
import 'package:login_dash_animation/components/customButton.dart';
import 'package:login_dash_animation/components/customButtonAnimation.dart';
import 'package:login_dash_animation/screens/loginScreen.dart';
import 'package:login_dash_animation/screens/InscriptionScreen.dart';
import 'package:login_dash_animation/SizeConfig.dart';
import 'package:login_dash_animation/screens/mdpoublie.dart';
import 'loginScreen.dart';
import 'Menu.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms/sms.dart';
import 'package:mysql1/mysql1.dart' hide Row;







class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}
const jaune = const Color(0xfffed136);
const grisFon = const Color(0xff212529);
const jauneFon = const Color(0xffe6b301);
var status;
var password;





class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    navigateUser();
  }
  Future<MySqlConnection> getConnection() async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: '10.0.2.2', port: 3306, user: 'root', db: 'taxiapp'));
    return conn;
  }

  updatepassword(userid){
    getConnection().then((conn) async {
      var result = await conn.query(

          'update chauffeurs set password=? where id=?',
          [

            password.toString(),
            userid,

          ]);
      conn.close();
  });
        }
  void navigateUser() async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      status = prefs.getBool('isLoggedIn') ?? false;
    });

    print('status'+status.toString());
    if (status==true) {
     // Navigator.pushNamed(context, '/menu');
    /*  Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Menu()),
      );*/
      //home=Menu();
    }




  }
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
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.safeBlockHorizontal * 7),
            margin: EdgeInsets.only(top: SizeConfig.safeBlockVertical * 10, bottom: SizeConfig.safeBlockVertical * 10 ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: SizeConfig.safeBlockVertical * 10, left: SizeConfig.safeBlockHorizontal * 0),

                    child: FadeAnimation(2.4,Text("Vous êtes un Chauffeur  ?", style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    letterSpacing: 2,



                    ))),
                  ),
                Container(
                  margin: EdgeInsets.only( left: SizeConfig.safeBlockHorizontal * 5,top: SizeConfig.safeBlockVertical * 3),
                  child: FadeAnimation(2.6,Text("Bienvenue", style: TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                    fontWeight: FontWeight.bold
                  ))),
                ),
                  ],
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    FadeAnimation(3.2,CustomButtonAnimation(
                      label: "S'inscrire",
                      backbround: Colors.transparent,
                      fontColor: Colors.white,
                      child: InscriptionScreen(),

                      borderColor: jaune,

                    )),
                    SizedBox(height: SizeConfig.safeBlockHorizontal * 5),
                    FadeAnimation(3.2,CustomButtonAnimation(
                      label: "Se Connecter",
                      backbround: jauneFon,
                      borderColor: jauneFon,
                      fontColor: Colors.white,
                      child: LoginScreen(),
                    )),
                    SizedBox(height: SizeConfig.safeBlockHorizontal * 5),
                    new GestureDetector(
                    onTap: () {
                      print('hey');

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => mdpoublie()),
                      );


                    },
                      child: Container(
                        child: FadeAnimation(3.4,Text("Mot de passe oublié ?", style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          decoration: TextDecoration.underline
                        ))),
                      ),
                    )
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