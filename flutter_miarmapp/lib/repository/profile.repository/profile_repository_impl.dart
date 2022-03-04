import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_miarmapp/models/Profile.dart';
import 'package:flutter_miarmapp/models/PublicPost.dart';
import 'package:flutter_miarmapp/repository/post_repository/post_repository.dart';
import 'package:flutter_miarmapp/repository/profile.repository/profile_repository.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  final Client _client = Client();

  @override
  Future<VisualizarPerfilResponse> fetchVisualizarPerfil(String type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await _client.get(Uri.parse('http://10.0.2.2:8080/me'),
        headers: {'Authorization': 'Bearer ${prefs.getString("token")}'});
    if (response.statusCode == 200) {
      return VisualizarPerfilResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Fail to load profile');
    }
  }
}
