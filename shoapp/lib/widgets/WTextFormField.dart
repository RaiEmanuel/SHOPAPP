import 'package:flutter/material.dart';

class WTextFormField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final double sizeIcon;
  //final String? Function(String?)? validator;
  //TextEditingController _controller = TextEditingController();
  final TextEditingController _controller = TextEditingController();
  final TextInputType keyboardType;
  final bool isPassword;

  WTextFormField({
    Key? key,
    this.keyboardType = TextInputType.visiblePassword,
    this.hint = "Default hint",
    this.icon = Icons.broken_image_outlined,
    this.sizeIcon = 15,
    this.isPassword = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      cursorColor: Colors.black,
      keyboardType: keyboardType,
      obscureText: isPassword,
      decoration: new InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          contentPadding:
              EdgeInsets.only(left: 0, bottom: 11, top: 11, right: 15),
          hintText: hint,
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
