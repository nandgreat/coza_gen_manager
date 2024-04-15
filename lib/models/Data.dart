class Data {
  Data({
      this.imageUrl,});

  Data.fromJson(dynamic json) {
    imageUrl = json['image_url'];
  }
  String? imageUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['image_url'] = imageUrl;
    return map;
  }

}