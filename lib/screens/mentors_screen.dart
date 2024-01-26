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
                  child: _buildPersonList(),
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

  Widget _buildPersonList() {
    // Dummy data for 10 persons
    List<Map<String, String>> persons = [
      {
        "name": "John Doe",
        "email": "john@example.com",
        "image": "assets/john.jpg"
      },
      {
        "name": "Jane Smith",
        "email": "jane@example.com",
        "image": "assets/jane.jpg"
      },
      {
        "name": "Bob Johnson",
        "email": "bob@example.com",
        "image": "assets/bob.jpg"
      },
      {
        "name": "Alice Brown",
        "email": "alice@example.com",
        "image": "assets/alice.jpg"
      },
      {
        "name": "David Wilson",
        "email": "david@example.com",
        "image": "assets/david.jpg"
      },
      {
        "name": "Emma White",
        "email": "emma@example.com",
        "image": "assets/emma.jpg"
      },
      {
        "name": "Michael Davis",
        "email": "michael@example.com",
        "image": "assets/michael.jpg"
      },
      {
        "name": "Olivia Lee",
        "email": "olivia@example.com",
        "image": "assets/olivia.jpg"
      },
      {
        "name": "Ryan Taylor",
        "email": "ryan@example.com",
        "image": "assets/ryan.jpg"
      },
      {
        "name": "Sophia Miller",
        "email": "sophia@example.com",
        "image": "assets/sophia.jpg"
      },
    ];

    return ListView.builder(
      itemCount: persons.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            _showPersonDetails(persons[index]);
          },
          leading: CircleAvatar(
            backgroundImage: AssetImage(persons[index]["image"]!),
          ),
          title: Text(persons[index]["name"]!),
          subtitle: Text(persons[index]["email"]!),
          trailing: IconButton(
            icon: const Icon(Icons.chat_bubble),
            onPressed: () {
              // Handle chat bot icon click
              _startChatWithPerson(persons[index]);
            },
          ),
        );
      },
    );
  }

  void _showPersonDetails(Map<String, String> person) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(person["name"]!),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Email: ${person["email"]}"),
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

  void _startChatWithPerson(Map<String, String> person) {
    // Handle starting a chat with the selected person
    // This could navigate to a chat screen or open a chat interface
    Navigator.of(context).pushNamed(ChatScreen.routeName);
  }
}
