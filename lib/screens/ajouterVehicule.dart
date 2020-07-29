import 'package:flutter/material.dart';
import 'package:login_dash_animation/components/buttonLoginAnimation.dart';
import 'package:login_dash_animation/components/customTextfield.dart';
import 'package:login_dash_animation/screens/Menu.dart';
import 'package:login_dash_animation/SizeConfig.dart';
import 'package:mysql1/mysql1.dart' hide Row;
import 'package:flutter_session/flutter_session.dart';



class AjouterVehicule extends StatefulWidget {
  @override
  _AjouterVehiculeState createState() => _AjouterVehiculeState();
}

class _AjouterVehiculeState extends State<AjouterVehicule> {
  String dropdownValue = 'Catégorie';
  String dropdownValue1 = 'Marque';
  final immatr = TextEditingController();
  final agrem = TextEditingController();
  final numtaxi = TextEditingController();


  dynamic userId;
  String userName;
   getUser() async
  { userId = await FlutterSession().get("id");
  userName= await FlutterSession().get("nom");
  print("test de session"+userId.toString()+" / "+userName);


  }



  Future<MySqlConnection> getConnection() async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: '10.0.2.2', port: 3306, user: 'root', db: 'taxiapp'));
    return conn;
  }

  @override
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
                        vertical: SizeConfig.safeBlockHorizontal * 5),
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
                          child: Text("Ajouter votre véhicule",
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
                            controller:agrem,

                            label: "Num Agrément",
                            icon: Icon(
                              Icons.credit_card,
                              size: 27,
                              color: Color(0xFFF032f41),
                            ),
                          ),
                        ),
                        SizedBox(height: SizeConfig.safeBlockHorizontal * 4),
                        Container(
                          height: SizeConfig.safeBlockHorizontal * 15,
                          child: CustomTextField(
                            controller:immatr,

                            label: "Num Immatriculation",
                            icon: Icon(
                              Icons.local_taxi,
                              size: 27,
                              color: Color(0xFFF032f41),
                            ),
                          ),
                        ),
                        SizedBox(height: SizeConfig.safeBlockHorizontal * 4),
                        Container(
                          height: SizeConfig.safeBlockHorizontal * 15,
                          child: CustomTextField(
                            controller:numtaxi,
                            label: "Num Taxi",
                            isPassword: false,
                            icon: Icon(
                              Icons.local_taxi,
                              size: 27,
                              color: Color(0xFFF032f41),
                            ),
                          ),
                        ),
                        Container(
                          height: SizeConfig.safeBlockHorizontal * 15,
                          child: Container(
                            padding: EdgeInsets.only(
                                left: SizeConfig.safeBlockHorizontal * 0),
                            margin: EdgeInsets.only(
                                top: SizeConfig.safeBlockHorizontal * 4,
                                left: SizeConfig.safeBlockHorizontal * 4,
                                right: SizeConfig.safeBlockHorizontal * 4),
                            child: DropdownButton(
                              isExpanded: true,
                              items: <String>[
                                'Catégorie',
                                'Petit Taxi',
                                'Grand Taxi',
                                'Mini Bus',
                                'Voiture de luxe',
                              ].map<DropdownMenuItem<String>>(
                                (String value) {
                                  return DropdownMenuItem(
                                    value: value,
                                    child: Text(value),
                                  );
                                },
                              ).toList(),
                              value: dropdownValue,
                              onChanged: (value) {
                                setState(() {
                                  dropdownValue = value;
                                });
                              },
                            ),
                          ),
                        ),
                        Container(
                          height: SizeConfig.safeBlockHorizontal * 15,
                          child: Container(
                            padding: EdgeInsets.only(
                                left: SizeConfig.safeBlockHorizontal * 0),
                            margin: EdgeInsets.only(
                                top: SizeConfig.safeBlockHorizontal * 4,
                                left: SizeConfig.safeBlockHorizontal * 4,
                                right: SizeConfig.safeBlockHorizontal * 4),
                            child: DropdownButton(
                              isExpanded: true,
                              items: <String>[
                                'Marque',
                                'marque1',
                                'marque2',
                                'marque3'
                              ].map<DropdownMenuItem<String>>(
                                (String value) {
                                  return DropdownMenuItem(
                                    value: value,
                                    child: Text(value),
                                  );
                                },
                              ).toList(),
                              value: dropdownValue1,
                              onChanged: (value) {
                                setState(() {
                                  dropdownValue1 = value;
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: SizeConfig.safeBlockHorizontal * 4),
                        Container(
                            height: SizeConfig.safeBlockHorizontal * 13,
                         child: RaisedButton(
                            onPressed: () {
                              print("heey1");
                              getUser();
 },
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
                            ),),
                        ),],
                    ),
                  )
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
