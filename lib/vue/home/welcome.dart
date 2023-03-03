import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<User?>(context);
    return Scaffold(
      backgroundColor: const Color.fromRGBO(89, 107, 200, 0.7),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(padding: EdgeInsets.only(top: 60.0)),
                    const Text(
                      "Bienvenu sur notre Blog",
                      textScaleFactor: 1.2,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 50.0)),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.30,
                      width: MediaQuery.of(context).size.height * 0.30,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('images/olo.png'),
                              fit: BoxFit.fill)),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 50.0)),
                    ElevatedButton(
                      style: TextButton.styleFrom(
                        elevation: 10.0,
                        backgroundColor:
                            const Color.fromARGB(177, 89, 200, 148),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/wrapper');
                      },
                      child: const Text(
                        'Continuer',
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
