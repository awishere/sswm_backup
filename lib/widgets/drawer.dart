import 'package:flutter/material.dart';
import 'package:sswm_web/constraints/color.dart';

drawer({double height, double width, BuildContext context}) {
  return Drawer(
      child: ListView(
    // Important: Remove any padding from the ListView.
    padding: EdgeInsets.zero,
    children: <Widget>[
      Container(
        color: scaffoldColor,
        child: DrawerHeader(
          child: Container(
            //color: scaffoldColor,
            decoration: BoxDecoration(
              // color: scaffoldColor,
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: NetworkImage("https://i.imgur.com/BoN9kdC.png"),
                  fit: BoxFit.fill),
            ),
          ),
        ),
      ),
      Center(child: Text('Usman Khan')),
      ListTile(
        title: Text('Profile'),
        onTap: () {
          // Update the state of the app.
          // ...
        },
      ),
      ListTile(
        title: Text('Stats'),
        onTap: () {
          // Update the state of the app.
          // ...
        },
      ),
    ],
  ));
}
