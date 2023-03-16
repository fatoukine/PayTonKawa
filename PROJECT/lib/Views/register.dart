import 'package:paytonkawa/constants.dart';
import 'package:paytonkawa/views/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRegister extends StatelessWidget {
  const UserRegister({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
    TextEditingController name = TextEditingController();
    TextEditingController password = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: blue,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(25),
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
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
                    'Create your Account',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: customFormFeild(
                    labelText: 'Name',
                    keyboardType: TextInputType.text,
                    obscureText: false,
                    controller: name,
                    textInputAction: TextInputAction.next,
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
                    textInputAction: TextInputAction.done,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: StatefulBuilder(
                    builder: (BuildContext context, setState) {
                      return loading
                          ? MaterialButton(
                              onPressed: () async {
                                if (name.text.isNotEmpty) {
                                  if (email.text.isNotEmpty) {
                                    if (password.text.isNotEmpty) {
                                      setState(() {
                                        loading = !loading;
                                      });
                                    } else {
                                      newSnackBar(context,
                                          title: 'Password Required!');
                                    }
                                  } else {
                                    newSnackBar(context,
                                        title: 'Email Required!');
                                  }
                                } else {
                                  newSnackBar(context, title: 'Name Required!');
                                }

                                try {
                                  await FirebaseAuth.instance
                                      .createUserWithEmailAndPassword(
                                          email: email.text,
                                          password: password.text)
                                      .then((value) async {
                                    await FirebaseFirestore.instance
                                        .collection("/demo/account/users")
                                        .doc(value.user!.uid)
                                        .set({
                                      'uid': value.user!.uid,
                                      'name': name.text,
                                      'email': email.text,
                                    }).then((value) {
                                      email.clear();
                                      name.clear();
                                      password.clear();
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                            const   HomePage(),
                                        ),
                                      );
                                      setState(() {
                                        loading = !loading;
                                      });
                                    });
                                  });
                                } on FirebaseAuthException catch (e) {
                                  if (e.code == 'weak-password') {
                                    newSnackBar(context,
                                        title:
                                            'The password provided is too weak.');
                                    setState(() {
                                      loading = !loading;
                                    });
                                  } else if (e.code == 'email-already-in-use') {
                                    newSnackBar(context,
                                        title:
                                            'The account already exists for that email.');
                                    setState(() {
                                      loading = !loading;
                                    });
                                  }
                                } catch (e) {
                                  newSnackBar(context, title: e);
                                  setState(() {
                                    loading = !loading;
                                  });
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
                                    padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                                    child: Text(
                                      'Sign Up',
                                      style: TextStyle(color: white),
                                    ),
                                  ),
                                ],
                              ))
                          : Center(
                              child: MaterialButton(
                              onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const HomePage(),
                                ),
                              );
                            },

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
      elevation: 2.0,
      shadowColor: black,
      borderRadius: BorderRadius.circular(5.0),
      color: white,
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