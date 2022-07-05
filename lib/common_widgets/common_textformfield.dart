import 'package:flutter/material.dart';

class CommonTextFormField extends StatefulWidget {
  double? height;
  double? width;
  String? hintText;
  Function(String)? onChange;
  Function(String?)? onSave;
  TextEditingController? controller;
  Widget? suffixWidget;
  Color? bodyColor;
  CommonTextFormField(
      {this.width,
      this.height,
      this.hintText,
      this.controller,
      this.onChange,
      this.onSave,
      this.bodyColor,
      this.suffixWidget});

  @override
  State<CommonTextFormField> createState() => _CommonTextFormFieldState();
}

class _CommonTextFormFieldState extends State<CommonTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
          color: widget.bodyColor,
          border: Border.all(color: Colors.grey.withOpacity(0.4)),
          borderRadius: BorderRadius.circular(10)),
      child: TextFormField(
        onFieldSubmitted: widget.onSave,
        onChanged: widget.onChange,
        controller: widget.controller,
        decoration: InputDecoration(
            suffixIcon: widget.suffixWidget,
            contentPadding: EdgeInsets.all(10),
            hintText: widget.hintText,
            border: InputBorder.none),
      ),
    );
  }
}
