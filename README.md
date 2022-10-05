
![](https://1000logos.net/wp-content/uploads/2020/08/PostgreSQL-Logo.png)


# PostgreSql ucun orm 
Postgresql ve dart ile melumat bazasi 

## Nece yuklenir

paketi yuklemek ucun github url'ni pubspec.yaml elave edilmelidir.

```bash
 url: github.com
```

## Istifade

```import 'package:postgres_orm/orm/model_dao/users.dart';
import 'package:postgres_orm/orm/utils.dart';

import 'colums.dart';
import 'database_connection.dart';
import 'model.dart';
PostgreSql connection = PostgreSql(host: "127.0.0.1",port: 5432,database: "xx",username: "xx",password: "xxx");

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
    Users user = new Users();
    //await user.createTable();
    Category category = Category();
    //await category.createTable();
    Product product = Product();
    //await product.createTable();
    
  //  await user.insert(["qewq","cerkez","alisan"]);

  //user.createClass();
  //category.createClass();
  //product.createClass();

  //UsersDAO alisan = UsersDAO(id: 1, username: "userAlisan", first_name: "alisan", last_name: "cerkez");
  //CategoryDAO cat = CategoryDAO(id: 1, name: "kitab");

  //ProductDAO prod = ProductDAO(id: 1,product_name: "java",price: 14.5,category: 1,user_id: 1);

  //product.insert(prod.userToList());
  //Utils u = new Utils();
  //print(u.isCreatedDirectory().then((value) => print(value)));


  UsersDAO ferid = new UsersDAO(username: "Ferid123", first_name: "ferid", last_name: "Necefov");

  user.insert(ferid.modelToList());
}


```

