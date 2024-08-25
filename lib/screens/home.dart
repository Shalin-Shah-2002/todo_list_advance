import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:todo_list_flutter/Provider/authService.dart';
import 'package:todo_list_flutter/Provider/fetching_firestore.dart';
import 'package:todo_list_flutter/screens/assets/appbar.dart';
import 'package:todo_list_flutter/screens/profile.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  // void initState() {
  //   // TODO: implement initState
  //   final usernamedata = Provider.of<FetchingFirestore>(context);
  //   usernamedata.userdata();
  //   usernamedata.usernamedata();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext homecontext) {
    final usernamedata = Provider.of<FetchingFirestore>(homecontext);
    usernamedata.userdata();
    usernamedata.usernamedata();

    String? username = usernamedata.username;
    String? email = usernamedata.email;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            MyAppBar(),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                username != null ? "What's up, $username" : "Loading...",
                style: TextStyle(fontSize: 35,fontWeight: FontWeight.w700),
              ),
            ),
            // Text()
          ],
        ),
      ),
    );
  }
}
