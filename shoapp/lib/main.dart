import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoapp/routes/RouteMap.dart';
import 'routes/RouteProduct.dart';
import 'routes/RouteLogin.dart';
import 'widgets/WTabPage.dart';
import 'PCartModel.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CartModel(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/login',
        routes: {
          '/': (BuildContext context) => TabPage(),
          '/product': (BuildContext context) => RouteProduct(),
          '/login': (BuildContext context) => RouteLogin(),
          '/map': (BuildContext context) => RouteMap(),
        },
      ),
    ),
  );
}