import 'dart:convert';

import 'package:flutter_miarmapp/models/login_dto.dart';
import 'package:flutter_miarmapp/models/login_response.dart';
import 'package:flutter_miarmapp/models/register_dto.dart';
import 'package:flutter_miarmapp/models/register_response.dart';
import 'package:flutter_miarmapp/repository/auth_repository/auth_repository.dart';
import 'package:http/http.dart';

class AuthRepositoryImpl extends AuthRepository {
  final Client _client = Client();

  @override
  Future<LoginResponse> login(LoginDto loginDto) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      // 'Authorization': 'Bearer $token'
    };

    final response = await _client.post(
        Uri.parse('http://10.0.2.2:8080/auth/login'),
        headers: headers,
        body: jsonEncode(loginDto.toJson()));
    if (response.statusCode == 201) {
      return LoginResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Fail to login');
    }
  }

  @override
  Future<RegisterResponse> register(RegisterDto registerDto) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      // 'Authorization': 'Bearer $token'
    };

    final response = await _client.post(
        Uri.parse('http://10.0.2.2:8080/auth/register'),
        headers: headers,
        body: jsonEncode(registerDto.toJson()));
    if (response.statusCode == 201) {
      return RegisterResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Fail to register');
    }
  }
}
