import 'dart:convert';

import 'package:flutter_miarmapp/models/login_dto.dart';
import 'package:flutter_miarmapp/models/login_response.dart';
import 'package:flutter_miarmapp/models/register_dto.dart';
import 'package:flutter_miarmapp/models/register_response.dart';
import 'package:flutter_miarmapp/repository/auth_repository/auth_repository.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

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
  Future<RegisterResponse> register(
      RegisterDto registerDto, String imagePath) async {
    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
      // 'Authorization': 'Bearer $token'
    };

    Map<String, String> headers2 = {
      'Content-Type': 'application/json',
      // 'Authorization': 'Bearer $token'
    };
    /*final response = await _client.post(
        Uri.parse('http://10.0.2.2:8080/auth/register/user'),
        headers: headers2,
        body: jsonEncode(registerDto.toJson()));*/
    SharedPreferences prefs = await SharedPreferences.getInstance();

    /*var request = http.MultipartRequest(
        'POST', Uri.parse('http://10.0.2.2:8080/auth/register/user'))
      ..fields['user'] = jsonEncode(registerDto.toJson())
      ..files.add(await http.MultipartFile.fromPath('file', imagePath));
      request.headers.addAll(headers);
    final response = await request.send();*/

    var uri = Uri.parse('http://10.0.2.2:8080/auth/register');
    var request = http.MultipartRequest('POST', uri);

    request.fields['nick'] = prefs.getString('nick').toString();
    request.fields['email'] = prefs.getString('email').toString();
    request.fields['fechaNacimiento'] =
        prefs.getString('fechaNacimiento').toString();
    request.fields['privacity'] = registerDto.privacity.toString();
    request.fields['password'] = prefs.getString('password').toString();
    request.fields['password2'] = prefs.getString('password2').toString();
    request.files.add(await http.MultipartFile.fromPath(
        'file', prefs.getString('file').toString()));

    var response = await request.send();
    if (response.statusCode == 201) print('Uploaded!');

    if (response.statusCode == 201) {
      return RegisterResponse.fromJson(
          jsonDecode(await response.stream.bytesToString()));
    } else {
      print(response.statusCode);
      throw Exception(prefs.getString('nombre'));
    }
  }
}
