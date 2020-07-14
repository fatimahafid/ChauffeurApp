import 'package:flutter/material.dart';
import 'package:login_dash_animation/components/buttonLoginAnimation.dart';
import 'package:login_dash_animation/components/customTextfield.dart';
import 'package:login_dash_animation/screens/dashScreen.dart';

class InscriptionScreen extends StatefulWidget {
  @override
  _InscriptionScreenState createState() => _InscriptionScreenState();
}

class _InscriptionScreenState extends State<InscriptionScreen> {
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
          Column(
            children: <Widget>[],
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 20, right: 20, top: 0),
                        child: Text("Inscription",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFFF032f41),
                              fontSize: 30,
                              fontFamily: "Pacificio",
                            )),
                      ),
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
                      ButtonLoginAnimation(
                        label: "S'inscrire",
                        fontColor: Colors.white,
                        background: Color(0xffe6b301),
                        borderColor: Color(0xffe6b301),
                        child: DashScreen(),
                      )
                    ],
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
