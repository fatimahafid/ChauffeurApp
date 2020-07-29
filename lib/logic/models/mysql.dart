import 'package:mysql1/mysql1.dart';

class Mysql {

  Mysql();


  Future<MySqlConnection> getConnection() async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: '10.0.2.2', port: 3306, user: 'root', db: 'taxiapp'));
        return conn;
  }
}



// Insert some data
//  var result = await conn.query(
//    'insert into user1 (name, email, age) values (?, ?, ?)',
//   ['Bob', 'bob@bob.com', 25]);
//print('Inserted row id=${result.insertId}');

// Query the database using a parameterized query
//var id=1;
//var results = await conn
  //  .query('select login, password from chauffeurs where id = ?', [id]);
//for (var row in results) {
//print('Name: ${row[0]}, email: ${row[1]}');
//}

// Finally, close the connection
//await conn.close();