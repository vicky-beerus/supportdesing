import 'package:flutter/material.dart';

class CommonCircularAvatar extends StatefulWidget {
  Widget? content;
  double? radius;
  Color? backgroundColor;

  CommonCircularAvatar({this.content, this.backgroundColor, this.radius});
  @override
  State<CommonCircularAvatar> createState() => _CommonCircularAvatarState();
}

class _CommonCircularAvatarState extends State<CommonCircularAvatar> {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: widget.radius,
      child: widget.content,
      backgroundColor:
          widget.backgroundColor == null ? Colors.teal : widget.backgroundColor,
    );
  }
}
