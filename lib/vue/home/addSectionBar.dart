import 'dart:io';
import 'package:blog/models/billet.dart';
import 'package:blog/services/dbBillet.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddCarSection extends StatelessWidget {
  final User? user;
  const AddCarSection({this.user});

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<User?>(context);
    return SliverList(
      delegate: SliverChildListDelegate([
        const Divider(
          height: 0.1,
        ),
        Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Salut'),
                    Text(
                      user!.displayName!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                if (user!.email == 'ferdinandmitondji203@gmail.com' ||
                    user!.email == 'anthimefanou2001@gmail.com' ||
                    user!.email == 'odileyayi2@gmail.com' ||
                    user!.email == 'zfarihane@gmail.com' ||
                    user!.email == 'assogbadjon@gmail.com' ||
                    user!.email == 'marieanneguendehou@gmail.com' ||
                    user!.email == 'naimatoubaparape@gmail.com' ||
                    user!.email == 'laurinelaurielaurine2001@gmail.com' ||
                    user!.email == 'erickadje96@gmail.com')
                  Row(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        margin: const EdgeInsets.only(left: 8.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context)
                                .primaryColor
                                .withOpacity(0.5)),
                        child: IconButton(
                            onPressed: (() =>
                                Navigator.pushNamed(context, '/add')),
                            icon: const Icon(Icons.add)),
                      ),
                    ],
                  )
              ],
            )),
        const Divider(),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        ),
      ]),
    );
  }
}
