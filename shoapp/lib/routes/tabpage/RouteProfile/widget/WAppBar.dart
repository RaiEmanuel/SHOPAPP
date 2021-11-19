import 'package:flutter/material.dart';

class WidgetAppBar extends StatelessWidget {
  WidgetAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("Perfil"),
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back_ios),
        iconSize: 30,
      ),
    );
  }
}
