import 'dart:async';
import 'package:paytonkawa/constants.dart';
import 'package:paytonkawa/views/login.dart';
import 'package:paytonkawa/views/register.dart';
import 'package:flutter/material.dart';
import 'package:paytonkawa/views/homepage.dart';
import 'package:paytonkawa/views/augmented_reality.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) =>  LoginPage(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: brown,
      body: Center(
        child: Image(
          image: AssetImage("lib/logo.JPG"),
          width: 150,
        ),
      ),
    );
  }
}