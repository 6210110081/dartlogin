import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

Future<Map<String, dynamic>> apiLogin(String login, String pswd) async {
  var response = await http.post(
      Uri.parse('https://www.developerthai.com/flutter/login.php'),
      headers: <String, String>{'content-type': 'application/json'},
      body: jsonEncode(<String, String>{'login': login, 'pswd': pswd}));

  if (response.statusCode == 200) {
    return jsonDecode(response.body) as Map<String, dynamic>;
  } else {
    throw Exception('Error');
  }
}
