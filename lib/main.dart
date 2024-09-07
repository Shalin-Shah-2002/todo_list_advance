import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_flutter/Provider/adding_task.dart';
import 'package:todo_list_flutter/Provider/authService.dart';
import 'package:todo_list_flutter/Provider/updating_userprofile.dart';
import 'package:todo_list_flutter/screens/Reg.dart';
import 'package:todo_list_flutter/Provider/fetching_firestore.dart';
import 'package:todo_list_flutter/screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProvider(create: (context) => FetchingFirestore()),
        ChangeNotifierProvider(create: (context) => UpdateUserProfile()),
        ChangeNotifierProvider(
          create: (context) => AddingTask(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AuthCheck(),
      ),
    );
  }
}

class AuthCheck extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    if (authService.isSignedIn) {
      return const MyHome(); // User is signed in, show home page
    } else {
      return LoginRegisterScreen(); // User is not signed in, show sign-in page
    }
  }
}
