import 'package:flutter/material.dart';
import '../utilities/color.dart';

import 'firebase_auth/firebase_services.dart';
import 'widget/login_header.dart';
import 'widget/form_container_widget.dart';
import 'widget/social_login.dart';
import 'widget/error.dart';
import 'widget/divider.dart';

// ignore_for_file: prefer_const_constructors

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuthService _auth = FirebaseAuthService();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String error = "";
  bool isError = false;

  @override
  void initState() {
    super.initState();
    isError = false;
    error = "";
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: CustomColors.background,
      body: Padding(
        padding: EdgeInsets.all(14.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              LoginHeader(),
              FormContainerWidget(
                controller: _emailController,
                hintText: "Enter Email Address",
                isPasswordField: false,
              ),
              SizedBox(
                height: 5,
              ),
              FormContainerWidget(
                controller: _passwordController,
                hintText: "Enter Password",
                isPasswordField: true,
              ),
              SizedBox(
                height: 10,
              ),
              Visibility(
                visible: isError,
                child: Error(error: error,),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width / 2 - 20,
                      decoration: BoxDecoration(
                        color: CustomColors.gray,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: _signIn,
                    child: Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width / 2 - 20,
                      decoration: BoxDecoration(
                        color: CustomColors.green,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                          "Log in",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(
                    color: CustomColors.gray,
                    fontSize: 12,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              DividerLine(),
              SizedBox(
                height: 10,
              ),
              SocialLogin(),
            ],
          ),
        ),
      ),
    );
  }

  void _signIn() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty) {
      error = "Email is required";
    } else if (password.isEmpty) {
      error = "Password is required";
    } else {
      await _auth.signInWithEmailAndPassword(email, password);
      error = FirebaseAuthService.errorMessage;
    }

    if (error != "") {
      setState(() {
        isError = true;
      });
    }
      print(error);

  }
}
