import 'package:fdag/commons/colors/el_color.dart';
import 'package:fdag/commons/colors/sizes.dart';
import 'package:fdag/pages/el/search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TopNavigation extends StatelessWidget {
  const TopNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () => FirebaseAuth.instance.signOut(),
          child: Container(
            width: Sizes.f5,
            height: Sizes.f5,
            decoration: BoxDecoration(),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.asset(
                "assets/images/logo.jpg",
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        Container(
          width: 200,
          height: Sizes.f5,
          padding: EdgeInsets.all(Sizes.f01),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Sizes.f2),
            color: ElColor.darkBlue200,
          ),
          child: TextField(
            onTap: () {
              // Navigator.pushNamed(context, '/search');
              showSearch(context: context, delegate: Search());
            },
            readOnly: true,
            decoration: InputDecoration(
              icon: Icon(Icons.search),
              hintText: "Search ...",
              border: InputBorder.none,
              hintStyle: TextStyle(color: ElColor.darkBlue),
            ),
          ),
        ),
        Icon(
          Icons.notifications,
          color: ElColor.darkBlue,
          size: Sizes.f3,
        ),
        Icon(
          Icons.more_vert,
          color: ElColor.darkBlue,
          size: Sizes.f3,
        ),
      ],
    );
  }
}
