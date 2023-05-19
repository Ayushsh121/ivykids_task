import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Users_list.dart';
import 'add_users.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('ivykids task'),
            ElevatedButton(
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddUsers(),
                  ),
                )
              },
              child: Text('Add', style: TextStyle(fontSize: 20.0)),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
            )
          ],
        ),
      ),
      body: ListUsers(),
    );
  }
}
