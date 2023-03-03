import 'package:blog/models/billet.dart';
import 'package:blog/vue/detail/modifBillet.dart';
import 'package:blog/vue/sharedUI/showSnackBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../services/dbBillet.dart';

class DatailAppBar extends StatelessWidget {
  final Billet? billet;
  final User? user;
  const DatailAppBar({super.key, this.user, this.billet});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: const Color.fromRGBO(89, 107, 200, 0.7),
      title: const Text(
        "Detail de l'article",
        textAlign: TextAlign.left,
        style: TextStyle(fontSize: 16.0),
      ),
      actions: [
        if (user!.email == 'ferdinandmitondji203@gmail.com' ||
            user!.email == 'anthimefanou2001@gmail.com' ||
            user!.email == 'odileyayi2@gmail.com' ||
            user!.email == 'zfarihane@gmail.com' ||
            user!.email == 'assogbadjon@gmail.com' ||
            user!.email == 'marieanneguendehou@gmail.com' ||
            user!.email == 'naimatoubaparape@gmail.com' ||
            user!.email == 'laurinelaurielaurine2001@gmail.com')
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext builContexte) {
                  return ModifierBillet(
                    billet: billet,
                  );
                }));
              },
              icon: const Icon(Icons.edit)),
        if (user!.email == 'ferdinandmitondji203@gmail.com' ||
            user!.email == 'anthimefanou2001@gmail.com' ||
            user!.email == 'odileyayi2@gmail.com' ||
            user!.email == 'zfarihane@gmail.com' ||
            user!.email == 'assogbadjon@gmail.com' ||
            user!.email == 'marieanneguendehou@gmail.com' ||
            user!.email == 'naimatoubaparape@gmail.com' ||
            user!.email == 'laurinelaurielaurine2001@gmail.com')
          IconButton(
              onPressed: () => deleteBillet(context, billet!),
              icon: const Icon(Icons.delete, color: Colors.white)),
      ],
    );
  }

  void deleteBillet(BuildContext context, Billet billet) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(
              'Voulez-vous supprimer \n \n "${billet.billetTitre}" ?',
              textAlign: TextAlign.center,
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(
                    "ANNULER",
                    style: TextStyle(color: Colors.red),
                  )),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  DataBaseServices().deleteBillet(billet.billetID!);
                  showNotification(context, 'Supprimée avec succès');
                },
                style: TextButton.styleFrom(backgroundColor: Colors.red),
                child: const Text("SUPPRIMER"),
              )
            ],
          );
        });
  }
}
