import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_app/local_storage/save_token_in_local_storage.dart';
import 'dart:convert';

import '../Core/urls.dart';



Future<String> login(String email, String password) async {
  final uri = Uri.parse(kLoginUrl);
  var response = await http.post(uri, body: {
    'email': email,
    'password': password,
  });
  var p = json.decode(response.body);
  if(response.statusCode==200){
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await SharedPreferencesUtil(prefs: prefs).saveTokenLocally(p['token']);
    return 'Login succeeded';
  }
  return 'Login failed';
}
