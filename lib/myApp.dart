import 'package:blog/vue/home/addArticleForm.dart';
import 'package:blog/vue/home/login.dart';
import 'package:blog/vue/home/welcome.dart';
import 'package:blog/vue/profile/profile.dart';
import 'package:blog/vue/detail/detail.dart';
import 'package:blog/vue/sharedUI/Articles/allArticle.dart';
import 'package:blog/vue/sharedUI/billetFeed.dart';
import 'package:blog/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blog/vue/detail/modifBillet.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<User?>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'iBlog',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      initialRoute: '/',
      routes: {
        /*'/': (context) => const Welcome(),*/
        '/': (context) => const Wrapper(),
        '/login': (context) => const Login(),
        '/profile': ((context) => const Profile()),
        '/add': ((context) => const Ajout()),
        '/detail': (context) => const Detail(),
        '/articles': (context) => const Articles(),
      },
    );
  }
}
