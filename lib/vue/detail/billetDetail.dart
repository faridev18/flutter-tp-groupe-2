import 'package:blog/models/billet.dart';
import 'package:blog/vue/sharedUI/photoDetail.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class BilletDetail extends StatelessWidget {
  final Billet? billet;
  final User? user;
  const BilletDetail({super.key, this.billet, this.user});

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;

    return SliverList(
      delegate: SliverChildListDelegate([
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20.0,
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 5.0,
                ),
                width: MediaQuery.of(context).size.height * 2.5,
                decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    billet!.billetTitre!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.indigo,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Card(
                elevation: 7.5,
                child: Hero(
                  tag: billet!.billetUrlImg!,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  PhotoDetail(url: billet!.billetUrlImg!)));
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.width * 0.70,
                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(billet!.billetUrlImg!))),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                    ),
                    width: MediaQuery.of(context).size.height * 2.5,
                    decoration: const BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Color.fromARGB(255, 235, 236, 243),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        billet!.billetDetail!,
                        style: const TextStyle(
                            color: Colors.black87, fontSize: 15.0),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                    ),
                    padding: const EdgeInsets.only(
                        top: 10.0, right: 10.0, bottom: 10.0),
                    width: MediaQuery.of(context).size.height * 2.5,
                    color: const Color.fromARGB(255, 235, 236, 243),
                    child: Text(
                      billet!.billetUserName!,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.indigo,
                          fontSize: 12.0),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              const Divider(
                thickness: 3.0,
                color: Colors.indigo,
                indent: 100.0,
                endIndent: 100.0,
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                ),
                padding:
                    const EdgeInsets.only(top: 20.0, right: 10.0, bottom: 10.0),
                width: MediaQuery.of(context).size.height * 2.5,
                child: const Text(
                  'Commentaires ',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      color: Colors.black),
                ),
              ),
              const Divider(),
            ],
          ),
        )
      ]),
    );
  }

  String formattingDate(Timestamp? timestamp) {
    initializeDateFormatting('fr');
    DateTime? dateTime = timestamp?.toDate();
    DateFormat dateFormat = DateFormat.yMMMd('fr');
    return dateFormat.format(dateTime ?? DateTime.now());
  }
}
