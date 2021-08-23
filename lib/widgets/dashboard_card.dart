import 'package:flutter/material.dart';
import 'package:sswm_web/constraints/color.dart';

class DashboardCard extends StatelessWidget {
  const DashboardCard(
      {Key key,
      this.color,
      this.description,
      this.icon,
      this.title,
      this.value,
      this.variation,
      this.variationColor})
      : super(key: key);
  final Color color;
  final Color variationColor;
  final IconData icon;
  final String title;
  final String value;
  final String description;
  final String variation;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      width: width / 2.9,
      height: height / 8,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 28.0),
            child: Container(
              height: height / 10,
              width: width / 22,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.all(10),
              child: Icon(
                icon,
                color: variationColor,
                size: 30,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                //  color: Colors.amber,
                width: width / 9.4,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0, left: 5),
                      child: Container(
                        // color: Colors.deepPurple,
                        width: width / 15,
                        height: height / 14,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            title,
                            style: TextStyle(
                                color: Colors.black, fontSize: width / 100),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      // color: Colors.blue,
                      width: width / 60,
                      height: height / 14,
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Icon(
                          Icons.arrow_downward,
                          color: Colors.red,
                          size: width / 110,
                        ),
                      ),
                    ),
                    Container(
                      //   color: Colors.teal,
                      width: width / 50,
                      height: height / 14,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          variation,
                          style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w600,
                              fontSize: width / 140),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                //  color: Colors.cyan,
                width: width / 25,
                height: height / 36,
                child: Text(
                  "  $value",
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: width / 90,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                width: width / 14,
                height: height / 40,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    description,
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w300,
                      fontSize: width / 150,
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
