import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:turns/auth_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:turns/firstPlayer.dart';

class WaitingRoom extends StatefulWidget {
  int numOfPlayers;
  List<String> uids;
  WaitingRoom({this.numOfPlayers, this.uids});

  @override
  _WaitingRoomState createState() => _WaitingRoomState();
}

class _WaitingRoomState extends State<WaitingRoom> {
  int numOfPlayers;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    numOfPlayers = widget.numOfPlayers;
    print("WWWWWWWWWWWW");
    print(numOfPlayers);
  }

  Future<void> sendingPlayer() async {
    User user = FirebaseAuth.instance.currentUser;
    String str;
    if (numOfPlayers == 4) {
      for (var i = 1; i < 5; i++) {
        FirebaseFirestore.instance
            .collection('room')
            .snapshots()
            .listen((event) async {
          str = await event.docs[0][i];
          if (str == user.uid) {
            print('YES !!!!!');
            return Navigator.push(context,
                new MaterialPageRoute(builder: (context) => FirstPlayer()));
          }
        });
      }
    }
  }

  User user;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('room').snapshots(),
      builder: (context, userSnapshot) {
        user = FirebaseAuth.instance.currentUser;
        switch (numOfPlayers) {
          case 0:
            break;
          case 1:
            FirebaseFirestore.instance
                .collection('room')
                .doc('WIO7ujdueiQMdWPGkqSq')
                .update({'uid1': user.uid});
            break;
          case 2:
            FirebaseFirestore.instance
                .collection('room')
                .doc('WIO7ujdueiQMdWPGkqSq')
                .update({'uid2': user.uid});
            break;
          case 3:
            FirebaseFirestore.instance
                .collection('room')
                .doc('WIO7ujdueiQMdWPGkqSq')
                .update({'uid3': user.uid});
            break;
          case 4:
            FirebaseFirestore.instance
                .collection('room')
                .doc('WIO7ujdueiQMdWPGkqSq')
                .update({'uid4': user.uid});
            break;
          default:
        }
        if (userSnapshot.data == null) {
          return CircularProgressIndicator();
        }
        if (userSnapshot.data.docs[0]['numOfPlayer'] == 4) {
          print('PPPPPPPPPPPP');
          print(userSnapshot.data.docs[0]['numOfPlayer']);
          return FirstPlayer();
        }
        return Scaffold(
          body: Center(
            child: Text('waiting for more players'),
          ),
        );
      },
    );
  }
}
