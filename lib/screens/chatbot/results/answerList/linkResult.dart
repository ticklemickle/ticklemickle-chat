// 모델 클래스 정의
import 'package:flutter/material.dart';
import 'package:ticklemickle_m/common/widgets/commonAlertSheet.dart';
import 'package:url_launcher/url_launcher.dart';

class JsonToResult {
  final int level;
  final String? title; // Nullable 처리
  final String detail;
  final String imagePath;
  final String link;

  JsonToResult({
    required this.level,
    this.title, // title만 선택적 필드로 설정
    required this.detail,
    required this.imagePath,
    required this.link,
  });

  factory JsonToResult.fromJson(Map<String, dynamic> json) {
    int level = json['level'] as int;
    return JsonToResult(
      level: json['level'] as int,
      title: json['title'] as String? ?? "한국의 재테크 고수 모임", // 기본값 제공
      detail: json['detail'] as String? ?? _defaultDetail(level), // 기본값 적용
      imagePath: json['imagePath'] as String? ?? _defaultImagePath(level),
      link: json['link'] as String? ?? _defaultLink(level),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'level': level,
      'title': title,
      'detail': detail,
      'imagePath': imagePath,
      'link': link,
    };
  }
}

class Result {
  final List<JsonToResult> links;

  Result({required this.links});

  factory Result.fromJson(Map<String, dynamic> json) {
    var linksJson = json['links'] as List<dynamic>;
    List<JsonToResult> linksList =
        linksJson.map((e) => JsonToResult.fromJson(e)).toList();
    return Result(links: linksList);
  }

  Map<String, dynamic> toJson() {
    return {
      'links': links.map((e) => e.toJson()).toList(),
    };
  }
}

// 샘플 데이터 상수 정의
const freeTitle = "재테크 단톡방 참여하기";
const freeDetail = "200명 미만 무료";
const freeImagePath = "assets/chatbot/result/common/free_card.png";
const freeLink = "https://open.kakao.com/o/gLztSsgh";

const groupTitle = "한국의 재테크 고수 모임";
const groupDetail = "20명 미만, 실명, 비대면";
const groupImagePath = "assets/chatbot/result/common/group_card.png";
const paymentLink = "https://www.tosspayments.com";

const vipTitle = "투자 레벨이 맞는 맞춤형 모임";
const vipDetail = "10명 미만, 실명, 오프라인 스터디";
const vipImagePath = "assets/chatbot/result/common/vip_card.png";

Result getchatBotResultLink({List<Map<String, dynamic>>? jsonList}) {
  if (jsonList == null || jsonList.isEmpty) {
    return Result(links: _defaultJsonToResultList());
  }
  List<JsonToResult> links =
      jsonList.map((json) => JsonToResult.fromJson(json)).toList();
  return Result(links: links);
}

// default 값을 반환하는 메서드
List<JsonToResult> _defaultJsonToResultList() {
  return [
    JsonToResult(
      level: 1,
      title: freeTitle,
      detail: freeDetail,
      imagePath: freeImagePath,
      link: freeLink,
    ),
    JsonToResult(
      level: 2,
      title: groupTitle,
      detail: groupDetail,
      imagePath: groupImagePath,
      link: paymentLink,
    ),
    JsonToResult(
      level: 3,
      title: vipTitle,
      detail: vipDetail,
      imagePath: vipImagePath,
      link: paymentLink,
    ),
  ];
}

void handleCardTap(BuildContext context, JsonToResult link) {
  if (link.level == 1) {
    // level 1일 경우 바로 URL 실행 (여기서는 link.link 사용)
    launchUrl(Uri.parse(link.link));
  } else {
    // level 2 이상일 경우 AlertSheet로 결제 안내를 표시
    final String content = _getAlertContent(link.level);
    showCommonAlertSheet(
      context: context,
      title: link.title ?? "",
      subTitle: link.detail,
      content: content,
      confirmText: "동의하고 결제하기",
      onConfirm: () => Navigator.pop(context),
      cancelText: "닫기",
      onCancel: () => Navigator.pop(context),
    );
  }
}

String _getAlertContent(int level) {
  switch (level) {
    case 2:
      return "본 모임은 4,900 원 유료 모임입니다. \n실명으로만 단체 카톡방 참석 가능합니다.\n성향 분석 결과와 유사한 투자 성향을 가진 사람들끼리 모입니다.\n결제가 완료되면, 담당자가 단체 카톡방에 초대해 드립니다.";
    case 3:
      return "본 모임은 50,000 원 유료 모임입니다.\n실명으로만 단체 카톡방 참석 가능합니다.\n성향 분석 결과와 유사한 투자 성향을 갖은 사람들끼리 모입니다.\n소득, 자산, 직업, 지역 등을 종합적으로 고려하여 최적의 멤버들과 그룹을 구성합니다.\n결제가 완료되면, 담당자가 단체 카톡방에 초대해드립니다.";
    default:
      return "";
  }
}

String _defaultDetail(int level) {
  switch (level) {
    case 1:
      return freeDetail;
    case 2:
      return groupDetail;
    case 3:
      return vipDetail;
    default:
      return "기본 설명";
  }
}

String _defaultImagePath(int level) {
  switch (level) {
    case 1:
      return freeImagePath;
    case 2:
      return groupImagePath;
    case 3:
      return vipImagePath;
    default:
      return "assets/default_image.png";
  }
}

String _defaultLink(int level) {
  switch (level) {
    case 1:
      return freeLink;
    case 2:
    case 3:
      return paymentLink;
    default:
      return "https://default-link.com";
  }
}
