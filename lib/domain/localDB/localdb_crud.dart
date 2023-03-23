import 'package:credstream/domain/localDB/localdb.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LocalDBCrud {
  static Future<int> createUser(LocalDBUser user) async{
    return await Hive.box<LocalDBUser>("User").add(user);
  }

  static LocalDBUser currentUser() {
    return Hive.box<LocalDBUser>("User").values.first;
  } 

  static Future<int> removeUser() async {  
    return await Hive.box<LocalDBUser>("User").clear();
  }
}
