import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sswm_web/models/complain.dart';
import 'package:sswm_web/widgets/appbar.dart';
import 'package:sswm_web/widgets/complain_view_widget.dart';
import 'package:sswm_web/widgets/drawer.dart';
import 'package:sswm_web/widgets/sidebar.dart';
import 'package:http/http.dart' as http;

class ComplainsView extends StatefulWidget {
  static String routeName = "/complain-view";
  @override
  _ComplainsViewState createState() => _ComplainsViewState();
}

Future<List<Complain>> fetchComplains(
  http.Client client,
) async {
  var response =
      await client.get(Uri.parse('https://localhost:5001/api/complains'));
  //print(response.body);
  return compute(parseComplains, response.body);
  // Use the compute function to run parsePhotos in a separate isolate.
}

List<Complain> parseComplains(String responseBody) {
  var parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Complain>((json) => new Complain.fromJson(json)).toList();
}

class _ComplainsViewState extends State<ComplainsView> {
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
              future: fetchComplains(http.Client()),
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
