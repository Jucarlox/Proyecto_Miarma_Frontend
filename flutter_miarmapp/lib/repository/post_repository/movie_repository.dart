import 'package:flutter_miarmapp/models/PublicPost.dart';
import 'package:flutter_miarmapp/models/post_dto.dart';

abstract class PostRepository {
  Future<List<PublicResponse>> fetchPublicPost(String type);
  Future<PublicResponse> createPublicacion(PostDto dto, String image);

  Future<String> fetchImagePost(String image);
}
