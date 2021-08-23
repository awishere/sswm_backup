import 'package:flutter/material.dart';

class DropDown extends StatefulWidget {
  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  final List<String> action = ["Accept", "Reject", "Completed"];
  String selectedAction = "Accept";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(32.0),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Select an action against this complaint'),
            DropdownButton<String>(
              value: selectedAction,
              onChanged: (value) {
                setState(() {
                  selectedAction = value;
                });
              },
              items: action.map<DropdownMenuItem<String>>((value) {
                return DropdownMenuItem(
                  child: Text(value),
                  value: value,
                );
              }).toList(),
            ),
            Text(
              selectedAction,
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.w900),
            )
          ],
        ),
      ),
    );
  }
}
