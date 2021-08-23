import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sswm_web/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

appBar(
    {double height,
    double width,
    BuildContext context,
    SharedPreferences sharedPreferences}) {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: Color(0xff102733),
    elevation: 0,
    title: Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        children: [
          Text('SOLID',
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  fontSize: 26,
                  fontFamily: 'Muli-Bold')),
          Padding(
            padding: const EdgeInsets.only(left: 3.0),
            child: Text('Waste',
                style: TextStyle(
                    color: Colors.amber,
                    fontWeight: FontWeight.w900,
                    fontSize: 26,
                    fontFamily: 'Muli-Bold')),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Text('Management',
                style: TextStyle(
                    color: Colors.grey, fontSize: 26, fontFamily: 'Muli')),
          ),
        ],
      ),
    ),
    actions: <Widget>[
      Container(
        //color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: [
                // IconButton(
                //   icon: Padding(
                //     padding: const EdgeInsets.only(top: 8.0),
                //     child: Icon(
                //       Icons.notifications,
                //       color: Colors.white,
                //     ),
                //   ),
                //   onPressed: () {
                //     sharedPreferences.clear();
                //     sharedPreferences.commit();
                //     Navigator.of(context).pushAndRemoveUntil(
                //         MaterialPageRoute(
                //             builder: (BuildContext context) => Login()),
                //         (Route<dynamic> route) => false);
                //   },
                // )
              ],
            )
          ],
        ),
      ),
      Theme(
        data: Theme.of(context).copyWith(
            textTheme: TextTheme().apply(bodyColor: Colors.white),
            dividerColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.white)),
        child: PopupMenuButton<int>(
          icon: Icon(Icons.arrow_drop_down),
          color: Colors.white,
          itemBuilder: (context) => [
            PopupMenuItem<int>(value: 0, child: Text("Setting")),
            PopupMenuItem<int>(value: 1, child: Text("Privacy Policy page")),
            PopupMenuDivider(),
            PopupMenuItem<int>(
                value: 2,
                child: Row(
                  children: [
                    Icon(
                      Icons.logout,
                      color: Colors.red,
                    ),
                    const SizedBox(
                      width: 7,
                    ),
                    Text("Logout")
                  ],
                )),
          ],
          onSelected: (item) => SelectedItem(context, item),
        ),
      ),
    ],
  );
}

void SelectedItem(BuildContext context, item) {
  switch (item) {
    case 0:
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Login()));
      break;
    case 1:
      print("Privacy Clicked");
      break;
    case 2:
      print("User Logged out");
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Login()), (route) => false);
      break;
  }
}
