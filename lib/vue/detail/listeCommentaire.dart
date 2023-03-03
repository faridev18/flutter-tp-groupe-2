import 'package:blog/vue/detail/commentaireFeed.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CommentaireList extends StatefulWidget {
  final billetID;
  const CommentaireList({super.key, this.billetID});

  @override
  State<CommentaireList> createState() => _CommentaireListState();
}

class _CommentaireListState extends State<CommentaireList> {
  @override
  Widget build(BuildContext context) {
    final billet = FirebaseFirestore.instance.collection('billets');
    final comments =
        billet.doc(widget.billetID).collection('commentaires').snapshots();
    int i = 3;

    return SliverList(
        delegate: SliverChildListDelegate([
      StreamBuilder(
          stream: comments,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Text('Aucun Commentaire');
            } else {
              QuerySnapshot data = snapshot.requireData;
              return Column(
                children: [
                  ...List.generate(data.size, ((index) {
                    Map item = data.docs[index].data() as Map;
                    return CommentaireFeed(
                      commentaire: item,
                    );
                  }))
                ],
              );
            }
          })
    ]));
  }
}
