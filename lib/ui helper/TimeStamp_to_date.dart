import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

String formatTimestamp(Timestamp timestamp) {
  DateTime dateTime = timestamp.toDate();
  return DateFormat('yyyy-MM-dd HH:mm').format(dateTime); // Customize format as needed
}
