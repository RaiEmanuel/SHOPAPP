import 'package:flutter/material.dart';

class WText extends StatelessWidget {
  final String text;
  final Color color;
  final double topPadding, rightPadding, bottomPadding, leftPadding, fontHeight;

  WText(
      {Key? key,
      this.text = "Default",
      this.color = Colors.white,
      this.topPadding = 0,
      this.rightPadding = 0,
      this.bottomPadding = 0,
      this.leftPadding = 0,
      this.fontHeight = 12})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: topPadding,
          right: rightPadding,
          bottom: bottomPadding,
          left: leftPadding
          //left: 50
          ),
      child: Text(
        text,
        style: TextStyle(
            color: color, fontWeight: FontWeight.bold, fontSize: fontHeight),
      ),
    );
  }
}
