import 'package:fdag/elabs/auth/app_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget googleSignupBtn(BuildContext context) {
  return SizedBox(
    width: double.infinity,
    child: OutlinedButton(
      onPressed: () {
        AppLogin appLogin = AppLogin();

        appLogin.signInWithGoogle(context);
      },
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 15),
        side: BorderSide(color: Colors.grey[500]!),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 24,
            width: 24,
            child: SvgPicture.asset(
              'assets/icons/google-icon.svg',
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(width: 12),
          Text(
            'Signup with Google',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    ),
  );
}
