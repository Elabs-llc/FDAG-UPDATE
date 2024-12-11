import 'package:fdag/elabs/auth/app_core.dart';
import 'package:fdag/utils/logging/logger.dart';
import 'package:fdag/utils/validators/validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// Authenticates a user with Firebase using their email and password.
///
/// This method attempts to sign in a user with the provided [email] and [password].
/// If the email or password fields are empty, an alert dialog prompts the user to
/// fill in the required fields. On successful login, a success message is logged;
/// otherwise, an error dialog and log message indicate a login failure with a
/// generic error for incorrect credentials, enhancing security.
///
/// The method uses [BuildContext] to display dialogs directly within the
/// widget tree.
///
/// Args:
///   - [email] (String): The email address for user login.
///   - [password] (String): The password for user login.
///   - [context] (BuildContext): The build context required for displaying dialogs.
///
/// Example:
/// ```
/// signInWithEmail("user@example.com", "password123", context);
/// ```
///
/// Note:
/// Ensure Firebase is initialized before calling this method.
///
/// Throws:
///   FirebaseAuthException if login fails due to invalid credentials or network issues.

class AppLogin {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> signInWithEmail(
      String email, String password, BuildContext context) async {
    if (!Validator.isEmailEmpty(email) &&
        !Validator.isPasswordEmpty(password)) {
      try {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((user) {
          // Check user email verification
          final newUser = user.user;
          if (newUser != null && newUser.emailVerified) {
            if (context.mounted) {
              showDialog(
                  context: context,
                  builder: (ctx) {
                    return AlertDialog(
                      title: Text('Email Not Verified'),
                      content: Text(
                          'Please verify your email before logging in. A verification email has been resent to $email.'),
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
            Logger.logLevel = 'ERROR';
            Logger.info('Error: Email not verified');
            return;
          } else {
            // To resolve the warning about using BuildContext across async gaps,
            //  a check for mounted was added before using context within
            // asynchronous callbacks. This ensures that context is only used
            // if the widget is still in the widget tree, preventing potential
            //  memory leaks or errors.
            if (context.mounted) {
              // Update user document
              AppCore().updateUserLastSeen(user.user!.uid);
              showDialog(
                  context: context,
                  builder: (ctx) {
                    return AlertDialog(
                      title: Text('Success'),
                      content: Text('Logged in successfully!'),
                      actions: [
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("OK")),
                      ],
                    );
                  });

              // Set the log level and log message
              Logger.logLevel = 'INFO';
              Logger.info("Logged in successfully!");
            }
          }
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
                    content:
                        Text('Incorrect email or password. Please try again.'),
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Try again")),
                    ],
                  );
                });
            Logger.logLevel = 'ERROR';
            Logger.info('Error: ${e.message}');
          }
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

  Future<User?> signInWithGoogle(BuildContext context) async {
    try {
      // Trigger the Google Sign-In flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null; // The user canceled the sign-in

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google user credential
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      final User? user = userCredential.user;

      Logger.logLevel = 'INFO';

      if (user != null) {
        // Retrieve user details
        String? displayName = user.displayName;
        String? email = user.email;
        String? photoUrl = user.photoURL;
        String? uid = user.uid;
        String? provider = user.providerData[0].providerId;

        // Check if it's a new user
        if (userCredential.additionalUserInfo?.isNewUser == true) {
          // Create a new user document
          AppCore()
              .createUserDocument(uid, displayName, email, photoUrl, provider);
          showMessageDialog(context, "Signup successful", 'Success');

          // Send email verification
          final newUser = userCredential.user;
          if (newUser != null && !newUser.emailVerified) {
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
          Logger.info('New user signed up: $displayName, $email');
        } else {
          final newUser = userCredential.user;
          if (newUser != null && newUser.emailVerified) {
            // Update user document
            AppCore().updateUserLastSeen(uid);
            showMessageDialog(
                context, "Welcome back {$displayName.}", 'Success');
            Logger.info('Existing user signed in: $displayName, $email');
          } else {
            if (context.mounted) {
              showDialog(
                  context: context,
                  builder: (ctx) {
                    return AlertDialog(
                      title: Text('Email Not Verified'),
                      content: Text(
                          'Please verify your email before logging in. A verification email has been resent to $email.'),
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
            Logger.logLevel = 'ERROR';
            Logger.info('Error: Email not verified');
          }
        }

        // return user;
      }

      return userCredential.user;
    } catch (e) {
      // To resolve the warning about using BuildContext across async gaps,
      //  a check for mounted was added before using context within
      if (context.mounted) {
        showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: Text('Error'),
                content: Text('Error signing in with Google: $e'),
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Cancel")),
                ],
              );
            });
      }
      Logger.logLevel = 'ERROR';
      Logger.info('Error signing in with Google: $e');

      return null;
    }
  }

  void showMessageDialog(BuildContext context, String message, String title) {
    if (context.mounted) {
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: Text(title),
              content: Text(message),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/home');
                    },
                    child: Text("OK")),
              ],
            );
          });
    }
  }
}
