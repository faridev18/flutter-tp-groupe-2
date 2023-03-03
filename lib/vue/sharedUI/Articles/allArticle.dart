import 'package:blog/models/billet.dart';
import 'package:blog/services/dbBillet.dart';
import 'package:blog/vue/home/addSectionBar.dart';
import 'package:blog/vue/home/appHomeBar.dart';
import 'package:blog/vue/sharedUI/aLaUneFeed.dart';
import 'package:blog/vue/sharedUI/listBilletFeed.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Articles extends StatefulWidget {
  const Articles({super.key});
  @override
  State<Articles> createState() => _ArticlesState();
}

class _ArticlesState extends State<Articles> {
  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<User?>(context);
    final billet = Provider.of<List<Billet>>(context);
    return Scaffold(
        extendBodyBehindAppBar: true,
        body: SafeArea(
          child: CustomScrollView(slivers: [
            HomeAppBar(user: _user),
            AddCarSection(user: _user),
            SliverList(
                delegate: SliverChildListDelegate([
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
                child: Text(
                  'ARTICLES',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ),
              const Divider(
                thickness: 3.0,
                color: Colors.indigo,
                indent: 15.0,
                endIndent: 100.0,
              ),
              const SizedBox(
                height: 20.0,
              )
            ])),
            SliverList(
                delegate: SliverChildBuilderDelegate((_, index) {
              return StreamBuilder(
                  stream: DataBaseServices(
                          userID: _user!.uid, billetID: billet[index].billetID)
                      .billets,
                  builder: (context, snapshot) {
                    return ListBilletFeed(
                      billet: billet[index],
                      userID: _user.uid,
                    );
                  });
            }, childCount: billet.length))
          ]),
        ));
  }
}
