import 'package:flutter_miarmapp/models/Profile.dart';
import 'package:flutter_miarmapp/models/PublicPost.dart';

abstract class ProfileRepository {
  Future<VisualizarPerfilResponse> fetchVisualizarPerfil(String type);
}
