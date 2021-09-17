import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'routes/RouteProduct.dart';
import 'routes/RouteLogin.dart';
import 'widgets/WTabPage.dart';
import 'PCartModel.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => CartModel(),
          ),
        ],
        child: MaterialApp(
          initialRoute: '/login',
          routes: {
            '/': (BuildContext context) => TabPage(),
            '/product': (BuildContext context) => RouteProduct(),
            '/login': (BuildContext context) => RouteLogin(),
          },
        ),
      ),
    );
