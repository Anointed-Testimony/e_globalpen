import 'package:hive/hive.dart';

class UserService {
  static const String _boxName = 'appData';

  /// Save user info after login/signup
  Future<void> saveUserData(String name) async {
    var box = await Hive.openBox(_boxName);
    await box.put('userName', name);
  }

  /// Retrieve stored user info
  Future<String?> getUserName() async {
    var box = await Hive.openBox(_boxName);
    return box.get('userName', defaultValue: null);
  }

  /// Clear user data on logout
  Future<void> logout() async {
    var box = await Hive.openBox(_boxName);
    await box.delete('userName'); // Remove stored username
  }
}
