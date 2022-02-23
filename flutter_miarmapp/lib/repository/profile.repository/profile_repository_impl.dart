import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_miarmapp/models/Profile.dart';
import 'package:flutter_miarmapp/models/PublicPost.dart';
import 'package:flutter_miarmapp/repository/post_repository/movie_repository.dart';
import 'package:flutter_miarmapp/repository/profile.repository/profile_repository.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  final Client _client = Client();

  @override
  Future<VisualizarPerfilResponse> fetchVisualizarPerfil(String type) async {
    final response = await _client.get(
        Uri.parse(
            'http://10.0.2.2:8080/profile/ac1b03b9-7f25-1328-817f-25e35ef10000'),
        headers: {
          'Authorization':
              'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhYzFiMDNiOS03ZjI1LTEzMjgtODE3Zi0yNWUzNWVmMTAwMDAiLCJpYXQiOjE2NDU2MTE3MzcsImVtYWlsIjoianVhbkBnbWFpbC5jb20iLCJyb2xlIjoiVVNFUiJ9.IYUMtrijrAvPx7_lZHc4OCQwojsaA3eK0q2wkuqHcm0'
        });
    if (response.statusCode == 200) {
      return VisualizarPerfilResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Fail to load profile');
    }
  }
}
