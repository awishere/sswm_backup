import 'package:flutter/material.dart';
import 'package:sswm_web/screens/complain_details.dart';
import 'package:sswm_web/screens/dashboard.dart';
import 'package:sswm_web/screens/login.dart';
import 'package:sswm_web/screens/user_management/edit_user.dart';
import 'package:sswm_web/screens/user_management/user.dart';
import 'package:sswm_web/screens/view/complain_view.dart';
import 'package:sswm_web/widgets/complain_view_widget.dart';

final Map<String, WidgetBuilder> routes = {
  DashboardPage.routeName: (context) => DashboardPage(),
  Login.routeName: (context) => Login(),
  ComplainDetails.routeName: (context) => ComplainDetails(),
  ComplainsView.routeName: (context) => ComplainsView(),
  UserView.routeName: (context) => UserView(),
  EditUser.routeName: (context) => EditUser(),
};
