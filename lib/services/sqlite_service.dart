
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/user.dart';

class SQLiteService {
  late Database _db;
  bool hasInitialized = false;

  SQLiteService() {
    initializeDB().then((value){
      _db = value;
      hasInitialized = true;
    });
  }

  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();

    return openDatabase(
        join(path, 'mobile_store.db'),
        onCreate: (db, version) async {
          await db.execute("CREATE TABLE User(email TEXT PRIMARY KEY, name TEXT, picture TEXT)");
          await db.execute("CREATE TABLE Login(email TEXT PRIMARY KEY, password TEXT, isLogged BOOLEAN)");
        },
        version: 1
    );
  }

  Future<void> saveUser(User user) async {
    try {
      if(!hasInitialized) {
        await initializeDB();
      }
      await _db.insert(
          'User',
          user.toJson(),
          conflictAlgorithm: ConflictAlgorithm.ignore
      );
      print('@@@@@@@@@@@@@@@@@@@@ User created.');
    }
    catch(e) {
      print('===========> Fail to save User: $e');
    }
  }

  Future<void> saveLoginCredentials(String email, String password) async {
    try {
      if(!hasInitialized) {
        await initializeDB();
      }
      await _db.insert(
          'Login',
          {'email': email, 'password': password, 'isLogged': 0},
          conflictAlgorithm: ConflictAlgorithm.ignore
      );
    }
    catch(e) {
      print('===========> Fail to save pin: $e');
    }
  }

  Future<User?> getUser() async {
    if(!hasInitialized) {
      await initializeDB();
    }
    final user = await _db.query('User');

    if(user.isNotEmpty) {
      return User.fromJson(user.first);
    }
    else {
      return null;
    }
  }

  Future<bool> login(String email, String password) async {
    if(!hasInitialized) {
      await initializeDB();
    }

    List<Map> result = await _db.rawQuery(
        "SELECT * FROM Login WHERE email = ? AND password = ?",
        [email, password]
    );

    if (result.isNotEmpty) {
      await _db.update(
          'Login',
          {'isLogged': 1},
          where: 'email = ?',
          whereArgs: [email]
      );
      return true;
    }

    return false;
  }

  Future<bool> isLogged() async {
    if(!hasInitialized) {
      await initializeDB();
    }

    List<Map> result = await _db.rawQuery(
        "SELECT * FROM Login WHERE isLogged = 1"
    );

    if (result.isNotEmpty && result.first['isLogged'] == 1) {
      return true;
    }
    return false;
  }

}