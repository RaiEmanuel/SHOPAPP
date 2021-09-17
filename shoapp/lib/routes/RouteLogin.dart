import 'package:flutter/material.dart';
import 'package:shoapp/widgets/WFormlogin.dart';

class RouteLogin extends StatelessWidget {
  const RouteLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Text(
                "Ecommerce",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            WFormLogin()
          ],
        ),
        decoration: BoxDecoration(color: Colors.grey[300]),
      ),
    );
  }
}
