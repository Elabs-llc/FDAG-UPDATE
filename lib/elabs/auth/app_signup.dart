import 'package:fdag/elabs/auth/app_core.dart';
import 'package:fdag/utils/logging/logger.dart';
import 'package:fdag/utils/validators/validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppSignup {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signUpWithEmail(
      String name, String email, String password, BuildContext context) async {
    if (!Validator.isEmailEmpty(email) &&
        !Validator.isPasswordEmpty(password) &&
        !Validator.isPasswordEmpty(name)) {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((user) async {
          // Send email verification
          final newUser = user.user;
          if (newUser != null && newUser.emailVerified) {
            await newUser.sendEmailVerification();
            Logger.info("Verification email sent to $email");

            // To resolve the warning about using BuildContext across async gaps,
            //  a check for mounted was added before using context within
            // asynchronous callbacks. This ensures that context is only used
            // if the widget is still in the widget tree, preventing potential
            //  memory leaks or errors.
            if (context.mounted) {
              showDialog(
                  context: context,
                  builder: (ctx) {
                    return AlertDialog(
                      title: Text('Signup Successful'),
                      content: Text(
                          'A verification email has been sent to $email. Please verify your email before logging in.'),
                      actions: [
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("OK")),
                      ],
                    );
                  });
            }
          }
          // Create user document
          AppCore()
              .createUserDocument(user.user!.uid, name, email, '', 'email');
          // Set the log level and log message
          Logger.logLevel = 'INFO';
          Logger.info("User document created successfully");
        }).catchError((e) {
          // To resolve the warning about using BuildContext across async gaps,
          //  a check for mounted was added before using context within
          // asynchronous callbacks. This ensures that context is only used
          // if the widget is still in the widget tree, preventing potential
          //  memory leaks or errors. | //Text('${e.message}'),
          if (context.mounted) {
            showDialog(
                context: context,
                builder: (ctx) {
                  return AlertDialog(
                    title: Text('Error'),
                    content: Text('${e.message}'),
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Try again")),
                    ],
                  );
                });
          }
          Logger.logLevel = 'ERROR';
          Logger.info('Error: ${e.message}');
        });
      } on FirebaseAuthException catch (e) {
        Logger.logLevel = 'ERROR';
        Logger.info('Error: ${e.message}');
      }
    } else {
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Please fill in all required fields'),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel")),
              ],
            );
          });
      Logger.logLevel = 'ERROR';
      Logger.info('Error: All fileds required!');
    }
  }
}
