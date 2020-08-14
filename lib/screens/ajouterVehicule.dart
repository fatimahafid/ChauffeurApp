import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:login_dash_animation/components/buttonLoginAnimation.dart';
import 'package:login_dash_animation/components/customTextfield.dart';
import 'package:login_dash_animation/screens/Menu.dart';
import 'package:login_dash_animation/SizeConfig.dart';
import 'package:mysql1/mysql1.dart' hide Row;
import 'package:flutter_session/flutter_session.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'dart:convert';
import 'dart:io'  ;
import 'package:async/async.dart';
import 'package:flutter/src/widgets/basic.dart' as row ;
import 'package:http/http.dart' as http;

import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as Img;
import 'dart:math' as Math;
import 'package:flutter_session/flutter_session.dart';
import 'package:dio/dio.dart' as dio;
import 'package:http_parser/http_parser.dart';





class AjouterVehicule extends StatefulWidget {
  @override
  _AjouterVehiculeState createState() => _AjouterVehiculeState();
}

class _AjouterVehiculeState extends State<AjouterVehicule> {
  var session = FlutterSession();
  File _image;
  var is_taxi=false;
  String msg = '';
  final immatr = TextEditingController();
  final agrem = TextEditingController();
  final numtaxi = TextEditingController();
  var _isimageEmpty=true;
  var imageColor=Colors.white;
  var titre='Ajouter une image';
  var textcolor= Color(0xFFF032f41);


  List<String> marques=getMarques() ;
  List<String> categories=getGategories() ;

  var dropdownvalue;
  var dropdownvalue1;
  int userId;
  String userName;
  String ctitle="testphoto";

   getUser() async
  {
    var id=await FlutterSession().get("id");
    var nom=await FlutterSession().get("nom");

    setState(() {
      userId = id;
    });
    setState(() {
    userName= nom;
    });
  print("test de session ajout vehicule  "+userId.toString()+" / "+userName);
  }
  @override
  void initState() {
     getUser();
    super.initState();

  }


  static List<String> getMarques(){
    List<String> marques=List<String>() ;

    getConnection().then((conn) async {

      var results = await conn.query('select libelle from marques ');
        for (var row in results) {
          marques.add(row[0]);
          print("marque :"+row[0]);
        }


    });
    return marques;


  }
  static List<String> getGategories(){
    List<String> categoris=List<String>() ;


    getConnection().then((conn) async {

      var results = await conn.query('select libelle from types ');
      for (var row in results) {
        categoris.add(row[0]);
        print("categorie :"+row[0]);
      }

    });

    return categoris;
  }

   istaxi(type){

     if(type=='Grand taxi' || type=='Petit taxi')
      setState(() {
        is_taxi=true;
      });
     else
       setState(() {
         is_taxi=false;
       });
     print('enabled should be :'+is_taxi.toString());

  }
  isimageEmpty(){
     if(_image==null){
      setState(() {
       _isimageEmpty=true;
        imageColor=Colors.white;
        titre='Ajouter une image';
        textcolor= Color(0xFFF032f41);

      });
      }
     else
       setState(() {
         _isimageEmpty=false;
         imageColor=Color(0xFFF032f41);
         titre='image ajoutée';
         textcolor=Colors.white;

       });
     print('in image method'+titre.toString());


  }
  _ajout(numtaxi, numAgrement, numImmatriculation, image, marque,type,chauffeurId,BuildContext context) async {
    // Open a connection (testdb should already exist)
    print('in insert method');
    int marque_id;
    int type_id;
    if((is_taxi && (agrem.text=="" || numtaxi=="") )|| immatr.text==""   || marque==null || type==null)
    {

      setState(() {
        msg = "Remplir les champs";
      });
    } else {
      setState(() {
        msg='';
      });

      getConnection().then((conn) async {
      var result0 = await conn.query("select id from marques where libelle=?",[marque]);

      for (var row in result0) {
        marque_id=row[0];
        print("marque_id :"+row[0].toString());
      }
      var result01 = await conn.query("select id from types where libelle=?",[type]);

      for (var row in result01) {
        type_id=row[0];
        print("type_id :"+row[0].toString());
      }
      var now = new DateTime.now();

      if(!is_taxi)
        {
          setState(() {
            numtaxi=null;
            numAgrement=null;
          });

        }
      var result = await conn.query(

          'insert into vehicules (numTaxi, numAgrement, numImmatriculation,deleted_at,image, marque_id, type_id,chauffeur_id,created_at, updated_at) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
          [numtaxi, numAgrement, numImmatriculation, null,_image, marque_id,type_id,chauffeurId,now.toUtc(),null]);

      await session.set("categorie", type);

      print('Inserted row id=${result.insertId}');
      var vid=result.insertId;
      await session.set("carId",vid);
      await session.set("numTaxi", numtaxi);
      await session.set("numAgrement", numAgrement);
      await session.set("numImmatriculation", numImmatriculation);
      await session.set("marque_id", marque_id.toString());
      await session.set("type_id", type_id.toString());

      // Finally, close the connection
    //  upload(_image);
      await conn.close();

          });
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Menu()),
      );
    }


  }



  Future getImageGallery() async{
    var imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);

    final tempDir =await getTemporaryDirectory();
    final path = tempDir.path;

    int rand= new Math.Random().nextInt(100000);

    Img.Image image= Img.decodeImage(imageFile.readAsBytesSync());
    Img.Image smallerImg = Img.copyResize(image,height :500);
    getUser();

    var compressImg= new File("$path/$userId.jpg")
      ..writeAsBytesSync(Img.encodeJpg(smallerImg, quality: 85));


    setState(() {
      _image = compressImg;
    });
    isimageEmpty();

  }

 /* Future upload(File imageFile) async{
    var stream= new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length= await imageFile.length();
    var uri = Uri.parse("http://10.0.2.2/taxiapp/upload.php");
   // var uri = Uri.parse("shuttle.myguide.ma/upload.php");

    var request = new http.MultipartRequest("POST", uri);

    var multipartFile = new http.MultipartFile("image", stream, length, filename: basename(imageFile.path));
    request.fields['title'] = ctitle;
    request.files.add(multipartFile);

    var response = await request.send();

    if(response.statusCode==200){
      print("Image Uploaded");
    }else{
      print("Upload Failed");
    }
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }
*/
  static Future<MySqlConnection> getConnection() async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'shuttle.myguide.ma', user: 'myguidem', password: 'aqJ6gVU;6O79-y',db: 'myguidem_taxiapp'));
    return conn;
  }



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
                          child: Container(
                            padding: EdgeInsets.only(
                                left: SizeConfig.safeBlockHorizontal * 0),
                            margin: EdgeInsets.only(
                                top: SizeConfig.safeBlockHorizontal * 4,
                                left: SizeConfig.safeBlockHorizontal * 4,
                                right: SizeConfig.safeBlockHorizontal * 4),

                            child:DropdownButton<String>(
                              hint: Text("Catégorie ",
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
                              onChanged: (String newval){
                                setState((){
                                  dropdownvalue = newval;
                                  istaxi(dropdownvalue);
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

                        /*  RaisedButton(
                          child: Text("UPLOAD"),
                          onPressed:(){
                            upload(_image);
                          },
                        ),*/
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
                              hint: Text("Marque ",
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
                              enabled:is_taxi

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
                              enabled:is_taxi

                          ),

                        ),

                        SizedBox(height: SizeConfig.safeBlockHorizontal * 4),

                        /*   Container(
                          height: SizeConfig.safeBlockHorizontal * 15,




                          child:RaisedButton(
                            color: imageColor,
                              padding: const EdgeInsets.only(right:0,left:15),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0),
                                side: BorderSide(color: Color(0xFFF032f41),width: 0.3)),
                            child: row.Row(

                              children: <Widget>[

                                Text(titre, style: TextStyle(
                                  color: textcolor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,


                                )),
                                SizedBox(width: SizeConfig.safeBlockHorizontal * 20),
                                Icon(Icons.image,size: 35,color:textcolor,),

                              ],
                            ),
                            onPressed : (){
                              getImageGallery();
                          }
                          ),

                        ),
                        SizedBox(height: SizeConfig.safeBlockHorizontal * 2),*/
                        Container(
                          child:Center(
                            child: Text(msg, style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 16,
                              //fontWeight: FontWeight.bold,


                            )),
                          ),
                        ),
                        SizedBox(height: SizeConfig.safeBlockHorizontal * 2),

                        Container(
                            height: SizeConfig.safeBlockHorizontal * 15,
                         child: RaisedButton(
                            onPressed: () {
                              getUser();
                        _ajout(numtaxi.text+"", agrem.text+"", immatr.text+"", null, dropdownvalue1,dropdownvalue,userId,context);
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


                                    padding: EdgeInsets.only(left:SizeConfig.safeBlockHorizontal * 18),
                                     child:Center(
                                       child: Text("Ajouter", style: TextStyle(

                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,



                                    )),
                                     ),
                                  ),
                                  SizedBox(width: SizeConfig.safeBlockHorizontal *9),
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
                        ),
                        SizedBox(height: SizeConfig.safeBlockHorizontal * 4),
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
