import 'package:blog/models/commentaire.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Billet {
  String? billetID,
      billetTitre,
      billetUrlImg,
      billetUserID,
      billetUserName,
      billetDetail;
  Timestamp? billetTimestamp;

  Billet({
    this.billetID,
    this.billetTitre,
    this.billetUrlImg,
    this.billetDetail,
    this.billetUserID,
    this.billetUserName,
    this.billetTimestamp,
  });
}
