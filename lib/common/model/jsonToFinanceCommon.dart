class JsonToResultCommon {
  final String image, match, description, sub, title;

  JsonToResultCommon({
    required this.image,
    required this.sub,
    required this.title,
    required this.match,
    required this.description,
  });

  factory JsonToResultCommon.fromJson(Map<String, dynamic> json) =>
      JsonToResultCommon(
        image: json["image"],
        sub: json["sub"],
        title: json["title"],
        match: json["match"],
        description: json["description"],
      );
}
