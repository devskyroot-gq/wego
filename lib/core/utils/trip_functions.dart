import 'package:cloud_firestore/cloud_firestore.dart';

class TripFunctions {
  
  //showing time since post
  String timeAgo(Timestamp timestamp) {
    final date = timestamp.toDate();
    final diff = DateTime.now().difference(date);

    if (diff.inMinutes < 1) return 'Ahora';
    if (diff.inMinutes < 60) return 'Hace ${diff.inMinutes}mins';
    if (diff.inHours < 24) return 'Hace ${diff.inHours}h';
    if (diff.inDays == 1) return 'Ayer';
    if (diff.inDays < 30) return 'Hace ${diff.inDays}d';
    if (diff.inDays < 365) return 'Hace ${diff.inDays ~/ 30}m';
    return 'Hace ${diff.inDays ~/ 365}a';
  }

  //get time 
  String getTime(Timestamp timestamp) {
    final date = timestamp.toDate();
    final diff = DateTime.now().difference(date);
    if (diff.inMinutes < 1) return diff.inSeconds.toString();
    if (diff.inMinutes < 60) return diff.inMinutes.toString();
    if (diff.inHours < 24) return diff.inHours.toString();
    if (diff.inDays < 30) return diff.inDays.toString();
    return diff.inDays.toString();
  }
}


