import 'package:flutter/material.dart';

import '../utilities/color.dart';
import 'firebase_auth/firebase_services.dart';
import 'widget/form_container_widget.dart';
import 'widget/error.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key, required this.title});

  final String title;

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final FirebaseAuthService _auth = FirebaseAuthService();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();

  String error = "";
  bool isError = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: CustomColors.mainText,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.transparent,
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: CustomColors.background,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Center(
              child: Text(
                'Sign Up',
                style: TextStyle(
                  color: CustomColors.mainText,
                  fontSize: 30,
                  fontWeight: CustomColors.bold,
                ),
              ),
            ),
            const Text(
              'EMAIL ADDRESS *',
              style: TextStyle(color: CustomColors.gray, fontSize: 12, fontWeight: CustomColors.medium),
            ),
            const SizedBox(
              height: 10,
            ),
            FormContainerWidget(
              controller: _emailController,
              hintText: "Enter Email Address",
              isPasswordField: false,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'PASSWORD *',
              style: TextStyle(color: CustomColors.gray, fontSize: 12, fontWeight: CustomColors.medium),
            ),
            const SizedBox(
              height: 10,
            ),
            FormContainerWidget(
              controller: _passwordController,
              hintText: "Enter Password",
              isPasswordField: true,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              '6-16 alphanumeric characters with a symbol',
              style: TextStyle(color: CustomColors.gray, fontSize: 12, fontWeight: CustomColors.regular),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'NICKNAME *',
              style: TextStyle(color: CustomColors.gray, fontSize: 12, fontWeight: CustomColors.medium),
            ),
            const SizedBox(
              height: 10,
            ),
            FormContainerWidget(
              controller: _nicknameController,
              hintText: "Enter nickname",
              isPasswordField: false,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Max 20 characters',
              style: TextStyle(color: CustomColors.gray, fontSize: 12, fontWeight: CustomColors.regular),
            ),
            const SizedBox(
              height: 20,
            ),
            // const Text(
            //   'By signing up, I agree to the Terms of Use and Privacy Policy of WEBTOON',
            //   style: TextStyle(color: CustomColors.gray, fontSize: 12),
            // ),
            // const SizedBox(
            //   height: 20,
            // ),
            // const Text(
            //   'WEBTOON collects and processes your email address for marketing purposes. You can easily unsubscribe at any time via the opt-out link in the marketing emails.',
            //   style: TextStyle(color: CustomColors.gray, fontSize: 12),
            // ),
            Visibility(
              visible: isError,
              child: Error(
                error: error,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: _signUp,
              child: Container(
                height: 45,
                width: MediaQuery.of(context).size.width - 20,
                decoration: BoxDecoration(
                  color: CustomColors.green,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Center(
                  child: Text(
                    "Sign up NOW",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: CustomColors.regular,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _signUp() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty) {
      error = "Email is required";
    } else if (password.isEmpty) {
      error = "Password is required";
    } else {
      await _auth.signUpWithEmailAndPassword(email, password);
      error = FirebaseAuthService.errorMessage;
    }

    if (error != "") {
      setState(() {
        isError = true;
      });
    } else {
      if (context.mounted) Navigator.of(context).pushNamed('/app');
    }
  }
}
