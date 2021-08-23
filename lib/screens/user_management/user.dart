import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:sswm_web/constraints/color.dart';
import 'package:sswm_web/models/user.dart';
import 'package:sswm_web/screens/user_management/edit_user.dart';
import 'package:sswm_web/widgets/list_user.dart';
import 'package:sswm_web/widgets/sidebar.dart';

class UserView extends StatefulWidget {
  static String routeName = "/user";
  @override
  _UserViewState createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  dynamic responseData;
  bool isTrue = false;
  Future<List<User>> futureUser;

  Future<List<User>> fetchPhotos() async {
    final response = await http.get('https://localhost:5001/api/users');

    // Use the compute function to run parsePhotos in a separate isolate.
    return compute(parsePhotos, response.body);
  }

  List<User> parsePhotos(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<User>((json) => User.fromJson(json)).toList();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: scaffoldColor,
      body: ListView(
        children: [
          Stack(
            children: [
              Container(height: height, width: width / 6, child: Sidebar()),
              FutureBuilder<List<User>>(
                future: fetchPhotos(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            width: 300,
                            height: 70,
                            margin: EdgeInsets.only(top: 100),
                            color: Colors.amber,
                            child: Center(
                                child: Text('User Management',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20))),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Center(
                          child: UserList(
                            user: snapshot.data,
                            onDeleteTap: _onDeleteTap,
                            onEditTap: _onEditTap,
                          ),
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  // By default, show a loading spinner.
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  //_onDeleteTap() => _deleteData();

  _onDeleteTap(String id) async {
    print(id.toString());
    await http.delete('https://localhost:5001/api/users/$id');
    setState(() {});
    print('deleted');
  }

  _onEditTap(String name, String email, String id, String password) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            EditUser(name: name, email: email, id: id, password: password),
      ),
    );
  }
  //   Navigator.pushNamed(
  //     context,
  //     EditUser.routeName,
  //   );
  // }
}

class UserList extends StatelessWidget {
  final List<User> user;
  final Function onEditTap;
  final Function onViewTap;
  final Function onDeleteTap;
  UserList(
      {Key key, this.user, this.onEditTap, this.onViewTap, this.onDeleteTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 1.3,
      width: MediaQuery.of(context).size.width / 2,
      child: ListView.builder(
        itemCount: user.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            child: Card(
              shadowColor: Colors.purple,
              color: Color(0xff29404e),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7)),
              margin: EdgeInsets.only(top: 10),
              child: ListTile(
                title: Text(
                  user[index].email,
                  style: TextStyle(color: Colors.amber, fontSize: 20),
                ),
                // subtitle: Text(
                //   subTitle.toDate().toString(),
                // ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.view_agenda,
                        color: Colors.white,
                      ),
                      onPressed: () => onViewTap(),
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                        onPressed: () => onEditTap(
                            user[index].fullName,
                            user[index].email,
                            user[index].id,
                            user[index].password)),
                    IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () => onDeleteTap(user[index].id),
                    ),
                    Container(
                      width: 0.6,
                      color: Colors.grey.shade300,
                      margin: EdgeInsets.symmetric(horizontal: 12),
                    ),
                  ],
                ),
              ),
              elevation: 4,
            ),
          );
        },
      ),
    );
  }
}
