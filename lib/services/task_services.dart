import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/home/home_screen.dart';
import 'package:todoapp/services/auth_services.dart';

class TaskServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthServices _authServices = AuthServices();
  
  // store task to firebase
  Future<void> addTask(
      String title, String description, DateTime? dueDate) async {

    try{
      String? userId = _authServices.getCureUser()?.uid;

      DocumentReference docRef = await _firestore
          .collection("users")
          .doc(userId)
          .collection("tasks")
          .add({
        "title": title,
        "description": description,
        "dueDate": dueDate ?? DateTime.now().add(Duration(days: 5)),
        "isCompleted": false,
        "category" : "",
        "priority" : "",
        "createdAt": FieldValue.serverTimestamp(),
      });

      // Get the auto-generated task ID
      String taskId = docRef.id;

      // Update the task document to store its ID
      await docRef.update({"taskId": taskId});

      print("Task added with ID: $taskId");
    }
    catch(e){
      print(e);
    }
  }


  // Get task by user
  Stream<QuerySnapshot> getTasks() {
    String? userId = _authServices.getCureUser()?.uid;
    return _firestore
        .collection("users")
        .doc(userId)
        .collection("tasks")
        .orderBy("title")
        .snapshots();
  }
  
  Stream<QuerySnapshot> getCompletedTasks(){
    String? userId = _authServices.getCureUser()?.uid;
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('tasks')
        .where('isCompleted', isEqualTo: true)
        .snapshots();
  }


  Stream<QuerySnapshot> getTaskByFilter(bool completed){
    String? userId = _authServices.getCureUser()?.uid;
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('tasks')
        .where('isCompleted', isEqualTo: completed)
        .snapshots();
  }

  Stream<QuerySnapshot> getInCompletedTasks() {
    String? userId = _authServices.getCureUser()?.uid;
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('tasks')
        .where('isCompleted', isEqualTo: false)
        .snapshots();
  }

  Future<void> deleteTask(String taskId, BuildContext context) async {
    try{
      String? userId = _authServices.getCureUser()?.uid;
      await _firestore.collection('users').doc(userId).collection('tasks').doc(taskId).delete();
      print('Deleted Successfuly');
    }
    catch(e){
      print('error');
      print(e);
    }
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomePage()), (route)=>false);
  }

  Future<void> markAsCompleted(String taskId) async {
    try{
      String? userId = _authServices.getCureUser()?.uid;
      print(taskId);
      await _firestore.collection('users').doc(userId).collection('tasks').doc(taskId).update({
        'isCompleted' : true
      });
    }
    catch(e){
      print('${e}cant update task as completed!');
    }
  }


}