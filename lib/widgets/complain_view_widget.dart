import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:sswm_web/constraints/color.dart';
import 'package:sswm_web/models/complain.dart';
import 'package:sswm_web/screens/complain_details.dart';

class ComplainsList extends StatelessWidget {
  final List<Complain> complain;
  final Function onEditTap;
  final Function onViewTap;
  final Function onDeleteTap;
  ComplainsList(
      {Key key,
      this.complain,
      this.onEditTap,
      this.onViewTap,
      this.onDeleteTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      // width: MediaQuery.of(context).size.width / 1,
      child: ListView.builder(
        itemCount: complain.length,
        itemBuilder: (context, index) {
          Uint8List bytes = base64.decode(complain[index].extras);
          return Padding(
              padding: const EdgeInsets.only(top: 10.0, right: 12, left: 15),
              child: Center(
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  elevation: 16,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ComplainDetails(
                              complainID: complain[index].id.toString(),
                              extras: complain[index].extras,
                              complainSubject: complain[index].subject,
                              complainAddress: complain[index].address,
                              complainDescription: complain[index].description,
                              complainFullName: complain[index].fullName,
                              complainStatus: complain[index].status,
                              userID: complain[index].userID,
                              vid: complain[index].vid),
                        ),
                      );
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          alignment: Alignment.bottomLeft,
                          children: [
                            Image.memory(
                              bytes,
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 6,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                complain[index].subject,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16, top: 8, right: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                complain[index].description,
                                style: TextStyle(color: Colors.black54),
                              ),
                              Text(complain[index].address),
                            ],
                          ),
                        ),
                        ButtonBar(
                          alignment: MainAxisAlignment.start,
                          children: <Widget>[
                            FlatButton(
                                onPressed: () {},
                                child: Text(
                                  'View Details',
                                  style: TextStyle(color: Colors.amberAccent),
                                )),
                            TextButton(
                                onPressed: () {
                                  onDeleteTap(complain[index].id.toString());
                                },
                                child: Text(
                                  'Delete',
                                  style: TextStyle(color: Colors.amberAccent),
                                ))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }
}
