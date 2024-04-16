import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:webtoon/utils.dart';
import 'package:image_picker/image_picker.dart';
import '../../utilities/fonts.dart';
import '../../firebase/firebase_auth/firebase_services.dart';
import 'widgets/form_container_widget.dart';
import 'widgets/error.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key, required this.title});

  final String title;

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  Uint8List? _image;
  final FirebaseAuthService _auth = FirebaseAuthService();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  String error = "";
  bool isError = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Theme.of(context).primaryColor,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.transparent,
      ),
      resizeToAvoidBottomInset: false,
      // backgroundColor: CustomColors.background,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Text(
                'Sign Up',
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 30,
                    fontWeight: CustomColors.bold,
                    fontFamily: 'Gilroy'),
              ),
            ),
            SizedBox(height: 5,),
            Center(
              child: Stack(
                children: [
                  _image !=null ?
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: MemoryImage(_image!),
                      ) :
                  const CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage("https://upload.wikimedia.org/wikipedia/commons/thumb/5/59/User-avatar.svg/2048px-User-avatar.svg.png"),
                  ),
                  Positioned(
                      child: IconButton(
                        onPressed: selectImage,
                        icon: const Icon(Icons.add_a_photo),
                      ),
                    bottom: -10,
                    left: 40,
                  )

                ],
              ),
            ),
            SizedBox(height: 5,),
            Text(
              'EMAIL ADDRESS *',
              style: TextStyle(
                  color: Theme.of(context).secondaryHeaderColor,
                  fontSize: 12,
                  fontWeight: CustomColors.medium,
                  fontFamily: 'Gilroy'),
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
            Text(
              'PASSWORD *',
              style: TextStyle(
                  color: Theme.of(context).secondaryHeaderColor,
                  fontSize: 12,
                  fontWeight: CustomColors.medium,
                  fontFamily: 'Gilroy'),
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
            Text(
              '6-16 alphanumeric characters with a symbol',
              style: TextStyle(
                  color: Theme.of(context).secondaryHeaderColor,
                  fontSize: 12,
                  fontWeight: CustomColors.regular,
                  fontFamily: 'Gilroy'),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'NICKNAME *',
              style: TextStyle(
                  color: Theme.of(context).secondaryHeaderColor,
                  fontSize: 12,
                  fontWeight: CustomColors.medium,
                  fontFamily: 'Gilroy'),
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
            Text(
              'Max 20 characters',
              style: TextStyle(
                  color: Theme.of(context).secondaryHeaderColor,
                  fontSize: 12,
                  fontWeight: CustomColors.regular,
                  fontFamily: 'Gilroy'),
            ),
            const SizedBox(
              height: 20,
            ),
            // const Text(
            //   'By signing up, I agree to the Terms of Use and Privacy Policy of WEBTOON',
            //   style: TextStyle(color: Theme.of(context).secondaryHeaderColor, fontSize: 12),
            // ),
            // const SizedBox(
            //   height: 20,
            // ),
            // const Text(
            //   'WEBTOON collects and processes your email address for marketing purposes. You can easily unsubscribe at any time via the opt-out link in the marketing emails.',
            //   style: TextStyle(color: Theme.of(context).secondaryHeaderColor, fontSize: 12),
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
              onTap: () => _signUp(context),
              child: Container(
                height: 45,
                width: MediaQuery.of(context).size.width - 20,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(7, 95, 227, 1),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Center(
                  child: Text(
                    "Sign up NOW",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: CustomColors.regular,
                        fontFamily: 'Gilroy'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _signUp(BuildContext context) async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty) {
      error = "Email is required";
    } else if (password.isEmpty) {
      error = "Password is required";
    } else if (_image == null) {
      error = "Image is required";
    } else {
      await _auth.signUpWithEmailAndPassword(email, password, _nicknameController.text.trim(),_image!);
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
