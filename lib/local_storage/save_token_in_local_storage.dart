import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtil {
  SharedPreferencesUtil({required this.prefs});
  final SharedPreferences prefs;


  saveTokenLocally(String token) async {
    prefs.setString('token', token);
  }

  Future<String> getTokenFromPref() async {
    String token = prefs.getString('token') ?? '';
    return token;
  }
}
