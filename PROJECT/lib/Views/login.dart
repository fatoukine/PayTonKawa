import 'package:http/http.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:paytonkawa/constants.dart';
import 'package:paytonkawa/views/homepage.dart';
import 'package:paytonkawa/views/register.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:paytonkawa/views/qrScan.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

   


  Future sendEmail({
    required String receiver_email,
    required String email,
    required String subject,
    required String message,
  }) async {
    final serviceId = 'service_gz415yv';
    final templateId = 'template_836wk43';
    final userId = '-qhYTuja4s3dTXI0n';

    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final response = await http.post(
      url,
      headers: {
        'origin': 'http://localhost',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'template_params': {
          'receiver_email': receiver_email,
          'user_email': email,
          'user_subject': subject,
          'user_message': message,
        },
      }),
    );

    print(response.body);
  }

/*  _shareQrCode() async {
    final directory = (await getApplicationDocumentsDirectory()).path;
    String fileName = DateTime.now().microsecondsSinceEpoch.toString();
    final imageFile = await File('pic/$fileName.png').create();
    screenshotController
        .capture()
        .then((Uint8List image) async {
          if (image != null) {
            try {
              if (imageFile != null) {
                await imageFile.writeAsBytes(image);
                // Share.shareFiles([imageFile.path]);
              }
            } catch (error) {}
          }
        } as FutureOr Function(Uint8List? value))
        .catchError((onError) {
      print('Error --->> $onError');
    });
  }
*/
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
                        'Connexion PayTonKawa Mobile',
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
                                        sendEmail(
                                          receiver_email: email.text,
                                          email: email.text,
                                          subject:
                                              'Authenfification PayTonKawa',
                                          message: '' /*'Dans le cadre de sa campagne de réforme et mise en place d\'
  environnement sécurisé, la socièté PayTonkawa procède à un nouveau mode 
  d\'authentification au niveau de ses applications mobiles notemment au niveau de 
  PayTonKawa Mobile.
  De ce fait pour terminer votre authentification sur l\'application PayTonKawa
  Mobile, vous devez necessairement scanner le Qrcode rattaché à ce mail depuis 
  l\'application mobile.' */,
                                        );
                                        //_shareQrCode();
                                        setState(() {
                                          loading = !loading;
                                        });
                                      } else {
                                        newSnackBar(context,
                                            title:
                                                'Email et Password Requises!');
                                      }
                                    } else {
                                      newSnackBar(context,
                                          title: 'Email Requise!');
                                    }

                                    try {
                                      await FirebaseAuth.instance
                                          .signInWithEmailAndPassword(
                                              email: email.text,
                                              password: password.text)
                                          .then((value) {

                                        newSnackBar(context,
                                            title:
                                                'Un email de qrcode vous a été envoyé. Veuillez vérifier vos e-mail et scanner le qrcode !');    


                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const HomePage(), // QrScan(),const  HomePage(),
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
                                                'Aucun utilisateur n\'existe avec ce compte email');
                                        setState(() {
                                          loading = !loading;
                                        });
                                      } else if (e.code == 'wrong-password') {
                                        newSnackBar(context,
                                            title:
                                                'Mot de passe erroné! Veuillez réessayer !');
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
                                          'Connexion',
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
                          builder: (context) => QRScanPage(),
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
                    "Vous n'avez de compte ? ",
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
                      'Inscription',
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
