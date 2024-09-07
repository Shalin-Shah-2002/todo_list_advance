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
                  height: 250,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          " Enter Your Task",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Assets().inputfield(
                            controller: title, hint: "Enter Your Task Title"),
                        Assets().inputfield(
                            controller: task, hint: "Enter Your Task"),
                        const SizedBox(
                          height: 30,
                        ),
                        Assets().ThemeButton(50, 100, "Add", () {
                          TaskaddingProvider.Adding(task: task, title: title);
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
                    final List<DocumentSnapshot> documents =
                        snapshot.data!.docs;
                    return documents.isEmpty
                        ? const Center(
                            child: Text(
                            "Create a Task, Your Task List Is Empty",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w900),
                          ))
                        : ListView.builder(
                            itemCount: documents.length,
                            itemBuilder: (context, index) {
                              final doc = documents[index];
                              final taskTitle = doc['Task'];
                              final isChecked = doc['Check'] ?? false;
                              return Dismissible(
                                key: Key(doc.id),
                                direction: DismissDirection.endToStart,
                                onDismissed: (direction) {
                                  print(doc.id);
                                  TaskaddingProvider.Deleteing(
                                    doc.id,
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'Task "${taskTitle}" dismissed')),
                                  );
                                },
                                background: Container(
                                  alignment: Alignment.centerRight,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  color: Colors.black,
                                  child: const Icon(Icons.delete,
                                      color: Colors.white),
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
                                          value: isChecked,
                                          onChanged: (value) {
                                            TaskaddingProvider.toggleCheckbox(
                                                value, doc.id);
                                          },
                                        ),
                                        Expanded(child: Text(taskTitle))
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
