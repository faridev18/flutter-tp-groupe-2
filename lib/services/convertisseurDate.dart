import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class DateConvertisseur {
  String formattingDate(Timestamp? timestamp) {
    String il = "Il y a";
    String format = "yyyy-MM-dd HH:mm:ss.zzz";
    var formatter = timestamp?.toDate();
    DateTime? dateTime = timestamp?.toDate();
    if (dateTime == null) {
      return "Date Inconnue";
    } else {
      var difference = DateTime.now().difference(dateTime);
      var jours = difference.inDays;
      var heures = difference.inHours;
      var minutes = difference.inMinutes;

      if (jours > 1 && jours <= 7) {
        return "$il $jours jours";
      } else if (jours == 1) {
        return "$il 1 jour";
      } else if (jours >= 8) {
        initializeDateFormatting('fr');
        DateFormat dateFormat = DateFormat.yMEd('fr');
        return dateFormat.format(dateTime);
      } else if (heures > 1) {
        return "$il $heures heures";
      } else if (heures == 1) {
        return "$il $heures heure";
      } else if (minutes > 1) {
        return "$il $minutes minutes";
      } else if (minutes == 1) {
        return "$il $minutes minute";
      } else {
        return "A l'instant";
      }
    }
  }
}
