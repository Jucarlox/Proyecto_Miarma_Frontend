class VisualizarPerfilResponse {
  VisualizarPerfilResponse({
    required this.id,
    required this.nick,
    required this.email,
    required this.fechaNacimiento,
    required this.avatar,
    required this.estado,
    required this.postList,
  });
  late final String id;
  late final String nick;
  late final String email;
  late final String fechaNacimiento;
  late final String avatar;
  late final String estado;
  late final List<PostList> postList;

  VisualizarPerfilResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nick = json['nick'];
    email = json['email'];
    fechaNacimiento = json['fechaNacimiento'];
    avatar = json['avatar'];
    estado = json['estado'];
    postList =
        List.from(json['postList']).map((e) => PostList.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['nick'] = nick;
    _data['email'] = email;
    _data['fechaNacimiento'] = fechaNacimiento;
    _data['avatar'] = avatar;
    _data['estado'] = estado;
    _data['postList'] = postList.map((e) => e.toJson()).toList();
    return _data;
  }
}

class PostList {
  PostList({
    required this.id,
    required this.title,
    required this.descripcion,
    required this.fileScale,
    required this.privacity,
    required this.user,
  });
  late final int id;
  late final String title;
  late final String descripcion;
  late final String fileScale;
  late final String privacity;
  late final User user;

  PostList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    descripcion = json['descripcion'];
    fileScale = json['fileScale'];
    privacity = json['privacity'];
    user = User.fromJson(json['user']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['descripcion'] = descripcion;
    _data['fileScale'] = fileScale;
    _data['privacity'] = privacity;
    _data['user'] = user.toJson();
    return _data;
  }
}

class User {
  User({
    required this.id,
    required this.nick,
    required this.email,
    required this.fechaNacimiento,
    required this.avatar,
    required this.estado,
  });
  late final String id;
  late final String nick;
  late final String email;
  late final String fechaNacimiento;
  late final String avatar;
  late final String estado;

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nick = json['nick'];
    email = json['email'];
    fechaNacimiento = json['fechaNacimiento'];
    avatar = json['avatar'];
    estado = json['estado'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['nick'] = nick;
    _data['email'] = email;
    _data['fechaNacimiento'] = fechaNacimiento;
    _data['avatar'] = avatar;
    _data['estado'] = estado;
    return _data;
  }
}
