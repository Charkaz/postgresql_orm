import 'dart:io';
import 'query.dart';

import 'colums.dart';
import 'database_connection.dart';
import 'extension.dart';
import 'utils.dart';

class Model{
  late String tableName;
  late List<Column> columns;
  late PostgreSql connection;

  Future<List<dynamic>> query(String sql,String tableName) async{
    late List<dynamic> list =[];
    try {
      var connect = connection.connect();
      await connect.open();
      await connect
          .query(sql)
          .then((value) async {
        list = await value;
      })
          .catchError((err) {
        print(err.toString());
        return list;
      }
      )
          .whenComplete(() => connect.close());
    } catch (e) {
      print(e.toString());
    }
    return list;

  }

  Future<void> createTable() async {
    String createTableSql = Query.createTable(this.tableName, this.columns);
    query(createTableSql, this.tableName);
  }

  Future<void> insert(List<dynamic> insertData) async {
    String insertSql = Query.insert(insertData, this.tableName, this.columns);
    query(insertSql, this.tableName);
  }

  Future<void> selectAll([String orderBy = "ASC"]) async {
    String selectAll = Query.selectAll(this.tableName, orderBy);
    query(selectAll, this.tableName);
  }
  Future<List<dynamic>> get({required int id}) async {
    String getSql = Query.get(this.tableName, id);
    var result =  await query(getSql, this.tableName);
    return result;

  }

  Future<void> delete({required int id}) async {
    String deleteSql = Query.delete(this.tableName, id);
    try {
      var connect = connection.connect();
      await connect.open();
      var result = await connect.query(deleteSql);
      print(result);
      connect.close();
    } catch (err) {
      print(err.toString());
    }
  }

  Future<void> createClass() async {
    Utils utilDir = Utils();
    utilDir.isCreatedDirectory().then((value) {
      if (!value) {
        utilDir.createModelDaoDirectory();
      } else {
        print("fayl movcuddur.");
      }
      return value;
    });

    Future<File> clasFile =
    File("model_dao/${this.tableName}.dart").create(recursive: true);
    await clasFile.then((value) {
      String contents = """
        class ${this.tableName.capitalize()}DAO{\n
        """;
      for (var col in columns) {
        if (col.type == "INT") {
          contents += "late int ${col.name};\n";
        } else if (col.type == "TEXT") {
          contents += "late String ${col.name};\n";
        } else if (col.type == "REAL") {
          contents += "late double ${col.name};\n";
        } else if (col.type == "BOOLEAN") {
          contents += "late bool ${col.name};\n";
        }
      }
      contents += "${this.tableName.capitalize()}DAO({";
      for (var col in columns) {
        if (!col.isSerial) {
          contents += "required this.${col.name} , ";
        }
      }

      contents += " });\n";
      contents += "${this.tableName.capitalize()}DAO.withId({";
      for (var col in columns) {
        contents += "required this.${col.name} , ";
      }
      contents += " });\n";
      contents += "List<dynamic> modelToList(){\n";
      contents += " List<dynamic> user =[";
      for (var col in columns) {
        if (!col.isSerial) {
          contents += "this.${col.name},";
        }
      }
      contents += "];\n";
      contents += """
        return user;
          }
       """;

      contents += "factory ${this.tableName.capitalize()}DAO.fromList(List<dynamic> list){\n";
      contents +=" return ${this.tableName.capitalize()}DAO.withId(" ;
      for(int i = 0 ; i < columns.length; i++) {
        if(columns[i].type == "INT"){
          contents += "${columns[i].name}: list[$i],";
        }else if(columns[i].type == "REAL"){
          contents += "${columns[i].name}: list[$i],";
        }else{
          contents += "${columns[i].name}: list[$i].toString(),";
        }
      }
      contents += "); \n}\n}";

      value.writeAsString(contents);
    });
  }
}