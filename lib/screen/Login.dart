import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../helper/FirebaseAuthHelper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String? email;
  String? password;

  bool isPasswordShow = true;

  int currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xffcad2c5),
      body: IndexedStack(
        index: currentIndex,
        children: [
          //signUp
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.15,
                ),
                Text(
                  'Create your Account',
                  style: GoogleFonts.yaldevi(
                      fontSize: 38,
                      letterSpacing: 2,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: height * 0.07,
                ),
                TextField(
                  style:
                      GoogleFonts.balooBhai2(color: Colors.white, fontSize: 17),
                  controller: emailController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.black38,
                    hintText: 'Email',
                    hintStyle: GoogleFonts.balooBhai2(
                        color: Colors.white54, fontSize: 17),
                    prefixIcon: const Icon(
                      CupertinoIcons.mail,
                      color: Colors.white,
                    ),
                    contentPadding: const EdgeInsets.only(left: 14.0, top: 8),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black26),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black26),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  style:
                      GoogleFonts.balooBhai2(color: Colors.white, fontSize: 17),
                  controller: passwordController,
                  obscureText: isPasswordShow,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.black38,
                    hintText: 'Password',
                    hintStyle: GoogleFonts.balooBhai2(
                        color: Colors.white54, fontSize: 17),
                    prefixIcon: const Icon(
                      CupertinoIcons.lock_fill,
                      color: Colors.white,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isPasswordShow = !isPasswordShow;
                        });
                      },
                      icon: Icon(
                        (isPasswordShow)
                            ? CupertinoIcons.eye_fill
                            : CupertinoIcons.eye_slash_fill,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                    contentPadding: const EdgeInsets.only(left: 14.0, top: 8),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black26),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black26),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                GestureDetector(
                  onTap: () async {
                    email = emailController.text;
                    password = passwordController.text;

                    User? user = await FirebaseAuthHelper.firebaseAuthHelper
                        .signUpUser(email: email!, password: password!);

                    if (user != null) {
                      setState(() {
                        currentIndex=1;
                        emailController.clear();
                        passwordController.clear();
                      });

                      emailController.clear();
                      passwordController.clear();
                      email = null;
                      password = null;

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Signup Successfully...'),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.green,
                        ),
                      );
                    } else {
                      emailController.clear();
                      passwordController.clear();
                      email = null;
                      password = null;

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('signup failed...'),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  child: Container(
                    height: 50,
                    width: width * 0.7,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: const Color(0xff7210ff),
                        borderRadius: BorderRadius.circular(35)),
                    child: Text(
                      'Sign Up',
                      style: GoogleFonts.balooBhai2(
                          fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 2,
                      width: width * 0.3,
                      color: Colors.black54,
                    ),
                    Text(
                      'or Continue with',
                      style: GoogleFonts.balooBhai2(
                          fontSize: 15, color: Colors.black),
                    ),
                    Container(
                      height: 2,
                      width: width * 0.3,
                      color: Colors.black54,
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                GestureDetector(
                  onTap: () async {
                    User? user = await FirebaseAuthHelper.firebaseAuthHelper
                        .signInWithGoogle();

                    if (user != null) {
                      Navigator.of(context).pushReplacementNamed('homepage');

                      emailController.clear();
                      passwordController.clear();
                      email = null;
                      password = null;

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Signup Successfully...'),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.green,
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('signup failed...'),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  child: Container(
                    height: 50,
                    width: width * 0.8,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: const Color(0xff6f3abb),
                        borderRadius: BorderRadius.circular(35)),
                    child: Text(
                      'Google',
                      style: GoogleFonts.balooBhai2(
                          fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 100),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already Have an Account?',
                      style: GoogleFonts.balooBhai2(
                          fontSize: 15, color: Colors.black87),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          currentIndex = 1;
                          emailController.clear();
                          passwordController.clear();
                        });
                      },
                      child: Text(
                        'Sign In',
                        style: GoogleFonts.balooBhai2(
                            fontSize: 16, color: Colors.blue),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),

          //signIn
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.15,
                ),
                Text(
                  'Login to your Account',
                  style: GoogleFonts.yaldevi(
                      fontSize: 36,
                      letterSpacing: 2,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: height * 0.07,
                ),
                TextField(
                  style:
                      GoogleFonts.balooBhai2(color: Colors.white, fontSize: 17),
                  controller: emailController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.black38,
                    hintText: 'Email',
                    hintStyle: GoogleFonts.balooBhai2(
                        color: Colors.white54, fontSize: 17),
                    prefixIcon: const Icon(
                      CupertinoIcons.mail,
                      color: Colors.white,
                    ),
                    contentPadding: const EdgeInsets.only(left: 14.0, top: 8),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black26),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black26),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  style:
                      GoogleFonts.balooBhai2(color: Colors.white, fontSize: 17),
                  controller: passwordController,
                  obscureText: isPasswordShow,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.black38,
                    hintText: 'Password',
                    hintStyle: GoogleFonts.balooBhai2(
                        color: Colors.white54, fontSize: 17),
                    prefixIcon: const Icon(
                      CupertinoIcons.lock_fill,
                      color: Colors.white,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isPasswordShow = !isPasswordShow;
                        });
                      },
                      icon: Icon(
                        (isPasswordShow)
                            ? CupertinoIcons.eye_fill
                            : CupertinoIcons.eye_slash_fill,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                    contentPadding: const EdgeInsets.only(left: 14.0, top: 8),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black26),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black26),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                GestureDetector(
                  onTap: () async {
                    email = emailController.text;
                    password = passwordController.text;

                    User? user = await FirebaseAuthHelper.firebaseAuthHelper
                        .signInUser(email: email!, password: password!);

                    if (user != null) {

                        Navigator.of(context)
                            .pushReplacementNamed('homepage');

                      emailController.clear();
                      passwordController.clear();
                      email = null;
                      password = null;

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('SignIn Successfully...'),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.green,
                        ),
                      );
                    } else {
                      emailController.clear();
                      passwordController.clear();
                      email = null;
                      password = null;

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Sign In failed...'),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  child: Container(
                    height: 50,
                    width: width * 0.7,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: const Color(0xff7210ff),
                        borderRadius: BorderRadius.circular(35)),
                    child: Text(
                      'Sign In',
                      style: GoogleFonts.balooBhai2(
                          fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 2,
                      width: width * 0.3,
                      color: Colors.black54,
                    ),
                    Text(
                      'or Continue with',
                      style: GoogleFonts.balooBhai2(
                          fontSize: 15, color: Colors.black),
                    ),
                    Container(
                      height: 2,
                      width: width * 0.3,
                      color: Colors.black54,
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                GestureDetector(
                  onTap: () async {
                    User? user = await FirebaseAuthHelper.firebaseAuthHelper
                        .signInWithGoogle();

                    if (user != null) {
                      Navigator.of(context).pushReplacementNamed('/');

                      emailController.clear();
                      passwordController.clear();
                      email = null;
                      password = null;

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Signup Successfully...'),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.green,
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('signup failed...'),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  child: Container(
                    height: 50,
                    width: width * 0.8,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: const Color(0xff6f3abb),
                        borderRadius: BorderRadius.circular(35)),
                    child: Text(
                      'Google',
                      style: GoogleFonts.balooBhai2(
                          fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 100),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an Account?",
                      style: GoogleFonts.balooBhai2(
                          fontSize: 15, color: Colors.black87),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          currentIndex = 0;
                          emailController.clear();
                          passwordController.clear();
                        });
                      },
                      child: Text(
                        'Sign Up',
                        style: GoogleFonts.balooBhai2(
                            fontSize: 16, color: Colors.blue),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
