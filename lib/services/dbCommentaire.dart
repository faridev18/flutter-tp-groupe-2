/*import 'package:blog/models/commentaire.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DataBaseServices {
  String? userID, commentaireID;
  DataBaseServices({this.userID, this.commentaireID});
  final CollectionReference _commentaire =
      FirebaseFirestore.instance.collection('commentaire');
  final FirebaseStorage _storage = FirebaseStorage.instance;

//Ajout des commentaires
  void addCommentaire(Commentaire commentaire) {
    _commentaire.add({
      "commentaireID": commentaire.billetID,
      "texteCommentaire": commentaire.texteCommentaire,
      "commentaireUserID": commentaire.commentaireUserID,
      "commentaireUserName": commentaire.commentaireUserName,
      "commentaireTimestamp": commentaire.commentaireTimestamp,
    });
  }

  // Recuperation des données

  Stream<List<Commentaire>> get commentaires {
    Query commentaireQuery =
        _commentaire.orderBy('commentaireTimestamp', descending: true);
    return commentaireQuery.snapshots().map((snapshots) {
      return snapshots.docs.map((doc) {
        return Commentaire(
            commentaireID: doc.id,
            texteCommentaire: doc.get('texteCommentaire'),
            commentaireUserID: doc.get('commentaireUserID'),
            commentaireUserName: doc.get('commentaireUserName'),
            commentaireTimestamp: doc.get('commentaireTimestamp'));
      }).toList();
    });
  }
}*/
