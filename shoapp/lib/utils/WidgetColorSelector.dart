import 'package:flutter/material.dart';

import 'ColorApi.dart';

//círculo seletor
class WidgetColorSelector extends StatefulWidget {
  Function()? onTap = () {};
  ColorAPI colorAPI;

  WidgetColorSelector({Key? key, this.onTap, required this.colorAPI})
      : super(key: key);

  @override
  _WidgetColorSelectorState createState() => _WidgetColorSelectorState();
}

class _WidgetColorSelectorState extends State<WidgetColorSelector> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: widget.colorAPI.color,
          ),
          width: 25,
          height: 25,
        ),
      ),
    );
  }
}

class ColorSelector extends StatefulWidget {
  const ColorSelector({Key? key}) : super(key: key);

  @override
  _ColorSelectorState createState() => _ColorSelectorState();
}

//grupo seletor
class _ColorSelectorState extends State<ColorSelector> {
  String grupal = "aaa";

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 120,
          height: 60,
          child: RadioListTile<String>(
            title: Text("Radio"),
            value: "abc",
            groupValue: grupal,
            onChanged: (String? value) {
              setState(() {
                grupal = value!;
              });
            },
          ),
        ),
        Container(
          width: 120,
          height: 60,
          child: RadioListTile<String>(
            title: Text("Radio"),
            value: "def",
            groupValue: grupal,
            onChanged: (String? value) {
              setState(() {
                grupal = value!;
              });
            },
          ),
        ),
      ],
    );
  }
}