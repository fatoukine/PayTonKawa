import 'package:paytonkawa/constants.dart';
import 'package:paytonkawa/views/homepage.dart';
import 'package:paytonkawa/views/register.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:paytonkawa/views/qrScan.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: const Center(
                        child: Image(
                          image: AssetImage("lib/logo.JPG"),
                          width: 200,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                        'Login to your Account',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: customFormFeild(
                        labelText: 'Email',
                        keyboardType: TextInputType.emailAddress,
                        obscureText: false,
                        controller: email,
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: customFormFeild(
                        controller: password,
                        labelText: 'Password',
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: StatefulBuilder(
                        builder: (BuildContext context, setState) {
                          return loading
                              ? MaterialButton(
                                  onPressed: () async {
                                    if (email.text.isNotEmpty) {
                                      if (password.text.isNotEmpty) {
                                        setState(() {
                                          loading = !loading;
                                        });
                                      } else {
                                        newSnackBar(context,
                                            title:
                                                'Email and Password Required!');
                                      }
                                    } else {
                                      newSnackBar(context,
                                          title: 'Email Required!');
                                    }

                                    try {
                                      await FirebaseAuth.instance
                                          .signInWithEmailAndPassword(
                                              email: email.text,
                                              password: password.text)
                                          .then((value) {
                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const  HomePage(), // QrScan(),const  HomePage(),
                                          ),
                                        );

                                        setState(() {
                                          loading = !loading;
                                        });
                                      });
                                    } on FirebaseAuthException catch (e) {
                                      if (e.code == 'user-not-found') {
                                        newSnackBar(context,
                                            title:
                                                'No user found for that email.');
                                        setState(() {
                                          loading = !loading;
                                        });
                                      } else if (e.code == 'wrong-password') {
                                        newSnackBar(context,
                                            title:
                                                'Wrong password provided for that user.');
                                        setState(() {
                                          loading = !loading;
                                        });
                                      }
                                    }
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  color: blue,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 15, 0, 15),
                                        child: Text(
                                          'Sign In',
                                          style: TextStyle(color: white),
                                        ),
                                      ),
                                    ],
                                  ))
                              : Center(
                                  child: MaterialButton(
                                    onPressed: () {},
                                    shape: const CircleBorder(),
                                    color: blue,
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: CircularProgressIndicator(
                                        color: white,
                                      ),
                                    ),
                                  ),
                                );
                        },
                      ),
                    ),
                  ],
                ),
              ),


                //page de scan
                Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Scaner un qrcode",
                    style: TextStyle(
                      color: black,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => QrScan(),
                        ),
                      );
                    },
                    child: const Text(
                      'Scan',
                      style: TextStyle(
                        color: blue,
                      ),
                    ),
                  ),
                ],
              ),




            //page d' inscription
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Vous n'avez de compte? ",
                    style: TextStyle(
                      color: black,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const UserRegister(),
                        ),
                      );
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        color: blue,
                      ),
                    ),
                  ),
                ],
              ), 



            ],
          ),
        ),
      ),
    );
  }

  customFormFeild({
    controller,
    labelText,
    keyboardType,
    textInputAction,
    obscureText,
  }) {
    return Material(
      elevation: 2,
      shadowColor: black,
      color: white,
      borderRadius: BorderRadius.circular(5.0),
      child: TextFormField(
        autofocus: false,
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        controller: controller,
        cursorColor: black,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(color: black),
          contentPadding: const EdgeInsets.all(8),
          border: InputBorder.none,
        ),
      ),
    );
  }
}