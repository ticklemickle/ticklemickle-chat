import 'package:flutter/material.dart';
import 'package:ticklemickle_m/common/themes/colors.dart';
import 'package:ticklemickle_m/screens/chatbot/widget/selectableContrainerState.dart';

class MessageWidget extends StatefulWidget {
  final Map<String, dynamic> messageData;
  final Function(String) onAnswerSelected;

  const MessageWidget({
    super.key,
    required this.messageData,
    required this.onAnswerSelected,
  });

  @override
  _MessageWidgetState createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget>
    with SingleTickerProviderStateMixin {
  String? selectedAnswer;
  late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _fadeInAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    String type = widget.messageData["type"] ?? "text";
    return FadeTransition(
      opacity: _fadeInAnimation,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 7),
        child: Column(
          crossAxisAlignment: type == "userPick"
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            if (type == "text") _buildTextOptions(),
            if (type == "choice") _buildChoiceOptions(),
            if (type == "ox") _buildOXButtons(),
            if (type == "userPick") _buildUserPick(),
          ],
        ),
      ),
    );
  }

  Widget _buildContainer({required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBotProfile(),
        Container(
          width: MediaQuery.of(context).size.width * 0.7,
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            color: MyColors.lightGrey,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: MyColors.lightGrey),
          ),
          child: child,
        )
      ],
    );
  }

  Widget _buildUserPick() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 25),
        decoration: BoxDecoration(
          color: MyColors.mainlightColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: MyColors.mainlightColor),
        ),
        child: Text(
          widget.messageData["message"],
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildTextOptions() {
    return _buildContainer(
      child: Text(
        widget.messageData["message"],
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _buildBotProfile() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipOval(
          child: Image.asset(
            'assets/icon/app_icon_dark.png',
            width: 40,
            height: 40,
            fit: BoxFit.cover, // 이미지가 원 안에 꽉 차도록 설정
          ),
        ),
        SizedBox(width: 10),
      ],
    );
  }

  Widget _buildChoiceOptions() {
    List<String> options = (widget.messageData["options"] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList() ??
        [];

    int totalOptions = options.length;
    int crossAxisCount = (totalOptions == 1)
        ? 1
        : (totalOptions == 2 || totalOptions == 3)
            ? 1
            : (totalOptions == 4)
                ? 2
                : (totalOptions == 5 || totalOptions == 6)
                    ? 3
                    : 2;
    return _buildContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.messageData["message"],
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 20),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: (totalOptions == 1)
                  ? 6 / 1
                  : (totalOptions == 2)
                      ? 5 / 1
                      : (totalOptions == 3)
                          ? 6 / 1
                          : (totalOptions == 4)
                              ? 3 / 1
                              : 1,
            ),
            itemCount: totalOptions,
            itemBuilder: (context, index) {
              return SelectableContainer(
                label: options[index],
                isSelected: selectedAnswer == options[index],
                onTap: selectedAnswer == null
                    ? () {
                        setState(() {
                          selectedAnswer = options[index];
                        });
                        Future.delayed(const Duration(milliseconds: 500), () {
                          if (mounted) {
                            widget.onAnswerSelected(options[index]);
                          }
                        });
                      }
                    : () {},
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildOXButtons() {
    return _buildContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.messageData["message"],
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 20),
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildOXButton("o"),
                const SizedBox(width: 20),
                _buildOXButton("x"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOXButton(String label) {
    return SelectableContainer(
      label: label,
      isSelected: selectedAnswer == label,
      onTap: selectedAnswer == null
          ? () {
              setState(() {
                selectedAnswer = label;
              });
              Future.delayed(const Duration(milliseconds: 500), () {
                widget.onAnswerSelected(label);
              });
            }
          : () {},
    );
  }
}
