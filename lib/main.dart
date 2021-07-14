import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:playing_cards/playing_cards.dart';
import 'package:flutter/services.dart';
import 'package:turns/MyPlayingCards.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:turns/StartNewGame.dart';
import 'package:turns/auth_screen.dart';
import 'package:turns/firstPlayer.dart';
import 'package:turns/waitingRoom.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int numOfPlayers;

  Future<void> getNumOfPlayers() async {
    FirebaseFirestore.instance
        .collection('room')
        .snapshots()
        .listen((event) async {
      numOfPlayers = await event.docs[0]['numOfPlayer'];
      print('*********************');
      print(event.docs[0]['numOfPlayer']);
      print('#############################');
      print(numOfPlayers);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNumOfPlayers();
  }

  User user;
  List<String> userIds = [];

  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, userSnapshot) {
        if (userSnapshot.hasData) {
          user = FirebaseAuth.instance.currentUser;
          userIds.add(user.uid);
          for (var i = 0; i < userIds.length; i++) {
            print(userIds[0]);
          }
          return WaitingRoom(
            numOfPlayers: numOfPlayers,
            uids: userIds,
          );
        }
        return AuthScreen(
          numOfPlayers: numOfPlayers,
        );
      },
    );
  }
}
