import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_miarmapp/models/PublicPost.dart';
import 'package:flutter_miarmapp/repository/post_repository/movie_repository.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class PostRepositoryImpl extends PostRepository {
  final Client _client = Client();

  @override
  Future<List<PublicResponse>> fetchPublicPost(String type) async {
    final response = await _client
        .get(Uri.parse('http://10.0.2.2:8080/post/public'), headers: {
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhYzFiMDNiOS03ZjI1LTEzMjgtODE3Zi0yNWUzNWVmMTAwMDAiLCJpYXQiOjE2NDU2MTE3MzcsImVtYWlsIjoianVhbkBnbWFpbC5jb20iLCJyb2xlIjoiVVNFUiJ9.IYUMtrijrAvPx7_lZHc4OCQwojsaA3eK0q2wkuqHcm0'
    });
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
}
