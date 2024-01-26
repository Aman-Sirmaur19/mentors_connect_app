import 'package:chat_app/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../screens/login_page.dart';
import '../screens/chat_screen.dart';
import '../screens/auth_screen.dart';
import '../screens/otp_page.dart';
import '../screens/user_details.dart';
import '../screens/mentors_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterChat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
          accentColor: Colors.deepOrange,
          backgroundColor: Color.fromRGBO(255, 254, 229, 1),
        ),
      ),
      // home: LoginPage(),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, userSnapshot) {
          if(userSnapshot.hasData)
            return MentorsScreen();
          return AuthScreen();
        },
      ),
      routes: {
        OtpPage.routeName: (ctx) => OtpPage(),
        UserDetails.routeName: (ctx) => UserDetails(),
        MentorsScreen.routeName: (ctx) => MentorsScreen(),
        ChatScreen.routeName: (ctx) => ChatScreen(),
      },
    );
  }
}
