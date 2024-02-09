import 'package:flutter/material.dart';

import '../utilities/color.dart';
import 'firebase_auth/firebase_services.dart';
import 'widget/form_container_widget.dart';
import 'widget/login_header.dart';
import 'widget/error.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
  final FirebaseAuthService _auth = FirebaseAuthService();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String error = "";
  bool isError = false;
  
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: CustomColors.background,
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const LoginHeader(),
              FormContainerWidget(
                controller: _emailController,
                hintText: "Enter Email Address",
                isPasswordField: false,
              ),
              const SizedBox(
                height: 20,
              ),
              FormContainerWidget(
                controller: _passwordController,
                hintText: "Enter Password",
                isPasswordField: true,
              ),
              const SizedBox(
                height: 20,
              ),
              Visibility(
                visible: isError,
                child: Error(error: error,),
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
  
}