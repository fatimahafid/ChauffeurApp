import 'package:flutter/material.dart';
import 'package:login_dash_animation/components/buttonLoginAnimation.dart';
import 'package:login_dash_animation/components/customTextfield.dart';
import 'package:login_dash_animation/screens/Menu.dart';
import 'package:login_dash_animation/SizeConfig.dart';

class ModifierVehicule extends StatefulWidget {
  @override
  _ModifierVehiculeState createState() => _ModifierVehiculeState();
}

class _ModifierVehiculeState extends State<ModifierVehicule> {
  String dropdownValue = 'Catégorie';
  String dropdownValue1 = 'Marque';

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
                              child: Text("Modifier votre véhicule",
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
                                child: ButtonLoginAnimation(
                                  label: "Modifier",
                                  fontColor: Colors.white,
                                  background: Color(0xffe6b301),
                                  borderColor: Color(0xffe6b301),
                                  child: Menu(),
                                )),
                          ],
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
