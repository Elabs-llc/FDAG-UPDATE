import 'package:fdag/commons/colors/el_color.dart';
import 'package:fdag/elabs/auth/app_login.dart';
import 'package:flutter/material.dart';

class BtnLogin extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final String label;
  final String action;

  const BtnLogin({
    super.key,
    required this.emailController,
    required this.passwordController,
    this.label = "LOGIN",
    this.action = "login",
  });

  @override
  _BtnLoginState createState() => _BtnLoginState();
}

class _BtnLoginState extends State<BtnLogin> {
  bool _isLoading = false;

  void _handleLogin() async {
    setState(() {
      _isLoading = true;
    });

    if (widget.action == "login") {
      AppLogin appLogin = AppLogin();

      await appLogin.signInWithEmail(
        widget.emailController.text.trim(),
        widget.passwordController.text.trim(),
        context,
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blueAccent,
              Colors.purpleAccent,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: GestureDetector(
          onTap: _isLoading ? null : _handleLogin,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Center(
              child: _isLoading
                  ? CircularProgressIndicator(color: ElColor.white)
                  : Text(
                      widget.label,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: ElColor.white,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
