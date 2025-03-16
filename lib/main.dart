import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/firebase_options.dart';
import 'package:todoapp/home/home_screen.dart';
import 'package:todoapp/pages/loginpage.dart';
import 'package:todoapp/services/auth_services.dart';
import 'package:todoapp/slider%20and%20start/onboarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthServices authServices = AuthServices();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: authServices.getCureUser()!=null ? HomePage() : LoginPage(),
    );
  }
}
