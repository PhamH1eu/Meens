import 'package:flutter/material.dart';
import '../utilities/fonts.dart';

import 'firebase_auth/firebase_services.dart';
import 'widgets/login_header.dart';
import 'widgets/form_container_widget.dart';
import 'widgets/social_login.dart';
import 'widgets/error.dart';
import 'widgets/divider.dart';

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
      // backgroundColor: CustomColors.background,
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
                child: Error(
                  error: error,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed('/signup', arguments: "Sign Up");
                    },
                    child: Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width / 2 - 20,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Theme.of(context).primaryColor,
                          width: 1,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                              color: Color.fromRGBO(7, 95, 227, 1),
                              fontSize: 20,
                              fontWeight: CustomColors.regular,
                              fontFamily: 'Gilroy'),
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
                        color: Color.fromRGBO(7, 95, 227, 1),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                          "Log in",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: CustomColors.regular,
                            fontFamily: 'Gilroy',
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
                      color: Theme.of(context).secondaryHeaderColor,
                      fontSize: 12,
                      fontWeight: CustomColors.regular,
                      fontFamily: 'Gilroy'),
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
  }
}
