import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

String timeAndDate(Timestamp timestamp) {
  DateTime dateTime = timestamp.toDate();
  return DateFormat('dd-MM-yyyy HH:mm').format(dateTime); // Customize format as needed
}

String onlyDate(Timestamp timestamp) {
  DateTime dateTime = timestamp.toDate();
  return DateFormat('dd-MM').format(dateTime); // Customize format as needed
}
