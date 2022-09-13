import 'package:hackathon_project/models/user.dart';
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
  loggedIn
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

  // void save({required UserModel user}) {
  //   _sharedPreferences.setBool(PrefKeys.loggedIn.name, true);
  //   _sharedPreferences.setString(PrefKeys.id.name, user.id);
  //   _sharedPreferences.setString(PrefKeys.name.name, user.name);
  //   _sharedPreferences.setString(PrefKeys.mobile.name, user.mobile);
  //   _sharedPreferences.setString(PrefKeys.gender.name, user.gender);
  //   _sharedPreferences.setString(PrefKeys.email.name, user.email);
  //   _sharedPreferences.setString(PrefKeys.branchId.name, user.branchId);
  //   _sharedPreferences.setString(PrefKeys.image.name, user.image);
  //   _sharedPreferences.setString(
  //       PrefKeys.accountNumber.name, user.accountNumber);
  // }

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
