import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gui_db/user_model.dart';
import './core.dart';

class AuthenticationRepository {
  static const baseUrl = core.baseUrl;

  Future<UserModel> login(
      {required String email, required String password}) async {
    final url = Uri.parse('$baseUrl/login/$email/$password');
    final response = await http.get(
      url,
    );
    print('called url : $url');
    print('response: ${response.body}');

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      print('response body: ${responseBody}');
      return UserModel.fromJson(responseBody);
    } else {
      return UserModel.empty;
    }
  }

  Future<UserModel> signup(
      {required String email, required String password}) async {
    final url = Uri.parse('$baseUrl/signup');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      return UserModel.fromJson(responseBody);
    } else {
      throw Exception('Failed to signup');
    }
  }

  Future<void> logout() async {
    // TODO: Implement logout API call
  }
}
