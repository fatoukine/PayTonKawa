import 'package:paytonkawa/constants.dart';
import 'package:paytonkawa/firebase_options.dart';
import 'package:paytonkawa/views/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:paytonkawa/controllers/product_controller.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductController()),
      ],
    
    child: MaterialApp(
      title: 'Paytonkawa',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'nsb',
        scaffoldBackgroundColor: white,
        appBarTheme: const AppBarTheme(
          backgroundColor: brown,
        ),
      ),
      home: const SplashScreen(),
      ),
    );
  }
}