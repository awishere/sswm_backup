import 'package:flutter/material.dart';
import 'package:sswm_web/constraints/color.dart';
import 'package:sswm_web/models/user.dart';

class ListUser extends StatelessWidget {
  final List<User> user;
  final DateTime subTitle;
  final String title;
  final Function onEditTap;
  final Function onViewTap;
  final Function onDeleteTap;

  const ListUser({
    Key key,
    @required this.user,
    @required this.title,
    this.subTitle,
    this.onViewTap,
    @required this.onEditTap,
    @required this.onDeleteTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: Card(
        shadowColor: Colors.purple,
        color: bgColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        margin: EdgeInsets.only(top: 10),
        child: ListTile(
          title: Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 20),
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
                onPressed: () => onEditTap(),
              ),
              IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: () => onDeleteTap(),
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
  }
}
