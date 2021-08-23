import 'package:flutter/material.dart';
import 'package:sswm_web/constraints/color.dart';

class MenuItem extends StatefulWidget {
  const MenuItem(
      {Key key, this.isActive, @required this.icon, @required this.label})
      : super(key: key);
  final String label;
  final IconData icon;
  final bool isActive;

  @override
  _MenuItemState createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: widget.isActive == true
              ? Colors.blue.withOpacity(0.1)
              : scaffoldColor,
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, top: 5, bottom: 5),
          child: Row(
            children: [
              Icon(
                widget.icon,
                color: widget.isActive ? Color(0xFF138EFF) : Colors.grey[400],
              ),
              SizedBox(width: 10),
              Text(
                widget.label,
                style: TextStyle(
                  color: widget.isActive ? Color(0xFF138EFF) : Colors.grey[400],
                  fontWeight:
                      widget.isActive ? FontWeight.w600 : FontWeight.w300,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
