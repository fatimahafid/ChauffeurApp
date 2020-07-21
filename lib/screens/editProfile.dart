import 'package:flutter/material.dart';
import 'package:login_dash_animation/components/buttonLoginAnimation.dart';
import 'package:login_dash_animation/components/customTextfield.dart';
import 'package:login_dash_animation/screens/Menu.dart';
import 'package:login_dash_animation/screens/dashScreen.dart';
import 'package:login_dash_animation/screens/ajouterVehicule.dart';

class EditProfil extends StatefulWidget {
  @override
  _EditProfilState createState() => _EditProfilState();
}

class _EditProfilState extends State<EditProfil> {
  int group = 1;
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
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
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
                        Row(children: <Widget>[
                          Container(
                            child: Icon(
                              Icons.create,
                              size: 40,
                              color: Color(0xFFF032f41),
                            ),
                          ),
                          Container(
                            margin:
                                EdgeInsets.only(left: 10, right: 20, top: 0),
                            child: Text("Modifier le profil",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFFF032f41),
                                  fontSize: 30,
                                  fontFamily: "Pacificio",
                                )),
                          ),
                        ]),
                        SizedBox(height: 40),
                        CustomTextField(
                          label: "Nom",
                          icon: Icon(
                            Icons.person,
                            size: 27,
                            color: Color(0xFFF032f41),
                          ),
                        ),
                        SizedBox(height: 10),
                        CustomTextField(
                          label: "Prenom",
                          icon: Icon(
                            Icons.person,
                            size: 27,
                            color: Color(0xFFF032f41),
                          ),
                        ),
                        SizedBox(height: 10),
                        CustomTextField(
                          label: "CIN",
                          isPassword: true,
                          icon: Icon(
                            Icons.credit_card,
                            size: 27,
                            color: Color(0xFFF032f41),
                          ),
                        ),
                        SizedBox(height: 10),
                        CustomTextField(
                          label: "Téléphone",
                          isPassword: true,
                          icon: Icon(
                            Icons.phone,
                            size: 27,
                            color: Color(0xFFF032f41),
                          ),
                        ),
                        SizedBox(height: 10),
                        CustomTextField(
                          label: "Email",
                          isPassword: true,
                          icon: Icon(
                            Icons.alternate_email,
                            size: 27,
                            color: Color(0xFFF032f41),
                          ),
                        ),
                        SizedBox(height: 10),
                        CustomTextField(
                          label: "Mot de passe",
                          isPassword: true,
                        ),
                        SizedBox(height: 10),
                        ButtonLoginAnimation(
                          label: "Modifier",
                          fontColor: Colors.white,
                          background: Color(0xffe6b301),
                          borderColor: Color(0xffe6b301),
                          child: Menu(),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
