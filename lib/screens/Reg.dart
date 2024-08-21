import 'package:flutter/material.dart';

class Reg extends StatefulWidget {
  const Reg({super.key});

  @override
  State<Reg> createState() => _RegState();
}

class _RegState extends State<Reg> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Register"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 200,
                width: 200,
                color: Colors.amberAccent,
                child: Column(
                  children: [
                    const TextField(
                      decoration: InputDecoration(hintText: 'Username'),
                    ),
                    const TextField(
                      decoration: InputDecoration(hintText: 'Email'),
                    ),
                    const TextField(
                      decoration: InputDecoration(hintText: 'Password'),
                    ),
                    ElevatedButton(
                        onPressed: () {}, child: const Text("Sign Up"))
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
