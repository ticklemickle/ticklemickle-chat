class JsonToResult {
  final String image, match, description, sub, title;

  JsonToResult({
    required this.image,
    required this.sub,
    required this.title,
    required this.match,
    required this.description,
  });

  factory JsonToResult.fromJson(Map<String, dynamic> json) => JsonToResult(
        image: json["image"],
        sub: json["sub"],
        title: json["title"],
        match: json["match"],
        description: json["description"],
      );
}
