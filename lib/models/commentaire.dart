import 'package:cloud_firestore/cloud_firestore.dart';

class Commentaire {
  String? commentaireID,
      texteCommentaire,
      commentaireUserID,
      commentaireUserName,
      billetID;
  String? userImage;
  Timestamp? commentaireTimestamp;
  Commentaire({
    this.commentaireID,
    this.texteCommentaire,
    this.billetID,
    this.commentaireUserName,
    this.commentaireTimestamp,
    this.userImage,
    required commentaireUserID,
  });
}
