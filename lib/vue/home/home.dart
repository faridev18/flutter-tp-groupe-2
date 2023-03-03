import 'package:blog/vue/home/addSectionBar.dart';
import 'package:blog/vue/home/appHomeBar.dart';
import 'package:blog/vue/sharedUI/listBillet.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<User?>(context);
    return Scaffold(
        extendBodyBehindAppBar: true,
        body: SafeArea(
          child: CustomScrollView(slivers: [
            HomeAppBar(user: _user),
            AddCarSection(user: _user),
            SliverList(
                delegate: SliverChildListDelegate([
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                child: Text(
                  'A la une',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ])),
            BilletList(
              userID: _user!.uid,
            ),
          ]),
        ));
  }
}
