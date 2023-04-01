import 'package:hive/hive.dart';
part 'localdb.g.dart';

@HiveType(typeId: 1)
class LocalDBUser {
  @HiveField(0)
  String email;

  @HiveField(1)
  String name;

  @HiveField(2)
  bool loggedin = false;

  @HiveField(3)
  int key = 0;

  @HiveField(4)
  String credentialWatermark;

  LocalDBUser(
      {required this.email, required this.name, required this.credentialWatermark});
}
