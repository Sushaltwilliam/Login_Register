import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:register_login_app/home_screen.dart';
import 'package:register_login_app/main.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  // Registration method
  Future<void> registerUser(
      {required String username,
      required String email,
      required String mobile,
      required String password,
      required BuildContext context}) async {
    _isLoading = true;
    notifyListeners();

    const String apiUrl = 'https://mdqualityapps.in/API/loginapi/user_register';

    var body = {
      'userName': username,
      'userMail': email,
      'userMobile': mobile,
      'userPassword': password
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      body: body,
    );
    print(body);
    print(apiUrl);
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if(data["error"] == false){
  Navigator.pushReplacementNamed(context, '/login');
      print('Registration successful: $data');
      }else{
         print('Registration failed: ${response.statusCode}');
      var snackBar = SnackBar(content: Text(data["message"]??"Registration failed"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }

    } else {
      print('Registration failed: ${response.statusCode}');
      var snackBar = SnackBar(content: Text("Registration failed"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    _isLoading = false;
    notifyListeners();
  }

  // Login method
  Future<void> loginUser(
      {required String mobile,
      required String password,
      required BuildContext context}) async {
    _isLoading = true;
    notifyListeners();

    const String apiUrl = 'https://mdqualityapps.in/API/loginapi/user_login';

    final response = await http.post(
      Uri.parse(apiUrl),
      body: {
        'userMobile': mobile,
        'userPassword': password,
      },
    );
    print(response.body);
    var jsonData = json.decode(response.body);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (jsonData["error"] == false) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (ctx) => HomeScreen()),(Route<dynamic> route) => false );
        print('Login successful: $data');
      } else {
        var snackBar = SnackBar(content: Text("Login failed"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return;
      }
    } else {
      print('Login failed: ${response.statusCode}');
    }

    _isLoading = false;
    notifyListeners();
  }
}
