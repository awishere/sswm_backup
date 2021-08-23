import 'package:flutter/material.dart';
import 'package:sswm_web/constraints/color.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:sswm_web/screens/activereports.dart';
import 'package:sswm_web/screens/login.dart';
import 'package:sswm_web/screens/totalreport.dart';
import 'package:sswm_web/screens/user_management/user.dart';
import 'package:sswm_web/screens/view/complain_view.dart';
import 'package:sswm_web/widgets/appbar.dart';
import 'package:sswm_web/widgets/dashboard_card.dart';
import 'package:sswm_web/widgets/sidebar.dart';

class DashboardPage extends StatefulWidget {
  static String routeName = "/dashboard";
  const DashboardPage({Key key}) : super(key: key);
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(
        height: height,
        width: width,
        context: context,
      ),
      body: ListView(children: [
        Stack(
          children: [
            Container(height: height, width: width / 6, child: Sidebar()),
            Align(
                alignment: Alignment.centerRight,
                child: Container(
                  // color: Colors.red,
                  height: height / 2,
                  width: width / 1.2,
                  child: Center(
                    child: Carousel(
                      boxFit: BoxFit.cover,
                      autoplay: true,
                      animationCurve: Curves.fastOutSlowIn,
                      animationDuration: Duration(milliseconds: 1000),
                      dotSize: 6.0,
                      dotIncreasedColor: Color(0xFFFF335C),
                      dotBgColor: Colors.transparent,
                      dotPosition: DotPosition.topRight,
                      dotVerticalPadding: 10.0,
                      showIndicator: true,
                      indicatorBgPadding: 7.0,
                      images: [
                        AssetImage('assets/images/Carousel1.jpg'),
                        AssetImage('assets/images/Carousel2.jfif'),

                        //ExactAssetImage("assets/images/LaunchImage.jpg"),
                      ],
                    ),
                  ),
                )),
            Positioned(
              top: height / 2,
              left: height / 3,
              child: Container(
                height: height / 2,
                width: width / 1.2,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: width / 5.5,
                          height: height / 6,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  ComplainsView.routeName,
                                );
                              },
                              child: DashboardCard(
                                description: "Over last month , \# 299",
                                icon: Icons.check,
                                title: "Total    Reports",
                                value: "927",
                                color: scaffoldColor.withOpacity(0.1),
                                variation: "- 10%",
                                variationColor: Colors.amber,
                              )),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: width / 5.5,
                          height: height / 6,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Activereport()),
                                );
                              },
                              child: DashboardCard(
                                description: "Over last month , \# 215",
                                icon: Icons.comment,
                                title: "Active    Reports",
                                value: "633",
                                color: scaffoldColor.withOpacity(0.1),
                                variation: "- 19%",
                                variationColor: Colors.amber,
                              )),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: width / 5.5,
                          height: height / 6,
                          decoration: BoxDecoration(
                            //  color: Colors.purple,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Totalreport()),
                                );
                              },
                              child: DashboardCard(
                                description: "Over last month , \# 55",
                                icon: Icons.check,
                                title: "Completed Reports",
                                value: "761",
                                color: scaffoldColor.withOpacity(0.1),
                                variation: "- 15%",
                                variationColor: Colors.amber,
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: height / 1.1,
              right: 0,
              child: Column(
                children: [
                  Text('SOLID',
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                          fontSize: 11,
                          fontFamily: 'Muli-Bold')),
                  Padding(
                    padding: const EdgeInsets.only(left: 3.0),
                    child: Text('Waste',
                        style: TextStyle(
                            color: Colors.amber,
                            fontWeight: FontWeight.w900,
                            fontSize: 11,
                            fontFamily: 'Muli-Bold')),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Text('Management',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 11,
                            fontFamily: 'Muli')),
                  ),
                ],
              ),
            )
          ],
        ),
      ]),
    );
  }
}
