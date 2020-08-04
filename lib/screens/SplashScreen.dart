import 'package:flutter/material.dart';
import 'package:login_dash_animation/screens/Menu.dart';
import 'package:login_dash_animation/screens/ajouterVehicule.dart';
import 'package:login_dash_animation/screens/homeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    navigateUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          fit: StackFit.expand,
            children: <Widget>[

        Image.asset("assets/images/bg2.jpg", fit: BoxFit.cover),
          Container(
            width: MediaQuery
                .of(context)
                .size
                .width,
            height: MediaQuery
                .of(context)
                .size
                .height,
            color: Color(0xFFF001117).withOpacity(0.7),
          ),
  ],),
    );

  }
  void navigateUser() async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      status = prefs.getBool('isLoggedIn') ?? false;
    });

    print('status'+status.toString());
    if (status==true) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Menu()),
      );
    }
    else
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomeScreen()),
      );




  }

}

