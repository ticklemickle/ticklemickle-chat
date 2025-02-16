// lookalike.dart
class Lookalike {
  final String name;
  final String image;
  final String match;
  final String description;
  final List<LinkInfo> links;

  Lookalike({
    required this.name,
    required this.image,
    required this.match,
    required this.description,
    required this.links,
  });

  /// JSON 데이터를 객체로 변환하는 메서드
  factory Lookalike.fromJson(Map<String, dynamic> json) {
    return Lookalike(
      name: json["name"],
      image: json["image"],
      match: json["match"],
      description: json["description"],
      links: (json["links"] as List)
          .map((link) => LinkInfo.fromJson(link))
          .toList(),
    );
  }
}

class LinkInfo {
  final int level;
  final String title;
  final String detail;
  final String imagePath;

  LinkInfo({
    required this.level,
    required this.title,
    required this.detail,
    required this.imagePath,
  });

  /// JSON 데이터를 객체로 변환하는 메서드
  factory LinkInfo.fromJson(Map<String, dynamic> json) {
    return LinkInfo(
      level: json["level"],
      title: json["title"],
      detail: json["detail"],
      imagePath: json["imagePath"],
    );
  }
}
