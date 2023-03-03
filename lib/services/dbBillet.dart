import 'package:blog/models/billet.dart';
import 'package:blog/models/commentaire.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DataBaseServices {
  String? userID, billetID;
  DataBaseServices({this.userID, this.billetID});
  final CollectionReference _article =
      FirebaseFirestore.instance.collection('billets');
  final FirebaseStorage _storage = FirebaseStorage.instance;

// upload de l'image vers Firebase Storage

  Future<String> uploadFile(file) async {
    Reference reference = _storage.ref().child('billet/${DateTime.now()}.png');
    UploadTask uploadTask = reference.putFile(file);
    TaskSnapshot taskSnapshot = await uploadTask;
    return await taskSnapshot.ref.getDownloadURL();
  }

  // Billet

// Ajout de billet
  void addBillet(Billet billet) {
    _article.add({
      "billetTitre": billet.billetTitre,
      "billetUrlImg": billet.billetUrlImg,
      "billetUserID": billet.billetUserID,
      "billetUserName": billet.billetUserName,
      "billetDetail": billet.billetDetail,
      "billetTimestamp": FieldValue.serverTimestamp()
    });
  }

  // Récupération des billet

  Stream<List<Billet>> get billets {
    Query queryBillets = _article.orderBy('billetTimestamp', descending: true);
    return queryBillets.snapshots().map((snashots) {
      return snashots.docs.map((doc) {
        return Billet(
          billetID: doc.id,
          billetTitre: doc.get('billetTitre'),
          billetUrlImg: doc.get('billetUrlImg'),
          billetUserID: doc.get('billetUserID'),
          billetUserName: doc.get('billetUserName'),
          billetDetail: doc.get('billetDetail'),
          billetTimestamp: doc.get('billetTimestamp'),
        );
      }).toList();
    });
  }

  // Suppression de billet

  Future<void> deleteBillet(String billetID) => _article.doc(billetID).delete();

  void updateBillet(Billet billet) async {
    final billetDoc = _article.doc(billet.billetID);
    billetDoc.update(({
      "billetTitre": billet.billetTitre,
      "billetUrlImg": billet.billetUrlImg,
      "billetDetail": billet.billetDetail,
    }));
  }

  //Ajout des commentaires

  void ajoutCommentaire(Billet billet, Commentaire commentaire) async {
    final billetDocRef = _article.doc(billet.billetID);
    final commentaires = billetDocRef.collection('commentaires');
    commentaires.add({
      "billetID": billet.billetID,
      "texteCommentaire": commentaire.texteCommentaire,
      "commentaireUserID": commentaire.commentaireUserID,
      "commentaireUserName": commentaire.commentaireUserName,
      "commentaireTimestamp": FieldValue.serverTimestamp(),
      "userImage": commentaire.userImage
    });
  }

  // Récuperation des commentaires

  /* Stream<Commentaire> get commentairesList {
    final commentaires = _article.doc(billetID).collection('commentaires');
    return commentaires.doc(billetID).snapshots().map((doc) {
      return Commentaire(
          commentaireID: doc.id,
          commentaireUserID: doc.get('commentaireUserID'),
          commentaireUserName: doc.get('commentaireUserName'),
          commentaireTimestamp: doc.get('commentaireTimestamp'),
          texteCommentaire: doc.get('texteCommentaire'),
          userImage: doc.get('userIma'));
    });
  }*/

  /*Stream<List<Commentaire>> get commentairesList {
    final commentaires = _article.doc(billetID).collection('commentaires');
    Query query =
        commentaires.orderBy('commentaireTimestamp', descending: true);
    return query.snapshots().map((event) {
      return event.docs.map((doc) {
        return Commentaire(
            commentaireID: doc.id,
            billetID: doc.get('billetID'),
            commentaireUserID: doc.get('commentaireUserID'),
            commentaireUserName: doc.get('commentaireUserName'),
            commentaireTimestamp: doc.get('commentaireTimestamp'),
            texteCommentaire: doc.get('texteCommentaire'),
            userImage: doc.get('userIma'));
      }).toList();
    });
  }*/
}
