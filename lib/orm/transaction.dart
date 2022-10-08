import 'package:postgres_orm/orm/database_connection.dart';

class Acid{
  static Future<void> transaction(PostgreSql connection,Function callback) async{
    var connect = await connection.connect();
    await connect.open();
    await connect.transaction((ctx) async {
      try{
        await callback(ctx);
      }catch(err){
        print(err.toString());
        ctx.cancelTransaction();
      }
    });
  connect.close();
  }
}