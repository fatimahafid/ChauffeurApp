import 'package:flutter/material.dart';
import 'package:login_dash_animation/components/buttonLoginAnimation.dart';
import 'package:login_dash_animation/components/customTextfield.dart';
import 'package:login_dash_animation/screens/Menu.dart';
import 'package:login_dash_animation/screens/dashScreen.dart';
import 'package:login_dash_animation/screens/ajouterVehicule.dart';
import 'package:login_dash_animation/SizeConfig.dart';

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
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  SizedBox(height: SizeConfig.safeBlockHorizontal * 20),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: SizeConfig.safeBlockHorizontal * 5, vertical: SizeConfig.safeBlockHorizontal * 6),
                    margin: EdgeInsets.only(left: SizeConfig.safeBlockHorizontal * 5, right: SizeConfig.safeBlockHorizontal * 5, bottom: SizeConfig.safeBlockHorizontal * 5),
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

                    child: Column(

                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: SizeConfig.safeBlockHorizontal * 5, right: SizeConfig.safeBlockHorizontal * 5, top: SizeConfig.safeBlockHorizontal * 0),
                          child: Text("Modifier Profil",
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
                          child:CustomTextField(
                            label: "Nom",
                            icon: Icon(
                              Icons.person,
                              size: 27,
                              color: Color(0xFFF032f41),
                            ),
                          ),
                        ),
                        SizedBox(height: SizeConfig.safeBlockHorizontal * 4),
                        Container(
                          height: SizeConfig.safeBlockHorizontal * 15,
                          child:
                          CustomTextField(
                            label: "Prenom",
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
                            isPassword: true,
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
                          child:CustomTextField(
                            label: "Téléphone",
                            isPassword: true,
                            icon: Icon(
                              Icons.phone,
                              size: 27,
                              color: Color(0xFFF032f41),

                            ),),
                        ),
                        SizedBox(height: SizeConfig.safeBlockHorizontal * 4),

                        new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[

                            new Radio(
                              value: 1,
                              groupValue: group,
                              onChanged: (T) {
                                print(T);
                              },
                            ),
                            new Text(
                              'Femme',
                              style: new TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                            new Radio(
                              value: 2,
                              groupValue: group,
                              onChanged: (T) {
                                print(T);
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
                            child:ButtonLoginAnimation(
                              label: "Modifier",
                              fontColor: Colors.white,
                              background: Color(0xffe6b301),
                              borderColor: Color(0xffe6b301),
                              child: AjouterVehicule(),
                            )
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
