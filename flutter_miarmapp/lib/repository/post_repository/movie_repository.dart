import 'package:flutter_miarmapp/models/PublicPost.dart';

abstract class PostRepository {
  Future<List<PublicResponse>> fetchPublicPost(String type);

  Future<String> fetchImagePost(String image);
}
