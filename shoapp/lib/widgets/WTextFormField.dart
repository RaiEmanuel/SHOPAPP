import 'package:flutter/material.dart';

class WTextFormField extends StatelessWidget {
  final String hint, label;
  final IconData icon;
  final double sizeIcon;
  //final String? Function(String?)? validator;
  //TextEditingController _controller = TextEditingController();
  final TextEditingController _controller = TextEditingController();
  final TextInputType keyboardType;
  final bool isPassword, isActive;

  WTextFormField({
    Key? key,
    this.keyboardType = TextInputType.visiblePassword,
    this.hint = "Default hint",
    this.label = "Default label",
    this.icon = Icons.broken_image_outlined,
    this.sizeIcon = 15,
    this.isPassword = false,
    this.isActive = true
  }) : super(key: key);

  String getText(){
    return _controller.text;
  }

  void setText(String ? value){
    _controller.text = value!;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      cursorColor: Colors.black,
      keyboardType: keyboardType,
      obscureText: isPassword,
      enabled: isActive,
      decoration: new InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          contentPadding:
              EdgeInsets.only(left: 0, bottom: 11, top: 11, right: 15),
          hintText: hint,
          labelText: label,
          icon: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Icon(icon),
          )),
      validator: (value) {
        if (value!.isEmpty) {
          return "Campo não pode ser vazio!";
        }
      },
    );
  }
}
