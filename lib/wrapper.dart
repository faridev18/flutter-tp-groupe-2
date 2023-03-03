import 'package:blog/vue/home/home.dart';
import 'package:blog/vue/home/login.dart';
import 'package:blog/vue/home/welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<User?>(context);
    return _user == null ? const Login() : const Home();
  }
}
