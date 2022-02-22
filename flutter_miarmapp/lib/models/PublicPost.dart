class PublicResponse {
  PublicResponse({
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

  PublicResponse.fromJson(Map<String, dynamic> json) {
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
