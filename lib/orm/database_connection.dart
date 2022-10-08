import 'package:postgres/postgres.dart';

class PostgreSql {
  late String host;
  late int port;
  late String database;
  late String username;
  late String password;


  PostgreSql({required this.host,required this.port,required this.database,required this.username,required this.password});

  PostgreSQLConnection connect() {
      return PostgreSQLConnection(this.host, this.port, this.database,
          username: this.username, password: this.password);
    }

}
