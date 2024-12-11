import 'package:fdag/commons/colors/el_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget line_divider() {
  return Row(
    children: [
      Expanded(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Divider(
            color: ElColor.darkBlue500,
            thickness: 1,
          ),
        ),
      ),
      Text(
        "OR WITH",
        style: TextStyle(fontSize: 15, color: ElColor.darkBlue),
      ),
      SizedBox(width: 12),
      SvgPicture.asset(
        'assets/icons/gmail.svg',
        width: 24,
        height: 24,
      ),
      Expanded(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Divider(
            color: ElColor.darkBlue500,
            thickness: 1,
          ),
        ),
      ),
    ],
  );
}
