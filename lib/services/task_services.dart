import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TaskServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  // store task to firebase
  Future<void> addTask(String title, String description, DateTime? dueDate) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    await _firestore
        .collection("users")
        .doc(userId)
        .collection("tasks")
        .add({
            "title": title,
            "description": description,
            "dueDate": dueDate,
            "isCompleted": false,
            "createdAt": FieldValue.serverTimestamp(),
    });
  }

  // Get task by user
  Stream<QuerySnapshot> getTasks() {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    return _firestore
        .collection("users")
        .doc(userId)
        .collection("tasks")
        .orderBy("dueDate")
        .snapshots();
  }


}