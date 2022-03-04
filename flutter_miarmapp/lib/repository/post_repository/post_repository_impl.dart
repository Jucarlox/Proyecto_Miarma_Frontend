import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_miarmapp/models/PublicPost.dart';
import 'package:flutter_miarmapp/models/post_dto.dart';
import 'package:flutter_miarmapp/repository/post_repository/post_repository.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostRepositoryImpl extends PostRepository {
  final Client _client = Client();

  @override
  Future<List<PublicResponse>> fetchPublicPost(String type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await _client.get(
        Uri.parse('http://10.0.2.2:8080/post/public'),
        headers: {'Authorization': 'Bearer ${prefs.getString("token")}'});
    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((i) => PublicResponse.fromJson(i))
          .toList();
    } else {
      throw Exception('Fail to load psot');
    }
  }

  @override
  Future<String> fetchImagePost(String image) async {
    final response = await _client
        .get(Uri.parse('http://10.0.2.2:8080/download/${image}'), headers: {
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhYzFiMDNiOS03ZjI1LTEzMjgtODE3Zi0yNWUzNWVmMTAwMDAiLCJpYXQiOjE2NDU2MTE3MzcsImVtYWlsIjoianVhbkBnbWFpbC5jb20iLCJyb2xlIjoiVVNFUiJ9.IYUMtrijrAvPx7_lZHc4OCQwojsaA3eK0q2wkuqHcm0'
    });
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Fail to load psot');
    }
  }

  @override
  Future<PublicResponse> createPost(PostDto dto, String image) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, String> pepe = {
      'Authorization': 'Bearer ${prefs.getString('token')}',
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

    /*var request = http.MultipartRequest(
        'POST', Uri.parse('http://10.0.2.2:8080/auth/register/user'))
      ..fields['user'] = jsonEncode(registerDto.toJson())
      ..files.add(await http.MultipartFile.fromPath('file', imagePath));
      request.headers.addAll(headers);
    final response = await request.send();*/

    var uri = Uri.parse('http://10.0.2.2:8080/post/');
    var request = http.MultipartRequest('POST', uri);
    request.fields['title'] = prefs.getString('title').toString();
    request.fields['descripcion'] = prefs.getString('descripcion').toString();
    request.fields['privacity'] = dto.privacity.toString();
    request.files.add(await http.MultipartFile.fromPath(
        'file', prefs.getString('file').toString()));
    request.headers.addAll(pepe);

    var response = await request.send();
    if (response.statusCode == 201) print('Uploaded!');

    if (response.statusCode == 201) {
      return PublicResponse.fromJson(
          jsonDecode(await response.stream.bytesToString()));
    } else {
      print(response.statusCode);
      throw Exception(prefs.getString('title'));
    }
  }
}
