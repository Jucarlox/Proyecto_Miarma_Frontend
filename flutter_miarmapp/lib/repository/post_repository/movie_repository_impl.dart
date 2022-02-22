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
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJjMGE4MzgwMS03ZjIyLTE5NTItODE3Zi0yMjg5NmE4OTAwMDAiLCJpYXQiOjE2NDU1NTU1MDcsImVtYWlsIjoianVhbkBnbWFpbC5jb20iLCJyb2xlIjoiVVNFUiJ9.09CiAk6Bx4S5HwLL3LtWkYpZh1Hd6vWoFBIsmkNTucs'
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
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhYzFiMDNiOS03ZjIxLTE5ODUtODE3Zi0yMTM5Y2RmNzAwMDAiLCJpYXQiOjE2NDU1MzM1MTUsImVtYWlsIjoianVhbkBnbWFpbC5jb20iLCJyb2xlIjoiVVNFUiJ9.OwF0Zo5OfmZRKufrvflOk50_IfUhWRy5-mrDoA4ZUPc'
    });
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Fail to load psot');
    }
  }
}
