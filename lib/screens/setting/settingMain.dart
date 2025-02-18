import 'package:flutter/material.dart';
import 'package:ticklemickle_m/common/themes/colors.dart';
import 'package:ticklemickle_m/common/widgets/commonListScreen.dart';
import 'package:ticklemickle_m/common/widgets/commonToast.dart';
import 'package:ticklemickle_m/common/widgets/setting/commonMenuItem.dart';
import 'package:ticklemickle_m/common/widgets/setting/faqListScreen.dart';
import 'package:go_router/go_router.dart';
import 'package:ticklemickle_m/screens/setting/myInfo.dart';
import 'package:url_launcher/url_launcher.dart';

class Settingmain extends StatelessWidget {
  const Settingmain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("설정"),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {},
          )
        ],
      ),
      body: ListView(children: [
        _buildMyInfo(context, "내 정보"),
        _buildMenuItem(context, "점검 결과 다시 보기", [
          ListItem(
            viewIcon: true,
            title: "TEST",
          )
        ]),
        _buildLinkItem(context, "진행 중인 이벤트", ""),
        _buildLinkItem(context, "공지사항",
            "https://superb-nitrogen-81f.notion.site/18d48074a12d80abbff2c56619b105d9?v=18d48074a12d80b88912000c3389d11c&pvs=4"),
        _buildMenuItem(context, "약관 및 정책", [
          ListItem(
              title: "개인 정보 수집 및 이용 동의",
              viewIcon: false,
              url:
                  "https://superb-nitrogen-81f.notion.site/68fc5d29d52c459e9284af96f2771812?pvs=4"),
          ListItem(
              title: "개인 정보 처리 방침",
              viewIcon: false,
              url:
                  "https://superb-nitrogen-81f.notion.site/bedfe131407645a2af183380542b5536?pvs=4"),
          ListItem(
              title: "서비스 이용약관",
              viewIcon: false,
              url:
                  "https://superb-nitrogen-81f.notion.site/18d48074a12d80d8ab2cec2977e2ece7?pvs=4"),
        ]),
        _buildFAQItem(context, "자주 묻는 질문"),
      ]),
    );
  }

  Widget _buildMenuItem(
      BuildContext context, String title, List<ListItem> items) {
    return CommonMenuItem(
      title: title,
      destinationScreen: CommonListScreen(title: title, items: items),
    );
  }

  Widget _buildFAQItem(BuildContext context, String title) {
    return CommonMenuItem(
      title: title,
      destinationScreen: FaqListScreen(title: title),
    );
  }

  Widget _buildMyInfo(BuildContext context, String title) {
    return CommonMenuItem(
      title: title,
      destinationScreen: MyInfo(),
    );
  }

  Widget _buildLinkItem(BuildContext context, String title, String websiteUrl) {
    return Column(
      children: [
        ListTile(
          title: Text(title),
          onTap: () async {
            if (websiteUrl.isNotEmpty) {
              final Uri url = Uri.parse(websiteUrl!);
              if (await canLaunchUrl(url)) {
                await launchUrl(url, mode: LaunchMode.externalApplication);
              } else {
                showToast(context, "URL을 열 수 없습니다.");
              }
            } else {
              showToast(context, "서비스 준비중입니다.");
            }
          },
        ),
      ],
    );
  }
}
