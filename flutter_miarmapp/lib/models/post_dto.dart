class PostDto {
  String? title;
  String? descripcion;
  bool? privacity;

  PostDto({
    this.title,
    this.descripcion,
    this.privacity,
  });

  PostDto.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    descripcion = json['descripcion'];
    privacity = json['privacity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['descripcion'] = descripcion;
    data['privacity'] = privacity;
    return data;
  }
}
