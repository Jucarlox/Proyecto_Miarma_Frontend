class LoginResponse {
  LoginResponse(
      {required this.email,
      required this.nike,
      required this.role,
      required this.token,
      required this.id});
  late final String email;
  late final String nike;
  late final String role;
  late final String token;
  late final String id;

  LoginResponse.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    nike = json['nike'];
    role = json['role'];
    token = json['token'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['email'] = email;
    _data['nike'] = nike;
    _data['role'] = role;
    _data['token'] = token;
    _data['id'] = id;
    return _data;
  }
}
