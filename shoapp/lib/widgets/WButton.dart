import 'package:flutter/material.dart';
import '../Product.dart';
import './WText.dart';

class WButton extends StatelessWidget {
  final String text;
  final double width, height;
  final Product? p;
  final IconData icon;
  final Color color, colorText, colorIcon;
  final double sizeIcon, sizeText;
  final Function() onTap;

  WButton({
    Key? key,
    this.width = 50,
    this.height = 50,
    this.text = "",
    this.icon = Icons.search_rounded,
    this.p,
    required this.onTap,
    this.color = Colors.teal,
    this.colorText = Colors.white,
    this.sizeIcon = 30,
    this.sizeText = 18,
    this.colorIcon = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 0, fixedSize: Size(width, height), primary: color
            //padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            ),
        onPressed: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /*Text(
              text,
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),*/
            WText(
              text: text,
              color: colorText,
              fontHeight: sizeText,
            ),
            Icon(
              icon,
              color: colorIcon,
              size: sizeIcon,
            ),
          ],
        ));
  }
}
