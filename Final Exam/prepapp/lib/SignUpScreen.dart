import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'ColorUtils.dart';
import 'ReusableWidgets.dart';
import 'SignInScreen.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _userNameTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Sign Up",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              
             hexStringToColor("337AB7"), // New color
              hexStringToColor("5BC0DE"), // New color
              hexStringToColor("5CB85C"),// New color
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 20),
                reusableTextField(
                  "Enter UserName",
                  Icons.person_outline,
                  false,
                  _userNameTextController,
                ),
                const SizedBox(height: 20),
                reusableTextField(
                  "Enter Email Id",
                  Icons.person_outline,
                  false,
                  _emailTextController,
                ),
                const SizedBox(height: 20),
                reusableTextField(
                  "Enter Password",
                  Icons.person_outline,
                  false,
                  _passwordTextController,
                ),
                const SizedBox(height: 20),
                SignInSignUpButton(
                  context,
                  false,
                  () {
                    FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                      email: _emailTextController.text,
                      password: _passwordTextController.text,
                    )
                        .then((value) {
                      print("Created New Account");
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignInScreen()),
                      );
                    }).onError((error, stackTrace) {
                      print("Error ${error.toString()}");
                    });
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
