import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:sswm_web/constraints/color.dart';
import 'package:sswm_web/widgets/sidebar.dart';

class EditUser extends StatefulWidget {
  String name;
  String email;
  String id;
  String password;
  EditUser({this.name, this.email, this.id, this.password});
  static String routeName = "/edit-user";
  @override
  _EditUserState createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  bool isLoading = true;
  String role;
  String cname;
  TextEditingController userName = new TextEditingController();
  TextEditingController userEmail = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    userName.text = widget.name;
    userEmail.text = widget.email;

    _onUpdateTap() async {
      final msg = jsonEncode({
        "id": int.parse("${widget.id}"),
        "fullName": userName.text,
        "email": userEmail.text,
        "password": widget.password,
        "role": role,
      });

      final response = await http.patch(
          Uri.parse('https://localhost:5001/api/users/${widget.id}'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: msg);
      //setState(() {});
      if (response.statusCode == 204) {
        print("Response " + response.body);
        print('Updated');
        Navigator.pop(context);
      } else {
        print(response.body);
        print('error');
      }
    }

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    final _formKey = GlobalKey<FormState>();
    return isLoading == true
        ? Scaffold(
            backgroundColor: scaffoldColor,
            // appBar: appBar(
            //     height: height, width: width, context: context, title: cname),
            body: ListView(
              children: [
                Stack(
                  children: [
                    Container(
                        height: height, width: width / 6, child: Sidebar()),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: 300,
                        height: 70,
                        margin: EdgeInsets.only(top: 100),
                        color: Colors.amber,
                        child: Center(
                            child: Text('Edit User',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20))),
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height / 3.5,
                      left: MediaQuery.of(context).size.width / 3,
                      child: Container(
                        height: MediaQuery.of(context).size.height / 2,
                        width: MediaQuery.of(context).size.width / 2.8,
                        child: Card(
                            color: Color(0xff29404e),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Form(
                                key: _formKey,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 10),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        TextFormField(
                                          controller: userName,
                                          validator: (value) => value.isEmpty
                                              ? 'Name can\'t be empty'
                                              : null,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Color(0xffc7c7c7)),
                                          decoration: InputDecoration(
                                            hintText: 'Name',
                                            hintStyle: TextStyle(
                                                color: Color(0xffc7c7c7)),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 10.0,
                                                    horizontal: 20.0),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(32.0)),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey,
                                                  width: 1.0),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(32.0)),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.lightBlueAccent,
                                                  width: 2.0),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(32.0)),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        TextFormField(
                                          validator: (value) => value.isEmpty
                                              ? 'Email can\'t be empty'
                                              : null,
                                          controller: userEmail,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Color(0xffc7c7c7)),
                                          decoration: InputDecoration(
                                            hintText: 'Email',
                                            hintStyle: TextStyle(
                                                color: Color(0xffc7c7c7)),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 10.0,
                                                    horizontal: 20.0),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(32.0)),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey,
                                                  width: 1.0),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(32.0)),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.lightBlueAccent,
                                                  width: 2.0),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(32.0)),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Center(
                                          child: DropdownButton<String>(
                                            value: role,
                                            onChanged: (String newValue) {
                                              role = newValue;
                                            },
                                            dropdownColor: Colors.grey,
                                            items: <String>[
                                              'admin',
                                              'user',
                                            ].map<DropdownMenuItem<String>>(
                                                (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                onTap: () {
                                                  setState(() {
                                                    role = value;
                                                  });
                                                },
                                                child: Text(
                                                  value,
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                        Material(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          color: Colors.white,
                                          child: IconButton(
                                            onPressed: () async {
                                              try {
                                                _onUpdateTap();
                                              } catch (e) {
                                                print(e);
                                              }
                                            },
                                            icon: Icon(
                                              Icons.arrow_forward,
                                            ),
                                            color: Colors.blue,
                                          ),
                                        )
                                      ]),
                                ))),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        : Center(child: CircularProgressIndicator());
  }
}
