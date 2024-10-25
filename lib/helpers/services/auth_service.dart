import 'package:fldc/helpers/services/storage/local_storage.dart';
import 'package:fldc/model/user.dart';

class AuthService {
  static bool isLoggedIn = false;

  static User get dummyUser => User(-1, "user@demo.com", "Denish", "Navadiya");

  static Future<Map<String, String>?> loginUser(
      Map<String, dynamic> data) async {
    await Future.delayed(Duration(seconds: 1));
    if (data['email'] != dummyUser.email) {
      return {"email": "This email is not registered"};
    } else if (data['password'] != "password") {
      return {"password": "Password is incorrect"};
    }

    isLoggedIn = true;
    await LocalStorage.setLoggedInUser(true);
    return null;
  }
}
