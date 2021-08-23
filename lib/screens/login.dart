import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sswm_web/models/user.dart';
import 'package:sswm_web/screens/dashboard.dart';

class Login extends StatefulWidget {
  static String routeName = "/login";
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  dynamic responseData;
  bool isTrue = false;
  @override
  Widget build(BuildContext context) {
    Future<User> _futureUser;
    String name;
    TextEditingController fullNameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    Future<void> _login() async {
      bool x = true;
      print('Login Tap');
      final response = await http.get(
        'https://localhost:5001/api/users',
      );
      print('Not access');
      var jsonData = response.body;
      responseData = json.decode(jsonData);
      // Map<String, dynamic> data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        for (int i = 0; i < responseData.length; i++) {
          if (responseData[i]["email"] == emailController.text &&
              responseData[i]["password"] == passwordController.text &&
              responseData[i]["role"] == 'admin') {
            print(responseData[i]["fullName"]);
            final prefs = await SharedPreferences.getInstance();
            String id;
            setState(() {
              name = responseData[i]["fullName"];
              id = responseData[i]["id"].toString();
              if (name.isNotEmpty) isTrue = true;
              String users = responseData[i]["fullName"];
              name = users;
              prefs.setString("fullName", users);
              prefs.setString('id', id);
              // prefs.setString("fullName", users);
              getCnamePreference();
            });

            Fluttertoast.showToast(
                msg: "Welcome $name",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM_RIGHT,
                timeInSecForIosWeb: 2,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
            setState(() {
              x = true;
            });
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DashboardPage()),
            );
          } else {
            setState(() {
              x = false;
            });
          }
        }
        if (x == false) {
          Fluttertoast.showToast(
              msg: "Incorrect Email Or Password",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM_RIGHT,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      } else if (name.isEmpty) {
        setState(() {
          isTrue = false;
        });
      }
    }

    return Scaffold(
        body: SingleChildScrollView(
      child: (_futureUser == null)
          ? Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Color(0xFF102733)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 80,
                  ),
                  Image.asset('assets/images/LOGO.png'),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Solid Waste Management Web App',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 500,
                    width: 325,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Welcome',
                          style: TextStyle(
                              fontSize: 35, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Please Login To Your Account',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: 250,
                          child: TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              suffixIcon: Icon(
                                FontAwesomeIcons.user,
                                size: 17,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 250,
                          child: TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              suffixIcon: Icon(
                                FontAwesomeIcons.eyeSlash,
                                size: 17,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 20, 40, 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Forgot Password?',
                                style:
                                    TextStyle(color: Colors.amberAccent[700]),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () async {
                            print('function');
                            _login();
                            // Navigator.pushNamed(
                            //   context,
                            //   DashboardPage.routeName,
                            // );
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: 250,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.amber),
                            child: Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Text(
                                'Login',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Or Login Using Social Media',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              FontAwesomeIcons.facebookF,
                              color: Colors.amberAccent[700],
                            ),
                            Icon(
                              FontAwesomeIcons.googlePlusG,
                              color: Colors.amberAccent[700],
                            ),
                            Icon(
                              FontAwesomeIcons.twitter,
                              color: Colors.amberAccent[700],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Solid Waste Management '),
                            Icon(
                              FontAwesomeIcons.copyright,
                              size: 15,
                            ),
                            Text(' 2021.')
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          : FutureBuilder<User>(
              future: _futureUser,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data.fullName);
                } else if (snapshot.hasError) {
                  print("anas");
                  return Text("${snapshot.error}");
                }

                return CircularProgressIndicator();
              },
            ),
    ));
  }

  Future<User> signInMethod(String fullName, String password) async {
    final response = await http.post(
      'https://localhost:5001/api/users',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
      body: jsonEncode(<String, String>{
        "fullName": fullName,
        "password": password,
      }),
    );
    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return User.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to load Users');
    }
  }
}

Future<String> getCnamePreference() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String cname = prefs.getString("fullName");
  return cname;
}

Future<String> getIdPreference() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String id = prefs.getString("id");
  return id;
}
