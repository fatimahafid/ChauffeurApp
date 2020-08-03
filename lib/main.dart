import 'package:flutter/material.dart';
import 'package:login_dash_animation/screens/Menu.dart';
import 'package:login_dash_animation/screens/ajouterVehicule.dart';
import 'package:login_dash_animation/screens/homeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
   // navigateUser();
    super.initState();

  }
  //var home;

  var status;

  var _prefs = SharedPreferences.getInstance();



  @override
  Widget build(BuildContext context) {
  //navigateUser();



    return MaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'Surfing',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
     home: HomeScreen(),
    );
  }
}
