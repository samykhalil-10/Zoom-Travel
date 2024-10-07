class Gallary {
  Gallary({
    required this.message,
    required this.content,
  });

  late final String message;
  late final Content content;

  Gallary.fromJson(Map<String, dynamic> json) {
    message = json['message'] ?? "";
    content = Content.fromJson(json['content']);
  }
}

class Content {
  Content({
    required this.images,
  });

  late final List<String> images;

  Content.fromJson(Map<String, dynamic> json) {
    images = List.castFrom<dynamic, String>(json['images'] ?? "");
  }
}
