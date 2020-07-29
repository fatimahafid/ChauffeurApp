import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';

class Example extends StatefulWidget {
  Example({Key key}) : super(key: key);
  _ExampleState createState() => _ExampleState();
}
class _ExampleState extends State<Example> {
  @override
  void initState() {
    _main().then((value){
      print('Async done');
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
  Future _main() async {
    // Open a connection (testdb should already exist)
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: '10.0.2.2', port: 3306, user: 'root', db: 'taxiapp'));


    // Insert some data
  //  var result = await conn.query(
    //    'insert into user1 (name, email, age) values (?, ?, ?)',
     //   ['Bob', 'bob@bob.com', 25]);
    //print('Inserted row id=${result.insertId}');

    // Query the database using a parameterized query
    var id=1;
    var results = await conn
        .query('select login, password from chauffeurs where id = ?', [id]);
    for (var row in results) {
      print('Name: ${row[0]}, email: ${row[1]}');
    }

    // Finally, close the connection
    await conn.close();
  }
}