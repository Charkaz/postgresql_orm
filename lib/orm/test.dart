import 'package:postgres_orm/orm/transaction.dart';

import 'colums.dart';
import 'database_connection.dart';
import 'model.dart';

//import 'model_dao/product.dart';
//import 'model_dao/users.dart';
import 'query.dart';
import 'utils.dart';


PostgreSql connection = PostgreSql(host: "127.0.0.1",port: 5432,database: "erp",username: "postgres",password: "xxxxxx");

class Users extends Model {
  String tableName = "users";
  List<Column> columns = [
    Column(name: "id", type: "INT",primaryKey: true,unique: true,isSerial: true),
    Column(name: "username", type: "TEXT",unique: true),
    Column(name: "first_name",type: "TEXT"),
    Column(name: "last_name", type: "TEXT"),
  ];

  Users() : super() {
    super.tableName = this.tableName;
    super.columns = this.columns;
    super.connection = connection;
  }
}

class Category extends Model{
  String table = "category";
  List<Column> columns = [
    Column(name: "id", type: "INT",isSerial: true,primaryKey: true),
    Column(name: "name", type: "TEXT"),
  ];

  Category():super(){
    super.tableName = this.table;
    super.columns = this.columns;
    super.connection = connection;
  }
}


class Product extends Model {
  String tableName = "product";
  List<Column> columns = [
    Column(name: "id", type: "INT",primaryKey: true,unique: true,isSerial: true),
    Column(name: "product_name", type: "TEXT",),
    Column(name: "price",type: "REAL",),
    Column(name: "user_id", type: "INT",foreignKey: true,referencesTable: "users"),
    Column(name: "category", type: "INT",foreignKey: true,referencesTable: "category")
  ];

  Product() : super() {
    super.tableName = this.tableName;
    super.columns = this.columns;
    super.connection = connection;
  }
}

main() async {
  Users user =  Users();
  await user.createTable();
  Category category = Category();
  //await category.createTable();
  Product product = Product();
  //await product.createTable();









}
