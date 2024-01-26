import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/chats/messages.dart';
import '../widgets/chats/new_message.dart';

class ChatScreen extends StatefulWidget {
  static const routeName = '/chat-screen';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FlutterChat'),
        foregroundColor: Theme.of(context).colorScheme.background,
        backgroundColor: Theme.of(context).colorScheme.primary,
        // actions: [
        //   DropdownButton(
        //       icon: Icon(
        //         Icons.more_vert,
        //         color: Theme.of(context).primaryIconTheme.color,
        //       ),
        //       items: [
        //         DropdownMenuItem(
        //           value: 'logout',
        //           child: Container(
        //             child: Row(
        //               children: [
        //                 Icon(Icons.exit_to_app),
        //                 SizedBox(width: 8),
        //                 Text('Logout'),
        //               ],
        //             ),
        //           ),
        //         )
        //       ],
        //       onChanged: (itemIdentifier) {
        //         if (itemIdentifier == 'logout') {
        //           FirebaseAuth.instance.signOut();
        //         }
        //       })
        // ],
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(child: Messages()),
            NewMessage(),
          ],
        ),
      ),
    );
  }
}
