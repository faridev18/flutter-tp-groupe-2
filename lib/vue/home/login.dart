import 'dart:io';

import 'package:blog/vue/sharedUI/showSnackBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:blog/services/authentification.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool inLoginProcess = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/image2.jpg'),
                  fit: BoxFit.cover,
                  opacity: 200.0)),
          constraints: const BoxConstraints.expand(),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Padding(padding: EdgeInsets.only(top: 60.0)),
                      const Text(
                        "Bienvenu dans iBlog",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25.0),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      const Text(
                        "Lisez les informations les plus pertinentes sur les TIC et NTIC en général et sur l'informatique en particulier. \n Donnez vos avis en faisant des petits commentaires après la lecture.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 150.0),
                      const Text(
                        "Se connecter avec ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 20.0)),
                      inLoginProcess
                          ? const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.0),
                              child: Center(
                                  child: CircularProgressIndicator(
                                color: Color.fromARGB(176, 10, 160, 122),
                              )),
                            )
                          : Column(
                              children: [
                                Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                      width: 250.0,
                                      height: 40.0,
                                      alignment: Alignment.center,
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20.0))),
                                      child: TextButton(
                                        onPressed: () => singin(context),
                                        child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: const [
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10.0),
                                                child: Image(
                                                    image: AssetImage(
                                                        'images/google.png')),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 60.0),
                                                child: Text(
                                                  'Google',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ]),
                                      ),
                                    )),
                              ],
                            )
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future singin(BuildContext context) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          inLoginProcess = true;
          AuthService().signWithGoogle();
        });
      }
    } on SocketException catch (_) {
      showNotification(context, "Aucune connexion internet");
    }
  }
}
