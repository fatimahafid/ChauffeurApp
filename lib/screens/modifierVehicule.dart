import 'package:flutter/material.dart';
import 'package:login_dash_animation/components/buttonLoginAnimation.dart';
import 'package:login_dash_animation/components/customTextfield.dart';
import 'package:login_dash_animation/screens/Menu.dart';
import 'package:login_dash_animation/SizeConfig.dart';
import 'package:mysql1/mysql1.dart' hide Row;
import 'package:flutter_session/flutter_session.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'dart:convert';
import 'dart:io';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;

import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as Img;
import 'dart:math' as Math;

class ModifierVehicule extends StatefulWidget {
  @override
  _ModifierVehiculeState createState() => _ModifierVehiculeState();
}

class _ModifierVehiculeState extends State<ModifierVehicule> {
  File _image;

  final immatr = TextEditingController();
  final agrem = TextEditingController();
  final numtaxi = TextEditingController();

  List<String> marques = getMarques();
  List<String> categories = getGategories();
  var _isimageEmpty=true;
  var imageColor=Colors.white;
  var titre='Ajouter une image';
  var textcolor= Color(0xFFF032f41);

  int userId;
  int userVehicId;
  String userName;
  String userNumTaxi;
  String userNumAgrement;
  String userNumImmatriculation;
  String userImage;
  static int userMarque_id;
  static int userType_id;
  String ctitle = "testphoto";
  static var marque='';
  static var categ='';
  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    agrem.dispose();
    immatr.dispose();
    numtaxi.dispose();
    super.dispose();
  }

  getUser() async {
    var id = await FlutterSession().get("id");
    var nom = await FlutterSession().get("nom");
    var numTaxi = await FlutterSession().get("numTaxi");
    var numAgrement = await FlutterSession().get("numAgrement");
    var numImmatriculation = await FlutterSession().get("numImmatriculation");
    var image = await FlutterSession().get("image");
     var marque_id=await FlutterSession().get("marque_id");
     var type_id=await FlutterSession().get("type_id");


    setState(() {
      userId = id;
    });

    setState(() {
      userName = nom;
    });
    setState(() {
      userNumTaxi = numTaxi;
      numtaxi.text = userNumTaxi;
    });
    setState(() {
      userNumAgrement = numAgrement;
      agrem.text = userNumAgrement;
    });
    setState(() {
      userNumImmatriculation = numImmatriculation;
      immatr.text = userNumImmatriculation;
    });
    setState(() {
      userImage = image;

    });
    setState(() {
      userMarque_id = marque_id;
      dropdownvalue1=marque;
    });
    setState(() {
      userType_id = type_id;
      dropdownvalue=categ;
    });

    print("test de session vehic" + userId.toString() + " / " + userVehicId.toString());
  }

  @override
  void initState() {
    getUser();
    getLaMarque();
    getLaCateg();
    print('categoriiiii:'+dropdownvalue);
    print('marqueeeee:'+dropdownvalue1);
   // print('imageeeee:'+userImage);
    return super.initState();
  }

  static List<String> getMarques() {
    List<String> marques = List<String>();

    getConnection().then((conn) async {
      var results = await conn.query('select libelle from marques ');
      for (var row in results) {
        marques.add(row[0]);
        print("marque :" + row[0]);
      }
    });
    return marques;
  }
   static String getLaMarque() {

    getConnection().then((conn) async {
      var results = await conn.query('select libelle from marques where id= ? ',[userMarque_id]);
      for (var row in results) {
        marque=row[0];
        print("marque :" + marque);
      }
    });
    return marque;
  }
  static String getLaCateg() {
    getConnection().then((conn) async {
      var results = await conn.query('select libelle from types where id= ? ',[userType_id]);
      for (var row in results) {
        categ=row[0];
        print("categ :" + categ);
      }
    });
    return categ;
  }

  static List<String> getGategories() {
    List<String> categories = List<String>();

    getConnection().then((conn) async {
      var results = await conn.query('select libelle from types ');
      for (var row in results) {
        categories.add(row[0]);
        print("categorie :" + row[0]);
      }
    });
    return categories;
  }
  isimageEmpty(){
    if(_image==null){
      setState(() {
        _isimageEmpty=true;
        imageColor=Colors.white;
        titre='Modifier l\'image';
        textcolor= Color(0xFFF032f41);

      });
    }
    else
      setState(() {
        _isimageEmpty=false;
        imageColor=Color(0xFFF032f41);
        titre='image modifiée';
        textcolor=Colors.white;

      });
    print('in image method'+titre.toString());


  }
  _update(numtaxi, numAgrement, numImmatriculation, marque, type,
      vehic_id) async {
    // Open a connection (testdb should already exist)
    print('update method');
    int marque_id;
    int type_id;

    getConnection().then((conn) async {
      var result0 =
          await conn.query("select id from marques where libelle=?", [marque]);

      for (var row in result0) {
        marque_id = row[0];
        print("marque_id :" + row[0].toString());
      }
      var result01 =
          await conn.query("select id from types where libelle=?", [type]);

      for (var row in result01) {
        type_id = row[0];
        print("type_id :" + row[0].toString());
      }
      var now = new DateTime.now();

      var result = await conn.query(
          'update vehicules set numTaxi="' +
      numtaxi +
      ' ",numAgrement="' +
      numAgrement +
      '", numImmatriculation="' +
              numImmatriculation +
          '",marque_id="' +
              marque_id.toString() +
          '",type_id="' +
              type_id.toString() +
          '" where chauffeur_id=' +
              userId.toString());
      await FlutterSession().set("numAgrement", numAgrement);
      await FlutterSession().set("numTaxi",numtaxi);
      await FlutterSession().set("numImmatriculation",numImmatriculation);
      await FlutterSession().set("marque_id",marque_id);
      await FlutterSession().set("type_id",type_id);
      print('Inserted row id=${result.insertId}');

      // Finally, close the connection
      upload(_image);
      await conn.close();
    });

  }

  Future getImageGallery() async {
    var imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);

    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;

    int rand = new Math.Random().nextInt(100000);

    Img.Image image = Img.decodeImage(imageFile.readAsBytesSync());
    Img.Image smallerImg = Img.copyResize(image, height: 500);
    getUser();

    var compressImg = new File("$path/$userId.jpg")
      ..writeAsBytesSync(Img.encodeJpg(smallerImg, quality: 85));

    setState(() {
      _image = compressImg;
    });
  }

  Future upload(File imageFile) async {
    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();
    var uri = Uri.parse("http://10.0.2.2/taxiapp/upload.php");

    var request = new http.MultipartRequest("POST", uri);

    var multipartFile = new http.MultipartFile("image", stream, length,
        filename: basename(imageFile.path));
    request.fields['title'] = ctitle;
    request.files.add(multipartFile);

    var response = await request.send();

    if (response.statusCode == 200) {
      print("Image Uploaded");
    } else {
      print("Upload Failed");
    }
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }

  static Future<MySqlConnection> getConnection() async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'shuttle.myguide.ma', user: 'myguidem', password: 'aqJ6gVU;6O79-y',db: 'myguidem_taxiapp'));
    return conn;
  }
  var dropdownvalue=categ;
  var dropdownvalue1=marque;
  @override
  @override
  Widget build(BuildContext context) {
    // getMarques();
    //  getGategories();
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
                            Container(
                              height: SizeConfig.safeBlockHorizontal * 15,
                              child: Container(
                                padding: EdgeInsets.only(
                                    left: SizeConfig.safeBlockHorizontal * 0),
                                margin: EdgeInsets.only(
                                    top: SizeConfig.safeBlockHorizontal * 4,
                                    left: SizeConfig.safeBlockHorizontal * 4,
                                    right: SizeConfig.safeBlockHorizontal * 4),
                                child:DropdownButton<String>(
                                  hint: Text(categ,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xFFF032f41),
                                        fontSize: 18,
                                        fontFamily: "Pacificio",
                                      )),
                                  isExpanded: true,
                                  value: dropdownvalue,
                                  icon: Icon(Icons.keyboard_arrow_down,color: Color(0xFFF032f41),
                                  ),
                                  iconSize: 27,
                                  elevation: 20,
                                  onChanged: (String value){
                                    setState((){
                                      dropdownvalue = value;
                                      print("select:"+dropdownvalue);

                                    });

                                  },
                                  items: categories
                                      .map<DropdownMenuItem<String>>((String value){
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
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
                                child:DropdownButton<String>(
                                  hint: Text(marque,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xFFF032f41),
                                        fontSize: 18,
                                        fontFamily: "Pacificio",
                                      )),
                                  isExpanded: true,
                                  value: dropdownvalue1,
                                  icon: Icon(Icons.keyboard_arrow_down,color: Color(0xFFF032f41),
                                  ),
                                  iconSize: 27,
                                  elevation: 20,
                                  onChanged: (String newval){
                                    setState((){
                                      dropdownvalue1 = newval;
                                      print("select:"+dropdownvalue1);
                                    });

                                  },
                                  items: marques
                                      .map<DropdownMenuItem<String>>((String value){
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                            SizedBox(
                                height: SizeConfig.safeBlockHorizontal * 4),
                            Container(
                              height: SizeConfig.safeBlockHorizontal * 15,
                              child: CustomTextField(
                                controller: agrem,
                                label: "Num Agrément",
                                icon: Icon(
                                  Icons.credit_card,
                                  size: 27,
                                  color: Color(0xFFF032f41),
                                ),
                              ),
                            ),
                            SizedBox(
                                height: SizeConfig.safeBlockHorizontal * 4),
                            Container(
                              height: SizeConfig.safeBlockHorizontal * 15,
                              child: CustomTextField(
                                controller: immatr,
                                label: "Num Immatriculation",
                                icon: Icon(
                                  Icons.local_taxi,
                                  size: 27,
                                  color: Color(0xFFF032f41),
                                ),
                              ),
                            ),
                            SizedBox(
                                height: SizeConfig.safeBlockHorizontal * 4),
                            Container(
                              height: SizeConfig.safeBlockHorizontal * 15,
                              child: CustomTextField(
                                controller: numtaxi,
                                label: "Num Taxi",
                                isPassword: false,
                                icon: Icon(
                                  Icons.local_taxi,
                                  size: 27,
                                  color: Color(0xFFF032f41),
                                ),
                              ),
                            ),
                            SizedBox(
                                height: SizeConfig.safeBlockHorizontal * 4),
                            Container(
                              height: SizeConfig.safeBlockHorizontal * 15,
                              child: RaisedButton(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                    side: BorderSide(
                                        color: Color(0xFFF032f41), width: 0.3)),
                                child: Row(
                                  children: <Widget>[
                                    Text("Modifier l'image",
                                        style: TextStyle(
                                          color: Color(0xFFF032f41),
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    SizedBox(
                                      width:
                                          SizeConfig.safeBlockHorizontal * 20,
                                    ),
                                    Icon(
                                      Icons.image,
                                      size: 35,
                                    ),
                                  ],
                                ),
                                onPressed: getImageGallery,
                              ),
                            ),
                            SizedBox(
                                height: SizeConfig.safeBlockHorizontal * 4),
                            Container(
                              height: SizeConfig.safeBlockHorizontal * 15,
                              child: RaisedButton(
                                onPressed: () {
                                  getUser();
                                  _update(
                                      numtaxi.text,
                                      agrem.text,
                                      immatr.text,

                                      dropdownvalue1,
                                      dropdownvalue,
                                      userVehicId);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Menu()),
                                  );
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
                                        margin: EdgeInsets.only(
                                            left:
                                                SizeConfig.safeBlockHorizontal *
                                                    10),
                                        padding: EdgeInsets.only(
                                            left:
                                                SizeConfig.safeBlockHorizontal *
                                                    3,
                                            right:
                                                SizeConfig.safeBlockHorizontal *
                                                    7),
                                        child: Text("Modifier",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                            )),
                                      ),
                                      SizedBox(width: 0),
                                      Container(
                                          //width: 50.0,
                                          //height: 50.0,
                                          margin: EdgeInsets.only(
                                              right: SizeConfig
                                                      .safeBlockHorizontal *
                                                  5),
                                          padding: const EdgeInsets.all(
                                              2.0), //I used some padding without fixed width and height
                                          decoration: new BoxDecoration(
                                            shape: BoxShape
                                                .circle, // You can use like this way or like the below line
                                            //borderRadius: new BorderRadius.circular(30.0),
                                            color: Colors.white,
                                          ),
                                          child: Icon(Icons.arrow_forward,
                                              color: Color(0xffe6b301),
                                              size: 28)), //............
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                                height: SizeConfig.safeBlockHorizontal * 4),
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
