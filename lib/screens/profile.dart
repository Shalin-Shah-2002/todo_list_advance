import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_flutter/Provider/authService.dart';
import 'package:todo_list_flutter/Provider/fetching_firestore.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext homecontext) {
    final authService = Provider.of<AuthService>(homecontext, listen: true);
    final userdata = Provider.of<FetchingFirestore>(homecontext, listen: true);

    String? username = userdata.username;
    String? email = userdata.email;

    if (!authService.isSignedIn) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pop(context);
      });
    }
    return Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
        ),
        body: Center(
            child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(150),
                ),
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 100,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 40,
                width: 300,
                decoration: BoxDecoration(
                    // color: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black, width: 3)),
                child: Center(child: Text('$username')),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 40,
                width: 300,
                decoration: BoxDecoration(
                    // color: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black, width: 3)),
                child: Center(child: Text('$email')),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(
                    height: 50,
                    width: 150,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.zero, // Removes rounded corners
                          ),
                        ),
                        onPressed: () {
                          authService.signOut();
                        },
                        child: Text("log out",style: TextStyle(color: Colors.white),)),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                      height: 50,
                      width: 150,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.zero, // Removes rounded corners
                            ),
                          ),
                          onPressed: () {},
                          child: Text(
                            "Update",
                            style: TextStyle(color: Colors.white),
                          ))),
                ],
              ),
              Spacer(),
            ],
          ),
        )));
  }
}
