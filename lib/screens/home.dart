import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_flutter/Provider/adding_task.dart';
import 'package:todo_list_flutter/Provider/fetching_firestore.dart';
import 'package:todo_list_flutter/screens/assets/appbar.dart';
import 'assets/assets.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  String? userid = FirebaseAuth.instance.currentUser?.uid;

  @override
  Widget build(BuildContext homecontext) {
    final CollectionReference showtaskcollection = FirebaseFirestore.instance
        .collection("users")
        .doc(userid)
        .collection("Tasks");

    final usernamedata = Provider.of<FetchingFirestore>(homecontext);
    final TaskaddingProvider = Provider.of<AddingTask>(homecontext);
    usernamedata.userdata();
    usernamedata.usernamedata();

    String? username = usernamedata.username;
    TextEditingController task = TextEditingController();
    TextEditingController title = TextEditingController();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        elevation: 10,
        backgroundColor: Colors.black,
        shape:
            ContinuousRectangleBorder(borderRadius: BorderRadius.circular(120)),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              actions: [
                Container(
                  height: 200,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Your Task",
                          style: TextStyle(),
                        ),
                        const Spacer(),
                        Assets().inputfield(
                            controller: title, hint: "Enter Your Task Title"),
                        Assets().inputfield(
                            controller: task, hint: "Enter Your Task"),
                        const SizedBox(
                          height: 30,
                        ),
                        Assets().ThemeButton(50, 100, "Add", () {
                          TaskaddingProvider.Adding(task, title);
                          Navigator.pop(context);
                        })
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            const MyAppBar(),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                username != null ? "What's up, $username" : "Loading...",
                style:
                    const TextStyle(fontSize: 35, fontWeight: FontWeight.w700),
              ),
            ),
            Container(
                height: 680,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: StreamBuilder<QuerySnapshot>(
                  stream: showtaskcollection.snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text("Error: ${snapshot.error}"));
                    }
                    // if (snapshot.connectionState == ConnectionState.waiting) {
                    //   return Center(child: CircularProgressIndicator());
                    // }
                    final List<DocumentSnapshot> documents =
                        snapshot.data!.docs;

                    return ListView.builder(
                      itemCount: documents.length,
                      itemBuilder: (context, index) {
                        final doc = documents[index];
                        final taskTitle = doc['Task'];
                        return Dismissible(
                          key: Key(doc.toString()),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) {
                            TaskaddingProvider.Deleteing(title);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text('Item ${index + 1} dismissed')),
                            );
                          },
                          background: Container(
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            color: Colors.black,
                            child: Icon(Icons.delete, color: Colors.white),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey.shade300,
                              ),
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: false,
                                    onChanged: (value) {},
                                  ),
                                  Text(taskTitle)
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ))
          ],
        ),
      ),
    );
  }
}
