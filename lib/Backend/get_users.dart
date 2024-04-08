import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Core/urls.dart';


Future getUsers(int page) async {
  final uri = Uri.parse('$kGetUsersUrl?page=$page');
final response = await http.get(uri);

  var p = json.decode(response.body);
  if(response.statusCode==200) {
    return p;
  }else {
    return [];
  }
}