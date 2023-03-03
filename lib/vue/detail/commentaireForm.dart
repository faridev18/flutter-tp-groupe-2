import 'dart:io';

import 'package:blog/models/billet.dart';
import 'package:blog/models/commentaire.dart';
import 'package:blog/services/dbBillet.dart';
import 'package:blog/vue/sharedUI/showSnackBar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CommentaireForm extends StatelessWidget {
  final User? user;
  final Billet billet;
  const CommentaireForm({this.user, required this.billet});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    String commentaire = "";

    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                width: MediaQuery.of(context).size.width / 1.3,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 12.0,
                  ),
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      maxLines: null,
                      minLines: null,
                      textInputAction: TextInputAction.newline,
                      textAlignVertical: TextAlignVertical.center,
                      keyboardType: TextInputType.multiline,
                      onChanged: (value) => commentaire = value,
                      validator: (value) => commentaire == ''
                          ? 'Veuillez saisir votre commentaire '
                          : null,
                      decoration: InputDecoration(
                        labelText: "Commentaires  ",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                      ),
                    ),
                  ),
                ),
              ),
              IconButton(
                  padding: const EdgeInsets.only(right: 12.0),
                  onPressed: () =>
                      onSudmit(billet, _formKey, user!, context, commentaire),
                  icon: const Icon(
                    Icons.send_rounded,
                    size: 40.0,
                    color: Colors.blue,
                  )),
            ],
          ),
          const Divider(),
          const SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }

  void onSudmit(
      Billet billet, keyform, User user, context, String textCom) async {
    if (keyform.currentState!.validate()) {
      Navigator.pop(context);
      Navigator.pushNamed(context, '/detail', arguments: billet);
      showNotification(context, "Chargement...");

      DataBaseServices db = DataBaseServices();

      Commentaire commentaire = Commentaire(
          billetID: billet.billetID,
          commentaireUserID: user.uid,
          commentaireUserName: user.displayName,
          texteCommentaire: textCom,
          userImage: user.photoURL);
      db.ajoutCommentaire(billet, commentaire);
    }
  }
}
