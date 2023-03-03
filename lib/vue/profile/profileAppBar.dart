import 'package:blog/services/authentification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileAppBar extends StatelessWidget {
  final User? user;
  const ProfileAppBar({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: const Color.fromRGBO(89, 107, 200, 0.7),
      title: const Text('PROFIL'),
      floating: false,
      forceElevated: false,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/profile'),
            child: IconButton(
              onPressed: () => signOut(context),
              icon: const Icon(
                Icons.logout,
              ),
            ),
          ),
        ),
      ],
    );
  }

  signOut(BuildContext context) {
    Navigator.of(context).pop();
    AuthService().sigOut();
  }
}
