import 'dart:convert';

import 'package:http/http.dart' as http;

import 'user.dart';

Future<User> fetchRandomUser() async {
  var response = await http.get(Uri.parse('https://randomuser.me/api'));

  if (response.statusCode == 200) {
    return User.parse(jsonDecode(response.body));
  } else {
    return User('Igor', 'https://picsum.photos/200', Gender.male, 118);
  }
}
