import 'package:chat_app/models/authenticated_users_list.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MentorsScreen extends StatefulWidget {
  static const routeName = '/mentors-screen';

  @override
  _MentorsScreenState createState() => _MentorsScreenState();
}

class _MentorsScreenState extends State<MentorsScreen> {
  bool isLoading = false;
  UserModel mainUser = UserModel();

  @override
  void initState() {
    getUserName();
    super.initState();
  }

  getUserName() async {
    setState(() {
      isLoading = true;
    });
    User? user = FirebaseAuth.instance.currentUser;
    String? email = user?.email;

    CollectionReference users = FirebaseFirestore.instance.collection('users');

    try {
      QuerySnapshot querySnapshot =
          await users.where('email', isEqualTo: email).get();

      if (querySnapshot.docs.isNotEmpty) {
        var data = querySnapshot.docs.first.data() as Map<String, dynamic>;
        UserModel user = UserModel.fromJson(data);
        print(user.toJson());
        setState(() {
          mainUser = user;
          isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      print('Error getting user document: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  const Text(
                    'Mentors',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.green,
                    ),
                    child: const Text(
                      'CONNECT',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              foregroundColor: Theme.of(context).colorScheme.background,
              backgroundColor: Theme.of(context).colorScheme.primary,
              actions: [
                IconButton(
                  icon: const Icon(Icons.notifications),
                  onPressed: () {},
                ),
              ],
            ),
            drawer: Drawer(
              child: ListView(
                children: [
                  UserAccountsDrawerHeader(
                    accountName: Text(mainUser.username),
                    accountEmail: Text(mainUser.email),
                    currentAccountPicture: CircleAvatar(
                      backgroundImage: NetworkImage(mainUser.imageUrl),
                    ),
                  ),
                  const ListTile(
                    title: Text("Date of Birth"),
                    subtitle: Text("19-04-2003"),
                  ),
                  const ListTile(
                    title: Text("Mobile Number"),
                    subtitle: Text("+91XXXXXXXXXX"),
                  ),
                  TextButton(
                    child: const Text('Logout'),
                    onPressed: () => FirebaseAuth.instance.signOut(),
                  ),
                ],
              ),
            ),
            body: Column(
              children: [
                _buildSearchBar(context),
                Expanded(
                  child: AuthenticatedUsersList(),
                ),
              ],
            ),
          );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      width: MediaQuery.of(context).size.width,
      color: Colors.grey[200],
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search",
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
