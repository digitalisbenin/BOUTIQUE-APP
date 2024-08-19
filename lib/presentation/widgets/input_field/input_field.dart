
import 'package:digitalis_shop_grocery_app/responsive/size_config.dart';
import 'package:digitalis_shop_grocery_app/utils/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final Color bgColor;
  const InputField(
      {super.key,
      required this.label,
      required this.controller,
      required this.bgColor});

  @override
  Widget build(BuildContext context) {
    SizeConfigs().init(context);
    return Container(
      height: SizeConfigs.screenHeight! * 0.07,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          hintText: label,
        ),
      ),
    );
  }
}

class PassWordInput extends StatefulWidget {
  final TextEditingController controller;
  final String text;
  const PassWordInput({super.key, required this.controller, required this.text});

  @override
  State<PassWordInput> createState() => _PassWordInputState();
}

class _PassWordInputState extends State<PassWordInput> {
  bool _isVisiable = false;
  @override
  Widget build(BuildContext context) {
    SizeConfigs().init(context);
    return Container(
      height: SizeConfigs.screenHeight! * 0.07,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: widget.controller,
              obscureText: _isVisiable ? false : true,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                hintText: widget.text,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                _isVisiable = !_isVisiable;
              });
            },
            icon: Icon(_isVisiable ? Icons.visibility : Icons.visibility_off),
          ),
        ],
      ),
    );
  }
}
