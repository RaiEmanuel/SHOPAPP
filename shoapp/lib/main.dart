import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoapp/routes/RouteMap/RouteMap.dart';
import 'package:shoapp/utils/SharedPreferencesApp.dart';
import 'pCartModel.dart';
import 'routes/RouteProduct/RouteProduct.dart';
import 'routes/login/RouteLogin.dart';
import 'routes/tabpage/RouteTabPage.dart';
import 'package:shoapp/pCartModel.dart';
import 'package:shoapp/routes/RoutePurchases/RouteMyPurchases.dart';
import 'package:shoapp/routes/RouteFeedback/RouteFeedback.dart';
import 'package:shoapp/routes/RoutePostFeedback/RoutePostFeedback.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PCartModel(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/login',
        routes: {
          '/': (BuildContext context) => RouteTabPage(),
          '/product': (BuildContext context) => RouteProduct(),
          '/login': (BuildContext context) => RouteLogin(),
          '/map': (BuildContext context) => RouteMap(),
          '/feedback': (BuildContext context) => RouteFeedback(),
          '/postfeedback': (BuildContext context) => RoutePostFeedback(),
          '/mypurchases': (BuildContext context) => RouteMyPuchases(),
        },
      ),
    ),
  );
}