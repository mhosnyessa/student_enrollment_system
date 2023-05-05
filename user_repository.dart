import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import './user_model.dart';

class UserRepository {
  static const baseUrl = 'https://example.com/api';
  UserModel? _currentUser;

  get currentUser => _currentUser;

  Future<UserModel> getUser(String userId) async {
    final url = Uri.parse('$baseUrl/users/$userId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);

      _currentUser = UserModel.fromJson(responseBody);
      return currentUser;
    } else {
      throw Exception('Failed to get user');
    }
  }

  Future<void> updateUser(String userId, UserModel updatedUser) async {
    _currentUser = updatedUser;
    final url = Uri.parse('$baseUrl/users/$userId');
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(updatedUser.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update user');
    }
  }

  //
  Future<UserModel> createNewUser(
    UserModel user, {
    required String email,
    required String password,
    required String fullName,
    required String phoneNumber,
  }) async {
    const url = '$baseUrl/users';
    _currentUser = user;
    final body = jsonEncode({
      'email': email,
      'password': password,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
    });

    final response = await http.post(Uri.parse(url), body: body);

    if (response.statusCode == 201) {
      _currentUser = user;
      final responseBody = jsonDecode(response.body);
      return UserModel.fromJson(responseBody);
    } else {
      throw Exception('Failed to create new user');
    }
  }


  Future<List<String>> getUserSchedule(String userId) async {
    final response = await http.get(Uri.parse('$baseUrl/users/$userId/schedule'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> scheduleData = data['schedule'];
      final List<String> schedule = scheduleData.map((e) => e.toString()).toList();
      return schedule;
    } else {
      throw Exception('Failed to load user schedule');
    }
  }



}
