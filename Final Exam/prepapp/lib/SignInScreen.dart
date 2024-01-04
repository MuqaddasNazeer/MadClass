import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'ColorUtils.dart';
import 'ReusableWidgets.dart';
import 'SignUpScreen.dart';
import 'home.dart';
class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key});
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          hexStringToColor("337AB7"), // New color
              hexStringToColor("5BC0DE"), // New color
              hexStringToColor("5CB85C"),// New color/ Gold
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.fromLTRB(
              20, MediaQuery.of(context).size.height * 0.2, 20, 0),
          child: Column(children: <Widget>[
            logoWidget("image/img1.png"),
            SizedBox(
              height: 30,
            ),
            reusableTextField("Enter UserName", Icons.person_outline, false,
                emailTextController),
            SizedBox(
              height: 20,
            ),
            reusableTextField("Enter Password", Icons.lock_outline, true,
                passwordTextController),
            SizedBox(
              height: 20,
            ),
            SignInSignUpButton(context, true, () 
            {
              FirebaseAuth.instance.signInWithEmailAndPassword(email: emailTextController.text  , password: passwordTextController.text).then((value)
              {
               Navigator.push(context,
               MaterialPageRoute(builder: (context)=>HomeScreen()));
              }).onError((error, stackTrace) 
              {
                print("Error ${error.toString()}");
              });
            }),
            SignUpOption(),
          ]),
        )),
      ),
    );
  }

  Row SignUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have account?",
          style: TextStyle(color: Colors.white70),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => SignUpPage()));
          },
          child: const Text(
            " Sign Up",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
