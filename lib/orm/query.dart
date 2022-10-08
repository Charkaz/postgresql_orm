import 'colums.dart';

class Query{
  static String createTable(String tableName,List<Column> columns){
    String createTableSql = "CREATE TABLE IF NOT EXISTS ${tableName} ( ";
    for (var column in columns) {
      if (column != columns.last) {
        createTableSql +=
        "${column.name}  ${column.isSerial ? 'SERIAL' : column.type} ${column.primaryKey ? 'PRIMARY KEY' : ''} ${column.isNull ? 'NOT NULL' : ''} ${column.unique ? 'UNIQUE' : ''},";
      } else {
        createTableSql +=
        "${column.name}  ${column.isSerial ? 'SERIAL' : column.type} ${column.primaryKey ? 'PRIMARY KEY' : ''} ${column.isNull ? 'NOT NULL' : ''} ${column.unique ? 'UNIQUE' : ''}";
      }
    }

    for (var col in columns) {
      if (col.foreignKey) {
        createTableSql +=
        ",CONSTRAINT fk_${col.referencesTable} FOREIGN KEY(${col.name}) REFERENCES ${col.referencesTable}(id) ON DELETE SET NULL";
      }
    }
    createTableSql += " )";

    return createTableSql;
  }


  static String insert(List<dynamic> insertData,String tableName,List<Column> columns) {
    String insertSql = "INSERT INTO ${tableName}(";
    for (var col in columns) {
      if (!col.isSerial) {
        if (col != columns.last) {
          insertSql += "${col.name} , ";
        } else {
          insertSql += "${col.name}";
        }
      }
    }

    insertSql += ") VALUES (";
    for (int i = 0; i < insertData.length; i++) {
      if (i != insertData.length - 1) {
        insertSql += "'${insertData[i].toString()}',";
      } else {
        insertSql += " '${insertData[i].toString()}'";
      }
    }

    insertSql += " )";
    return insertSql;
  }



  static String selectAll(String tableName,[String orderBy="ASC"]){
    String selectAll =
        "SELECT * FROM ${tableName} order by id ${orderBy} ";
    return selectAll;
  }

  static String delete(String tableName,int id){
    String deleteSql = "DELETE  FROM ${tableName} WHERE id=${id} ";
    return deleteSql;
  }

  static String get(String tableName,int id){
    String selectAll =
        "SELECT * FROM ${tableName} WHERE id=${id} ";
    return selectAll;
  }

  static String update(int id,List<dynamic> updateData,String tableName,List<Column> columns){
    String updateSql = "UPDATE ${tableName} SET (";
    for (var col in columns) {
      if (!col.isSerial) {
        if (col != columns.last) {
          updateSql += "${col.name} , ";
        } else {
          updateSql += "${col.name}";
        }
      }
    }

    updateSql += ") = (";
    for (int i = 0; i < updateData.length; i++) {
      if (i != updateData.length - 1) {
        updateSql += "'${updateData[i].toString()}',";
      } else {
        updateSql += " '${updateData[i].toString()}'";
      }
    }

    updateSql += " )";
    updateSql += " WHERE id = ${id}";
    return updateSql;
  }


}