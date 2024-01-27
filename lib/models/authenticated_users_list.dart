import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../screens/chat_screen.dart';

class AuthenticatedUsersList extends StatefulWidget {
  @override
  _AuthenticatedUsersListState createState() => _AuthenticatedUsersListState();
}

class _AuthenticatedUsersListState extends State<AuthenticatedUsersList> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late User _currentUser;
  List<Map<String, String>> _authenticatedUsers = [];

  @override
  void initState() {
    super.initState();
    _currentUser = _auth.currentUser!;
    _fetchAuthenticatedUsers();
  }

  Future<void> _fetchAuthenticatedUsers() async {
    QuerySnapshot querySnapshot = await _firestore.collection('users').get();
    List<Map<String, String>> users = [];

    querySnapshot.docs.forEach((doc) {
      // Exclude the current user from the list
      if (doc.id != _currentUser.uid) {
        String email = doc['email'];
        String username = doc['username'];
        String imageUrl = doc['image_url'];
        String specialization = doc['specialization'];
        users.add({
          'email': email,
          'username': username,
          'image_url': imageUrl,
          'specialization': specialization,
        });
      }
    });

    setState(() {
      _authenticatedUsers = users;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _authenticatedUsers.isNotEmpty
        ? ListView.separated(
            padding: EdgeInsets.all(10),
            separatorBuilder: (context, index) => Divider(color: Colors.grey),
            itemCount: _authenticatedUsers.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  _showPersonDetails(_authenticatedUsers[index]);
                },
                leading: CircleAvatar(
                  backgroundImage:
                      NetworkImage(_authenticatedUsers[index]['image_url']!),
                ),
                title: Text(_authenticatedUsers[index]['username']!),
                subtitle: Text(_authenticatedUsers[index]['email']!),
                trailing: IconButton(
                  icon: const Icon(Icons.chat_outlined),
                  onPressed: () {
                    // Handle chat bot icon click
                    _startChatWithPerson(_authenticatedUsers[index]);
                  },
                ),
              );
            },
          )
        : Center(
            child: Text('No users!'),
          );
  }

  void _showPersonDetails(Map<String, dynamic> person) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(person['username']),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(person['email']),
              const SizedBox(height: 10),
              Text('Area of interest: ${person['specialization']}'),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  // Handle send request button click
                },
                child: const Text("Send Request"),
              ),
              const SizedBox(height: 10),
              const Row(
                children: [
                  Icon(Icons.people),
                  SizedBox(width: 5),
                  Text(
                      "No. of Followers: 0"), // Placeholder for followers count
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }

  void _startChatWithPerson(Map<String, dynamic> person) {
    // Handle starting a chat with the selected person
    // This could navigate to a chat screen or open a chat interface
    Navigator.of(context).pushNamed(ChatScreen.routeName);
  }
}
