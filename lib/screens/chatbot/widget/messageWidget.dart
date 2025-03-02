import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ticklemickle_m/common/themes/colors.dart';
import 'package:ticklemickle_m/common/utils/StringUtil.dart';
import 'package:ticklemickle_m/screens/chatbot/widget/selectableContrainerState.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

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
  final TextEditingController _inputController = TextEditingController();
  List<String> _multiSelectedOptions = [];
  bool _submitPressed = true;

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
            if (type == "choice" || type == "basic") _buildChoiceOptions(),
            if (type == "multi-choice") _buildMultiChoiceOptions(),
            if (type == "ox") _buildOXButtons(),
            if (type == "userPick") _buildUserPick(),
            if (type == "input") _buildInputOptions(),
          ],
        ),
      ),
    );
  }

  Widget _buildMultiChoiceOptions() {
    List<String> options = (widget.messageData["options"] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList() ??
        [];

    int totalOptions = options.length;
    int crossAxisCount = (totalOptions <= 3)
        ? 1
        : (totalOptions <= 6)
            ? 3
            : 2;

    return _buildContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.messageData["message"] ?? "",
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 20),
          StaggeredGrid.count(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            children: List.generate(totalOptions, (index) {
              final option = options[index];
              final bool isSelected = _multiSelectedOptions.contains(option);

              return StaggeredGridTile.fit(
                crossAxisCellCount: 1,
                child: SelectableContainer(
                  label: option,
                  isSelected: isSelected,
                  onTap: _submitPressed
                      ? () {
                          setState(() {
                            if (isSelected) {
                              _multiSelectedOptions.remove(option);
                            } else {
                              _multiSelectedOptions.add(option);
                            }
                          });
                        }
                      : () {},
                ),
              );
            }),
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: _submitPressed
                  ? () {
                      if (_multiSelectedOptions.isNotEmpty) {
                        // 선택된 항목들을 쉼표로 연결하거나, 원하는 형식으로 변환
                        final String joined = _multiSelectedOptions.join(",");

                        // 부모 위젯으로 전달 -> userPick 메시지 생성
                        widget.onAnswerSelected(joined);

                        // 선택 항목 초기화(필요에 따라 조정)
                        // setState(() {
                        //   _multiSelectedOptions.clear();
                        // });
                        setState(() {
                          _submitPressed = false;
                        });
                      }
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: MyColors.mainColor,
              ),
              child: const Text("제출"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputOptions() {
    return _buildContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.messageData["message"] ?? "",
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 12),
          TextField(
            enabled: _submitPressed,
            controller: _inputController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: widget.messageData["message-hint"] ?? "",
              border: OutlineInputBorder(),
              isDense: true,
              contentPadding: const EdgeInsets.all(10),
              counterText: '',
            ),
            maxLength: 6,
            // 오직 숫자만 입력되도록
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            onChanged: (value) {
              String digits = value.replaceAll(RegExp(r'[^\d]'), '');
              // 첫번째 숫자가 '0'이면 더 이상 입력되지 않도록 (이미 0이면 그대로)
              if (digits.length > 1 && digits.startsWith('0')) {
                digits = digits.substring(0, 1);
              }
              // 포맷팅된 문자열 생성
              String formatted = formatAmount(digits);

              if (formatted != value) {
                _inputController.value = _inputController.value.copyWith(
                  text: formatted,
                  // selection: TextSelection.collapsed(offset: formatted.length),(커서 위치 마지막으로 이동)
                );
              }
            },
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: _submitPressed
                  ? () {
                      final inputValue = _inputController.text.trim();
                      if (inputValue.isNotEmpty) {
                        widget.onAnswerSelected(inputValue);
                        setState(() {
                          _submitPressed = false;
                        });
                      }
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: MyColors.mainColor,
              ),
              child: const Text("확인"),
            ),
          ),
        ],
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
            widget.messageData["message"] ?? "",
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 20),
          StaggeredGrid.count(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            children: List.generate(totalOptions, (index) {
              return StaggeredGridTile.fit(
                crossAxisCellCount: 1,
                child: SelectableContainer(
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
                ),
              );
            }),
          )
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
