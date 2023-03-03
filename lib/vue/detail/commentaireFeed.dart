import 'package:blog/services/convertisseurDate.dart';
import 'package:flutter/material.dart';

class CommentaireFeed extends StatelessWidget {
  final commentaire;

  const CommentaireFeed({
    super.key,
    this.commentaire,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 2.0,
      ),
      child: ListTile(
          leading: CircleAvatar(
              backgroundColor: Colors.grey,
              backgroundImage: NetworkImage(commentaire['userImage'])),
          title: Text(
            commentaire['commentaireUserName'],
            style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 5.0,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: const Color.fromARGB(255, 235, 236, 243),
                    borderRadius: BorderRadius.circular(10.0)),
                child: Text(
                  commentaire['texteCommentaire'],
                  style: const TextStyle(fontSize: 16.0, color: Colors.black),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  DateConvertisseur()
                      .formattingDate(commentaire['commentaireTimestamp']),
                  textAlign: TextAlign.right,
                ),
              )
            ],
          )),
    );
  }
}
