import 'package:mysql1/mysql1.dart';

class Mysql {
  static String host = '10.0.2.2',
      user = 'root',
      password = '',
      db = 'test';
  static int port = 3306;

  Mysql();

  Future<MySqlConnection> getConnection() async {
    try {
      var settings = new ConnectionSettings(
          host: host,
          port: port,
          user: user,
          password: password,
          db: db
      );
      return await MySqlConnection.connect(settings);
    }
    catch (e) {
      print("erreur hnaa "+e.toString());
    }
  }
}