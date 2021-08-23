import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sswm_web/models/complain.dart';

import 'package:sswm_web/widgets/appbar.dart';
import 'package:sswm_web/widgets/complain_view_widget.dart';

import 'package:sswm_web/widgets/sidebar.dart';
import 'package:http/http.dart' as http;

class Activereport extends StatefulWidget {
  static String routeName = "/complain-view";

  @override
  _ActivereportState createState() => _ActivereportState();
}

Future<List<Complain>> fetchCompleteComplains(http.Client client) async {
  var response =
      await client.get(Uri.parse('https://localhost:5001/api/complains'));
  var jsonData = response.body;
  var responseData;
  responseData = json.decode(jsonData);
  List<dynamic> rep = [];
  var val;

  if (response.statusCode == 200) {
    for (int i = 0; i < responseData.length; i++) {
      if (responseData[i]["status"] != "Completed" &&
          responseData[i]["status"] != "Reject") {
        rep.add(responseData[i]);
        val = jsonEncode(rep);
        print(val);
      }
    }
  }
  return compute(parseCompleteComplains, val);
  // Use the compute function to run parsePhotos in a separate isolate.
}

List<Complain> parseCompleteComplains(var responseBody) {
  var parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Complain>((json) => new Complain.fromJson(json)).toList();
}

class _ActivereportState extends State<Activereport> {
  _onDeleteTap(String id) async {
    await http.delete('https://localhost:5001/api/complains/$id');
    setState(() {});
    print('deleted');
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: appBar(
        height: height,
        width: width,
        context: context,
      ),
      backgroundColor: Color(0xFF102733),
      body: ListView(children: [
        Stack(
          children: [
            Container(height: height, width: width / 6, child: Sidebar()),
            FutureBuilder<List<Complain>>(
              future: fetchCompleteComplains(http.Client()),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width / 1.5,
                          child: ComplainsList(
                            complain: snapshot.data,
                            onDeleteTap: _onDeleteTap,
                          ),
                        ),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  ),
                );
              },
            ),
          ],
        ),
      ]),
    );
  }
}
