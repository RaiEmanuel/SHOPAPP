import 'package:flutter/material.dart';
import 'WTextFormField.dart';
import 'package:lottie/lottie.dart';
import 'package:line_icons/line_icons.dart';

class WFormLogin extends StatefulWidget {
  const WFormLogin({Key? key}) : super(key: key);

  @override
  _WFormLoginState createState() => _WFormLoginState();
}

class _WFormLoginState extends State<WFormLogin> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              //logo lottie
              padding: const EdgeInsets.all(0),
              child: Container(
                  width: 250,
                  height: 250,
                  child: Lottie.network(
                    "https://assets6.lottiefiles.com/packages/lf20_kpDkDy/data.json",
                    width: 250,
                    height: 250,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50, right: 50),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: WTextFormField(
                  hint: "Endereço de e-mail",
                  icon: Icons.person,
                  keyboardType: TextInputType.emailAddress,
                ),
                width: 400,
                height: 50,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50, top: 20, right: 50),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: WTextFormField(
                  hint: "Senha",
                  isPassword: true,
                  icon: Icons.password,
                ),
                width: 400,
                height: 50,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                width: 300,
                height: 50,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.teal,
                      onPrimary: Colors.white,
                      shadowColor: Colors.red,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      textStyle: TextStyle(fontSize: 24),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        print("Valido");
                        bool valid = _formKey.currentState!.validate();
                        if (valid) Navigator.pushNamed(context, '/');
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "LOGIN",
                        ),
                        Icon(
                          Icons.login,
                          size: 32,
                        )
                      ],
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(
                        Icons.facebook,
                        color: Colors.teal,
                        size: 60,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Icon(
                          LineIcons.instagram,
                          color: Colors.teal,
                          size: 60,
                        )),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
