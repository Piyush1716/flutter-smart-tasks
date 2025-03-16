import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // get cur user
  User? getCureUser() => _auth.currentUser;
  
  // Store User Data in Firestore (on Registration)
  Future<void> saveUserToFirebase({required String name}) async {
    try {
      User? user = _auth.currentUser; // Get logged-in user

      if (user != null) {
        DocumentReference userDoc =
            _firestore.collection("users").doc(user.uid);

        DocumentSnapshot doc = await userDoc.get();

        if (!doc.exists) {
          // Save user data only if user does not exist
          await userDoc.set({
            "uid": user.uid,
            "name": name,
            "email": user.email,
            "createdAt": FieldValue.serverTimestamp(),
          });
          print("User data stored successfully!");
        } else {
          print("User already exists in Firestore.");
        }
      }
    } catch (e) {
      print("Error saving user data: $e");
    }
  }
  // signin
  Future<User?> signin(String email, pass, name) async {
    try{
      UserCredential user = await _auth.signInWithEmailAndPassword(email: email, password: pass);
      await saveUserToFirebase(name: name);
      return user.user;
    }
    catch(e){
      throw e;
    }
  }

  // signup
  Future<User?> signup(String email, pass, name) async {
    try{
      UserCredential user = await _auth.createUserWithEmailAndPassword(email: email, password: pass);
      
      // save user to database
      await saveUserToFirebase(name: name);
      print('saved');
      return user.user;
    }
    catch(e){
      print(e);
      return null;
    }
  }

  // logout
  Future<void> signout() async {
    await _auth.signOut();
  }
  // to get cur user info from firebase database
  Future<Map<String, dynamic>?> getUserData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection("users")
            .doc(user.uid)
            .get();

        if (userDoc.exists) {
          return userDoc.data() as Map<String, dynamic>;
        }
      }
    } catch (e) {
      print("Error retrieving user data: $e");
    }
    return null;
  }

}