import 'package:flutter/material.dart';
import 'package:sswm_web/constraints/color.dart';

reportcard(
    {double height,
    double width,
    BuildContext context,
    String heading,
    String no}) {
  return Container(
    width: width / 8,
    height: height / 6,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      // color: Color(0xff29404e),
    ),
    child: GestureDetector(
      onTap: () {
        //  Navigator.push(
        //   context,
        //    MaterialPageRoute(builder: (context) => TotalReports()),
        //  );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Color(0xff29404e),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(no,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold)),
            Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            Flexible(
                child: Text(
              heading,
              style: TextStyle(
                  color: Colors.amber, fontSize: 16, fontFamily: 'Muli'),
            )),
          ],
        ),
      ),
    ),
  );
}
