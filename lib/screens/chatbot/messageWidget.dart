import 'package:flutter/material.dart';
import 'package:ticklemickle_m/common/themes/colors.dart';

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
  static const double QUESTION_WIDTH = 400;

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
      child: Column(
        crossAxisAlignment: type == "answer"
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          if (type == "text") _buildTextOptions(),
          if (type == "choice") _buildChoiceOptions(),
          if (type == "ox") _buildOXButtons(),
        ],
      ),
    );
  }

  Widget _buildContainer({required Widget child}) {
    return Container(
      width: QUESTION_WIDTH,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: MyColors.lightGrey,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: MyColors.lightGrey),
      ),
      child: child,
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

  Widget _buildChoiceOptions() {
    List<String> options = (widget.messageData["options"] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList() ??
        [];

    int totalOptions = options.length;
    int crossAxisCount = (totalOptions == 1)
        ? 1
        : (totalOptions == 3)
            ? 3
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
                  ? 8 / 1
                  : (totalOptions == 3)
                      ? 3 / 1
                      : (totalOptions == 2 || totalOptions == 4)
                          ? 4 / 1
                          : 1,
            ),
            itemCount: totalOptions,
            itemBuilder: (context, index) {
              return _buildSelectableContainer(
                label: options[index],
                isSelected: selectedAnswer == options[index],
                onTap: () {
                  setState(() {
                    selectedAnswer = options[index];
                  });
                  Future.delayed(const Duration(milliseconds: 500), () {
                    if (mounted) {
                      widget.onAnswerSelected(options[index]);
                    }
                  });
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSelectableContainer({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80,
        height: 80,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: isSelected ? Colors.cyan : Colors.white,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha((0.2 * 255).toInt()),
              spreadRadius: 0,
              blurRadius: 1,
              offset: const Offset(1, 1),
            ),
          ],
        ),
        child: (label == "o" || label == "x")
            ? Image.asset(
                'assets/chatbot/question/$label.png',
                width: 40,
                height: 40,
                fit: BoxFit.contain,
              )
            : Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: isSelected ? Colors.cyan : Colors.black,
                ),
              ),
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
            width: QUESTION_WIDTH,
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
    return _buildSelectableContainer(
      label: label,
      isSelected: selectedAnswer == label,
      onTap: () {
        setState(() {
          selectedAnswer = label;
        });
        Future.delayed(const Duration(milliseconds: 500), () {
          widget.onAnswerSelected(label);
        });
      },
    );
  }
}
