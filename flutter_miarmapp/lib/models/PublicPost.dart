class PublicResponse {
  PublicResponse({
    required this.id,
    required this.title,
    required this.descripcion,
    required this.fileScale,
    required this.privacity,
  });
  late final int id;
  late final String title;
  late final String descripcion;
  late final String fileScale;
  late final String privacity;

  PublicResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    descripcion = json['descripcion'];
    fileScale = json['fileScale'];
    privacity = json['privacity'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['descripcion'] = descripcion;
    _data['fileScale'] = fileScale;
    _data['privacity'] = privacity;
    return _data;
  }
}
