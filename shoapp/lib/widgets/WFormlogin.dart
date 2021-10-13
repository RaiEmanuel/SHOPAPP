import 'package:flutter/material.dart';
import 'WTextFormField.dart';
import 'package:lottie/lottie.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shoapp/connection/Connection.dart';
import 'dart:convert';
import 'package:shoapp/utils/SharedPreferencesApp.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WFormLogin extends StatefulWidget {
  const WFormLogin({Key? key}) : super(key: key);

  @override
  _WFormLoginState createState() => _WFormLoginState();
}

class _WFormLoginState extends State<WFormLogin> {
  final _formKey = GlobalKey<FormState>();

  //final TextEditingController controllerEmail = TextEditingController(),
  //controllerPassword = TextEditingController();
  final WTextFormField wTextFormFieldEmail = WTextFormField(
    label: "Email",
    hint: "digite seu e-mail",
        icon: Icons.person,
        keyboardType: TextInputType.emailAddress,
      ),
      wTextFormFieldPassword = WTextFormField(
        label: "Senha",
        hint: "Digite sua senha",
        isPassword: true,
        icon: Icons.password,
      );

  //SharedPreferencesApp s = SharedPreferencesApp();
  @override
  void initState() {}

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
                child: wTextFormFieldEmail,
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
                child: wTextFormFieldPassword,
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
                        Connection.auth(wTextFormFieldEmail.getText(),
                                wTextFormFieldPassword.getText())
                            .then((value) {
                          Map<String, dynamic> response = jsonDecode(value);
                          if (response['token'] != null) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Sucesso ao logar!"),
                              backgroundColor: Colors.green,
                            ));
                            final sharedPreferenceApp =
                                SharedPreferences.getInstance()
                                    .then((SharedPreferences value) {
                              value
                                  .setString("type", response['type'])
                                  .then((value) {
                                print("Salvou type...");
                              });
                              value
                                  .setString("token", response['token'])
                                  .then((value) {
                                print("Salvou token...");
                              });
                            });
                            //muda de tela
                            Navigator.pushReplacementNamed(context, '/');
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Credenciais erradas!"),
                              backgroundColor: Colors.red,
                            ));
                          }
                        });
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
