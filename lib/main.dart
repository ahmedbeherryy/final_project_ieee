import 'package:final_project_ieee/pages/controller_page.dart';
import 'package:final_project_ieee/pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(Controller());
}

class Controller extends StatelessWidget {
  const Controller({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // routes: {
      //   'RegisterPage':(context)=> RegisterPage(),ahmed
      // },
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
