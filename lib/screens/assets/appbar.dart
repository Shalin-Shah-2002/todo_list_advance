import 'package:flutter/material.dart';

import 'package:todo_list_flutter/screens/profile.dart';

class MyAppBar extends StatefulWidget {
  const MyAppBar({super.key});

  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Profile(),
                ));
          },
          child: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(50)),
          ),
        ),
        const Spacer(),
        IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        IconButton(
            onPressed: () {}, icon: const Icon(Icons.notifications_active)),
      ],
    );
  }
}
