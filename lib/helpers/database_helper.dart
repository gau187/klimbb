import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:untitled/modals/user_modal.dart';
import 'package:untitled/utils/constants.dart';

class DatabaseHandler {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, '${AppConstants.DB_NAME}.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE device_profile(latitude NUMBER,longitude NUMBER UNIQUE, deviceProfile TEXT UNIQUE)",
        );
      },
      version: 1,
    );
  }

  Future<dynamic> insertUser(UserModal user) async {
    try {
      int result = 0;
      final Database db = await initializeDB();
      result = await db.insert(AppConstants.DB_NAME, user.toMap());

      return result;
    } catch (error) {
      return Future.error(error);
    }
  }

  Future<List<UserModal>> retrieveUsers() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult =
        await db.query(AppConstants.DB_NAME);
    return queryResult.map((e) => UserModal.fromMap(e)).toList();
  }
}
