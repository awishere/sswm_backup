import 'package:flutter/material.dart';
import 'package:sswm_web/constraints/color.dart';
import 'package:sswm_web/screens/dashboard.dart';
import 'package:sswm_web/screens/login.dart';
import 'package:sswm_web/screens/user_management/user.dart';
import 'package:sswm_web/screens/view/complain_view.dart';
import 'package:sswm_web/widgets/menu_item.dart';

class Sidebar extends StatefulWidget {
  const Sidebar({
    Key key,
  }) : super(key: key);

  @override
  _SidebarState createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  bool isAct1 = false;
  bool isAct2 = false;
  bool isAct3 = false;
  bool isAct4 = false;
  bool isAct5 = false;
  bool isAct6 = false;
  bool isAct7 = false;
  bool isAct8 = false;

  String cname;

  void updateName(String name) {
    setState(() {
      this.cname = name;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCnamePreference().then(updateName);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
      decoration: BoxDecoration(
        color: scaffoldColor,
      ),
      width: MediaQuery.of(context).size.width / 4,
      height: MediaQuery.of(context).size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                Container(
                  color: scaffoldColor,
                  child: CircleAvatar(
                    child: Container(
                      //color: scaffoldColor,
                      decoration: BoxDecoration(
                        // color: scaffoldColor,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage('assets/images/Picture1.png'),
                            fit: BoxFit.fill),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  cname,
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Menu",
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isAct1 = true;
                  isAct2 = false;
                  isAct3 = false;
                  isAct4 = false;
                  isAct5 = false;
                  isAct6 = false;
                  isAct7 = false;
                  isAct8 = false;
                });
                Navigator.pushNamed(context, DashboardPage.routeName);
              },
              child: MenuItem(
                label: "Dashboard",
                icon: Icons.apps,
                isActive: isAct1,
              ),
            ),
          ),
          Container(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isAct1 = false;
                  isAct2 = true;
                  isAct3 = false;
                  isAct4 = false;
                  isAct5 = false;
                  isAct6 = false;
                  isAct7 = false;
                  isAct8 = false;
                });
                Navigator.pushNamed(context, ComplainsView.routeName);
              },
              child: MenuItem(
                label: "Reports",
                icon: Icons.comment,
                isActive: isAct2,
              ),
            ),
          ),
          Container(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isAct1 = false;
                  isAct2 = false;
                  isAct3 = false;
                  isAct4 = false;
                  isAct5 = true;
                  isAct6 = false;
                  isAct7 = false;
                  isAct8 = false;
                });
                Navigator.pushNamed(context, UserView.routeName);
              },
              child: MenuItem(
                label: "User Management",
                icon: Icons.people_outline,
                isActive: isAct5,
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
