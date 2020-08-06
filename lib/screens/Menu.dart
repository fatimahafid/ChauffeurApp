import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:login_dash_animation/components/buttonLoginAnimation.dart';
import 'package:login_dash_animation/components/customTextfield.dart';
import 'package:login_dash_animation/local_notifications_helper.dart';
import 'package:login_dash_animation/screens/editProfile.dart';
import 'package:login_dash_animation/screens/homeScreen.dart';
import 'package:login_dash_animation/screens/loginScreen.dart';
import 'package:login_dash_animation/screens/Fincourse.dart';
import 'package:login_dash_animation/screens/modifierVehicule.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:login_dash_animation/SizeConfig.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:mysql1/mysql1.dart' hide Row;
import 'package:location/location.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';



class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {

  final notifications =FlutterLocalNotificationsPlugin();
  var tablename='';
  var isaffected;
  var carId;
  var courseId;
  var session = FlutterSession();
  var touriste;
  var isStopped=false;
  String username='';

  @override
  void initState() {
    super.initState();
    getTablebycategorie();
    getvehicule();
    getuseername();
    final settingsAndroid = AndroidInitializationSettings('icone');
    final settingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: (id, title, body, payload) =>
            onSelectNotification(payload));

    notifications.initialize(
        InitializationSettings(settingsAndroid, settingsIOS),
        onSelectNotification: onSelectNotification);

  }
  Future onSelectNotification(String payload) async => await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Menu()),
  );


  getuseername() async{
   var  prenom=await FlutterSession().get("prenom");
    setState(() {
      username=prenom;
    });
  }
    checkcaraffected(){

    getConnection().then((conn) async {
      var result = await conn.query(
          'select touriste_id from ${tablename} where id=?',
          [
            courseId,
          ]);

      await session.set("isaffected",true);

      for (var row in result) {
        touriste= row[0];

      }
      if(touriste==null)
        setState(() {
          isaffected =false;
         // isStopped=false;

        });
      else {
        isaffected = true;
       // isStopped=false;

      }

      if(isaffected==true) {
        setState(() {
          isStopped=true;
        });

      String msg="Vous etes affectez au touriste numéro "+touriste.toString();
        showOngoingNotification(
            notifications, title: msg,
            body: null);
      }
      else
        setState(() {
          isStopped=false;
        });
      print(' is that car affecetd ? ' +isaffected.toString());

        await conn.close();


    });

  }

  getTablebycategorie() async
  {
    var categorie=await FlutterSession().get("categorie");
if(categorie=='Petit taxi')

 setState(() {
      tablename = 'pilepT';
    });
else if(categorie=='Grand taxi')
    setState(() {
      tablename = 'pilegt';
    });
else
  setState(() {
    tablename = 'pilevl';
  });
    print("test de session"+tablename.toString());
  }

  getvehicule() async
  {
    var id;
    var userid=await FlutterSession().get("id");

    print('this is the id of user '+userid.toString());
    getConnection().then((conn) async {
      var result = await conn.query(

          'select id from vehicules where chauffeur_id=?',
          [

            userid,

          ]);

      await session.set("tablename",tablename);

      for (var row in result) {
        id= row[0];

      }
      setState(() {
        carId = id;
      });
      print(' kkk'+userid.toString()+carId.toString());
      await conn.close();
    });


    print("test de session menu"+carId.toString());
  }
  Future<MySqlConnection> getConnection() async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'shuttle.myguide.ma', user: 'myguidem', password: 'aqJ6gVU;6O79-y',db: 'myguidem_taxiapp'));
   //if(conn!=null)
    return conn;

   }

    logout() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext ctx) => HomeScreen()));
  }

  _Addtopile() async {
    isStopped=false;
    getTablebycategorie();
    getvehicule();
    print('this is the car id'+carId.toString());
    getConnection().then((conn) async {
      var result = await conn.query(

          'insert into ${tablename} (vehicule_id, touriste_id) values (?, ?)',
          [

            carId,
            null
          ]);
      setState(() {
        courseId = result.insertId;
      });

      await session.set("courseId",result.insertId);
      await session.set("tablename",tablename);

      print('Inserted row id=${result.insertId}');
      await conn.close();

    });
    updatlocation(_locationData);
  }

  Location location = new Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  getLocation() async{
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled)  {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    var _location = await location.getLocation();

    setState(() {
      _locationData = _location;
    });
    print("location"+_locationData.toString());
  }

  updatlocation(location){
    getConnection().then((conn) async {
      var result = await conn.query(

          'update vehicules set location=? where id=?',
          [

            _locationData.toString(),
            carId,

          ]);

    

      //print('Inserted row id=${result.insertId}');
      await conn.close();

    });
  }
  @override
  Widget build(BuildContext context) {


    SizeConfig().init(context);
    location.onLocationChanged.listen((LocationData currentLocation) {
     // updatlocation(currentLocation) ;
    });
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
            padding: EdgeInsets.only(left: SizeConfig.safeBlockVertical * 40, top: SizeConfig.safeBlockVertical *7, right: SizeConfig.safeBlockHorizontal *4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[

                Row(
                  children: <Widget>[
                    Text(
                      username,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontFamily: "Pacificio",
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    SizedBox(width:  SizeConfig.safeBlockVertical * 2),

                    new GestureDetector(
                    onTap: () {
                       print('logout');
                       logout();
                    },
                      child: Icon(
                        Icons.power_settings_new,
                        color: Colors.white,
                        size: 33.0,
                        semanticLabel: '',
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
                                getLocation();
                                _Addtopile();
                                Timer.periodic(Duration(seconds: 5), (timer) {
                                  print('aaa'+isStopped.toString());
                                    if (isStopped==true) {
                                      timer.cancel();                                }
                                    else
                                    checkcaraffected();

                                });


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

