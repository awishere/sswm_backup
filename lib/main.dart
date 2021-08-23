import 'package:flutter/material.dart';
import 'package:sswm_web/screens/complain_details.dart';
import 'package:sswm_web/screens/dashboard.dart';
import 'package:sswm_web/screens/login.dart';
import 'package:sswm_web/screens/user_management/user.dart';
import 'package:sswm_web/screens/view/complain_view.dart';

import 'constraints/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SSWM',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: Login.routeName,
      routes: routes,
    );
  }
}
