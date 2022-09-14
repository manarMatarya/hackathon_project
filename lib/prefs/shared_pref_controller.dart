import 'package:shared_preferences/shared_preferences.dart';

enum PrefKeys {
  id,
  name,
  email,
  mobile,
  gender,
  image,
  branchId,
  accountNumber,
  loggedIn,
  type,
  token,
  language
}

class SharedPrefController {
  SharedPrefController._();

  late SharedPreferences _sharedPreferences;

  static SharedPrefController? _instance;

  factory SharedPrefController() {
    return _instance ??= SharedPrefController._();
  }

  Future<void> initPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  void save({required String type}) {
    _sharedPreferences.setBool(PrefKeys.loggedIn.name, true);
    _sharedPreferences.setString(PrefKeys.type.name, type);
  }

  void saveToken(token) {
    _sharedPreferences.setString(PrefKeys.token.name, token);
  }
   void changeLanguage({required String langCode}) {
    _sharedPreferences.setString(PrefKeys.language.name, langCode);
  }

  T? getValueFor<T>(String key) {
    if (_sharedPreferences.containsKey(key)) {
      return _sharedPreferences.get(key) as T;
    }
    return null;
  }

  Future<bool> clear() {
    return _sharedPreferences.clear();
  }
}
