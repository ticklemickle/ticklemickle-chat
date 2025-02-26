class JsonToResult {
  final String name, image, match, description;
  final List<LinkInfo> links;

  JsonToResult({
    required this.name,
    required this.image,
    required this.match,
    required this.description,
    required this.links,
  });

  factory JsonToResult.fromJson(Map<String, dynamic> json) => JsonToResult(
        name: json["name"],
        image: json["image"],
        match: json["match"],
        description: json["description"],
        links: (json["links"] as List<dynamic>)
            .map((link) => LinkInfo.fromJson(link))
            .toList(),
      );
}

class LinkInfo {
  final int level;
  final String title, detail, imagePath;

  LinkInfo({
    required this.level,
    required this.title,
    required this.detail,
    required this.imagePath,
  });

  factory LinkInfo.fromJson(Map<String, dynamic> json) => LinkInfo(
        level: json["level"],
        title: json["title"],
        detail: json["detail"],
        imagePath: json["imagePath"],
      );
}
