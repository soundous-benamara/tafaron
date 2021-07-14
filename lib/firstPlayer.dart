import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:playing_cards/playing_cards.dart';
import 'package:flutter/services.dart';
import 'package:turns/MyPlayingCards.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:turns/StartNewGame.dart';

class FirstPlayer extends StatefulWidget {
  FirstPlayer({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _FirstPlayerState createState() => _FirstPlayerState();
}

class _FirstPlayerState extends State<FirstPlayer> {
  List<Suit> suits = [];
  List<CardValue> cardValues = [];

  bool _enabled;

  List<MyPlayingCard> deck = [];
  List<MyPlayingCard> left = [];
  List<MyPlayingCard> right = [];
  List<MyPlayingCard> top = [];

  List<MyPlayingCard> center = [];
  Map<String, dynamic> cen;

  User user;
  String uid1, uid2, uid3, uid4;

  Map<String, dynamic> p1;
  Map<String, dynamic> p2;
  Map<String, dynamic> p3;
  Map<String, dynamic> p4;
  MyPlayingCard c1;
  MyPlayingCard c2;
  MyPlayingCard c3;
  MyPlayingCard c4;

  String userName1, userName2, userName3, userName4;
  @override
  void initState() {
    super.initState();

    user = FirebaseAuth.instance.currentUser;

    rank.add(0);
    rank.add(0);
    rank.add(0);
    rank.add(0);

    userName1 = '';
    userName2 = '';
    userName3 = '';
    userName4 = '';

    SystemChrome.setEnabledSystemUIOverlays([]);

    center.add(MyPlayingCard.emptyCard());
    center.add(MyPlayingCard.emptyCard());
    center.add(MyPlayingCard.emptyCard());
    center.add(MyPlayingCard.emptyCard());

    deck.add(MyPlayingCard.emptyCard());
    right.add(MyPlayingCard.emptyCard());
    top.add(MyPlayingCard.emptyCard());
    left.add(MyPlayingCard.emptyCard());
    //MyPlayingCard.ALL_CARDS.shuffle();

    MyPlayingCard.ALL_CARDS.shuffle();

    _enabled = true;

    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  List<int> rank = [];
  List<Text> games = [];

  int maxVal, indexOfPlayer;

  void firstTurn() {
    setState(() {
      indexOfPlayer = 0;
      maxVal = rank.elementAt(indexOfPlayer);
      print('i converted values !!');
      for (int index = 1; index < rank.length; index++) {
        if (rank.elementAt(index) < maxVal) {
          maxVal = rank.elementAt(index);
          indexOfPlayer = index;
        }
        print(maxVal);
      }
    });
    Future.delayed(Duration(seconds: 2), () {
      Fluttertoast.showToast(
        msg: 'player ' +
            (indexOfPlayer + 1).toString() +
            ' will start the game !!',
        backgroundColor: Colors.black,
        gravity: ToastGravity.CENTER,
        toastLength: Toast.LENGTH_LONG,
        textColor: Colors.white,
        timeInSecForIosWeb: 1,
        fontSize: 17,
      );
    });

    Future.delayed(Duration(seconds: 5), () {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => StartNewGame(
                  firstPlayer: indexOfPlayer + 1,
                )),
      );
    });

    print('after toast');
  }

  var val = '';
  var s = '';

  @override
  Widget build(BuildContext context) {
    ShapeBorder shape = RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
        side: BorderSide(color: Colors.black, width: 0.5));

    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('games').snapshots(),
        builder: (context, snapshotGames) {
          return StreamBuilder(
              stream: FirebaseFirestore.instance.collection('room').snapshots(),
              builder: (context, snapshotRoom) {
                return StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .snapshots(),
                    builder: (context, snapshotUsers) {
                      if (snapshotGames.data == null ||
                          snapshotRoom.data == null ||
                          snapshotUsers.data == null) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      userName1 = snapshotUsers.data.docs[0]['username'];
                      print('ggggggggggggggggggggggggggggggggggggggg');
                      print(userName1);

                      userName2 = snapshotUsers.data.docs[1]['username'];
                      print('ggggggggggggggggggggggggggggggggggggggg');
                      print(userName2);

                      userName3 = snapshotUsers.data.docs[2]['username'];
                      print('ggggggggggggggggggggggggggggggggggggggg');
                      print(userName3);

                      userName4 = snapshotUsers.data.docs[3]['username'];
                      print('ggggggggggggggggggggggggggggggggggggggg');
                      print(userName4);

                      cen = snapshotGames.data.docs[0]['center']
                          as Map<String, dynamic>;
                      print(cen);
                      print(center);
                      center[0] = MyPlayingCard(
                          value:
                              MyPlayingCard.IntToCardValue(cen['card1']['val']),
                          suit:
                              MyPlayingCard.StringToSuit(cen['card1']['suit']));
                      center[0].showBack = cen['showback'];
                      center[1] = MyPlayingCard(
                          value:
                              MyPlayingCard.IntToCardValue(cen['card2']['val']),
                          suit:
                              MyPlayingCard.StringToSuit(cen['card2']['suit']));
                      center[1].showBack = cen['showback'];
                      center[2] = MyPlayingCard(
                          value:
                              MyPlayingCard.IntToCardValue(cen['card3']['val']),
                          suit:
                              MyPlayingCard.StringToSuit(cen['card3']['suit']));
                      center[2].showBack = cen['showback'];
                      center[3] = MyPlayingCard(
                          value:
                              MyPlayingCard.IntToCardValue(cen['card4']['val']),
                          suit:
                              MyPlayingCard.StringToSuit(cen['card4']['suit']));
                      center[3].showBack = cen['showback'];
                      print('CARDS **********');
                      print(cen);
                      print(center);
                      print('MMMMMMMMMMMMMMMMM');
                      FirebaseFirestore.instance
                          .collection('users')
                          .snapshots()
                          .listen((event) async {
                        uid1 = await event.docs[0].id;
                        uid2 = await event.docs[1].id;
                        uid3 = await event.docs[2].id;
                        uid4 = await event.docs[3].id;
                      });
                      print('UUUSSEERRRR');
                      print(user.uid);
                      print('snapshot');
                      print(snapshotGames.data.docs[0]['p1']);
                      print(snapshotGames.data.docs[0]['p2']);
                      print(snapshotGames.data.docs[0]['p3']);
                      print(snapshotGames.data.docs[0]['p4']);

                      Future.delayed(Duration(seconds: 4), () {
                        Fluttertoast.showToast(
                          msg: 'we will distribute the cards now!!',
                          backgroundColor: Colors.black,
                          gravity: ToastGravity.CENTER,
                          toastLength: Toast.LENGTH_LONG,
                          textColor: Colors.white,
                          timeInSecForIosWeb: 1,
                          fontSize: 17,
                        );});

                        if (snapshotGames.data == null ||
                            snapshotRoom.data == null ||
                            snapshotUsers.data == null) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        FirebaseFirestore.instance
                            .collection('games')
                            .doc('YpyyMAaFcRzCPbphEfYR')
                            .update({
                          'p1': {
                            'val': MyPlayingCard.CardValueToInt(
                                MyPlayingCard.ALL_CARDS[0].cardValue),
                            'suit': MyPlayingCard.SuitToString(
                                MyPlayingCard.ALL_CARDS[0].cardSuit),
                          }
                        });

                        FirebaseFirestore.instance
                            .collection('games')
                            .doc('YpyyMAaFcRzCPbphEfYR')
                            .update({
                          'p2': {
                            'val': MyPlayingCard.CardValueToInt(
                                MyPlayingCard.ALL_CARDS[1].cardValue),
                            'suit': MyPlayingCard.SuitToString(
                                MyPlayingCard.ALL_CARDS[1].cardSuit),
                          }
                        });

                        FirebaseFirestore.instance
                            .collection('games')
                            .doc('YpyyMAaFcRzCPbphEfYR')
                            .update({
                          'p3': {
                            'val': MyPlayingCard.CardValueToInt(
                                MyPlayingCard.ALL_CARDS[2].cardValue),
                            'suit': MyPlayingCard.SuitToString(
                                MyPlayingCard.ALL_CARDS[2].cardSuit),
                          }
                        });

                        FirebaseFirestore.instance
                            .collection('games')
                            .doc('YpyyMAaFcRzCPbphEfYR')
                            .update({
                          'p4': {
                            'val': MyPlayingCard.CardValueToInt(
                                MyPlayingCard.ALL_CARDS[3].cardValue),
                            'suit': MyPlayingCard.SuitToString(
                                MyPlayingCard.ALL_CARDS[3].cardSuit),
                          }
                        });

                        p1 = snapshotGames.data.docs[0]['p1']
                            as Map<String, dynamic>;
                        rank[0] = p1['val'];

                        p2 = snapshotGames.data.docs[0]['p2']
                            as Map<String, dynamic>;
                        rank[1] = p2['val'];

                        p3 = snapshotGames.data.docs[0]['p3']
                            as Map<String, dynamic>;
                        rank[2] = p3['val'];

                        p4 = snapshotGames.data.docs[0]['p4']
                            as Map<String, dynamic>;
                        rank[3] = p4['val'];

                        print('HELLLLOO');
                        print('ontap');
                        print(snapshotGames.data.docs[0]['p1']);
                        print(snapshotGames.data.docs[0]['p2']);
                        print(snapshotGames.data.docs[0]['p3']);
                        print(snapshotGames.data.docs[0]['p4']);

                        if (user.uid == uid1) {
                          deck.clear();
                          deck.add(MyPlayingCard(
                              suit: MyPlayingCard.StringToSuit(p1['suit']),
                              value: MyPlayingCard.IntToCardValue(p1['val'])));

                          left.clear();
                          left.add(MyPlayingCard(
                              suit: MyPlayingCard.StringToSuit(p2['suit']),
                              value: MyPlayingCard.IntToCardValue(p2['val'])));
                          top.clear();
                          top.add(MyPlayingCard(
                              suit: MyPlayingCard.StringToSuit(p3['suit']),
                              value: MyPlayingCard.IntToCardValue(p3['val'])));
                          right.clear();
                          right.add(MyPlayingCard(
                              suit: MyPlayingCard.StringToSuit(p4['suit']),
                              value: MyPlayingCard.IntToCardValue(p4['val'])));

                          deck[0].showBack =
                              snapshotGames.data.docs[0]['showCard'];
                          left[0].showBack =
                              snapshotGames.data.docs[0]['showCard'];
                          right[0].showBack =
                              snapshotGames.data.docs[0]['showCard'];
                          top[0].showBack =
                              snapshotGames.data.docs[0]['showCard'];
                        }
                        if (user.uid == uid2) {
                          deck.clear();
                          deck.add(MyPlayingCard(
                              suit: MyPlayingCard.StringToSuit(p2['suit']),
                              value: MyPlayingCard.IntToCardValue(p2['val'])));
                          left.clear();
                          left.add(MyPlayingCard(
                              suit: MyPlayingCard.StringToSuit(p3['suit']),
                              value: MyPlayingCard.IntToCardValue(p3['val'])));
                          top.clear();
                          top.add(MyPlayingCard(
                              suit: MyPlayingCard.StringToSuit(p4['suit']),
                              value: MyPlayingCard.IntToCardValue(p4['val'])));
                          right.clear();
                          right.add(MyPlayingCard(
                              suit: MyPlayingCard.StringToSuit(p1['suit']),
                              value: MyPlayingCard.IntToCardValue(p1['val'])));

                          deck[0].showBack =
                              snapshotGames.data.docs[0]['showCard'];
                          left[0].showBack =
                              snapshotGames.data.docs[0]['showCard'];
                          right[0].showBack =
                              snapshotGames.data.docs[0]['showCard'];
                          top[0].showBack =
                              snapshotGames.data.docs[0]['showCard'];
                        }

                        if (user.uid == uid3) {
                          deck.clear();
                          deck.add(MyPlayingCard(
                              suit: MyPlayingCard.StringToSuit(p3['suit']),
                              value: MyPlayingCard.IntToCardValue(p3['val'])));
                          left.clear();
                          left.add(MyPlayingCard(
                              suit: MyPlayingCard.StringToSuit(p4['suit']),
                              value: MyPlayingCard.IntToCardValue(p4['val'])));
                          top.clear();
                          top.add(MyPlayingCard(
                              suit: MyPlayingCard.StringToSuit(p1['suit']),
                              value: MyPlayingCard.IntToCardValue(p1['val'])));
                          right.clear();
                          right.add(MyPlayingCard(
                              suit: MyPlayingCard.StringToSuit(p2['suit']),
                              value: MyPlayingCard.IntToCardValue(p2['val'])));

                          deck[0].showBack =
                              snapshotGames.data.docs[0]['showCard'];
                          left[0].showBack =
                              snapshotGames.data.docs[0]['showCard'];
                          right[0].showBack =
                              snapshotGames.data.docs[0]['showCard'];
                          top[0].showBack =
                              snapshotGames.data.docs[0]['showCard'];
                        }

                        if (user.uid == uid4) {
                          deck.clear();
                          deck.add(MyPlayingCard(
                              suit: MyPlayingCard.StringToSuit(p4['suit']),
                              value: MyPlayingCard.IntToCardValue(p4['val'])));
                          left.clear();
                          left.add(MyPlayingCard(
                              suit: MyPlayingCard.StringToSuit(p1['suit']),
                              value: MyPlayingCard.IntToCardValue(p1['val'])));
                          top.clear();
                          top.add(MyPlayingCard(
                              suit: MyPlayingCard.StringToSuit(p2['suit']),
                              value: MyPlayingCard.IntToCardValue(p2['val'])));
                          right.clear();
                          right.add(MyPlayingCard(
                              suit: MyPlayingCard.StringToSuit(p3['suit']),
                              value: MyPlayingCard.IntToCardValue(p3['val'])));

                          deck[0].showBack =
                              snapshotGames.data.docs[0]['showCard'];
                          left[0].showBack =
                              snapshotGames.data.docs[0]['showCard'];
                          right[0].showBack =
                              snapshotGames.data.docs[0]['showCard'];
                          top[0].showBack =
                              snapshotGames.data.docs[0]['showCard'];
                        }
                        indexOfPlayer = 0;
                        maxVal = rank[0];
                        for (int index = 1; index < rank.length; index++) {
                          if (rank.elementAt(index) < maxVal) {
                            maxVal = rank.elementAt(index);
                            indexOfPlayer = index;
                          }
                          print(maxVal);
                        }
                        switch (indexOfPlayer) {
                          case 0:
                            Future.delayed(Duration(seconds: 2), () {
                              Fluttertoast.showToast(
                                msg: userName1 + ' will start the game !!',
                                backgroundColor: Colors.black,
                                gravity: ToastGravity.CENTER,
                                toastLength: Toast.LENGTH_LONG,
                                textColor: Colors.white,
                                timeInSecForIosWeb: 1,
                                fontSize: 17,
                              );
                            });
                            FirebaseFirestore.instance
                                .collection('games')
                                .doc('YpyyMAaFcRzCPbphEfYR')
                                .update({'firstPlayer': uid1});

                            break;

                          case 1:
                            Future.delayed(Duration(seconds: 2), () {
                              Fluttertoast.showToast(
                                msg: userName2 + ' will start the game !!',
                                backgroundColor: Colors.black,
                                gravity: ToastGravity.CENTER,
                                toastLength: Toast.LENGTH_LONG,
                                textColor: Colors.white,
                                timeInSecForIosWeb: 1,
                                fontSize: 17,
                              );
                            });
                            FirebaseFirestore.instance
                                .collection('games')
                                .doc('YpyyMAaFcRzCPbphEfYR')
                                .update({'firstPlayer': uid2});

                            break;

                          case 2:
                            Future.delayed(Duration(seconds: 2), () {
                              Fluttertoast.showToast(
                                msg: userName3 + ' will start the game !!',
                                backgroundColor: Colors.black,
                                gravity: ToastGravity.CENTER,
                                toastLength: Toast.LENGTH_LONG,
                                textColor: Colors.white,
                                timeInSecForIosWeb: 1,
                                fontSize: 17,
                              );
                            });
                            FirebaseFirestore.instance
                                .collection('games')
                                .doc('YpyyMAaFcRzCPbphEfYR')
                                .update({'firstPlayer': uid3});

                            break;

                          case 3:
                            Future.delayed(Duration(seconds: 2), () {
                              Fluttertoast.showToast(
                                msg: userName4 + ' will start the game !!',
                                backgroundColor: Colors.black,
                                gravity: ToastGravity.CENTER,
                                toastLength: Toast.LENGTH_LONG,
                                textColor: Colors.white,
                                timeInSecForIosWeb: 1,
                                fontSize: 17,
                              );
                            });
                            FirebaseFirestore.instance
                                .collection('games')
                                .doc('YpyyMAaFcRzCPbphEfYR')
                                .update({'firstPlayer': uid4});
                            break;
                          default:
                        }
                        print('first playerrrrrrr-rr----');
                        print(snapshotGames.data.docs[0]['firstPlayer']);
                      

                      return MaterialApp(
                          home: Scaffold(
                        backgroundColor: Color.fromRGBO(44, 62, 80, 1.0),
                        body: Align(
                          alignment: Alignment.center,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Transform.rotate(
                                  angle: 3.14 / 2,
                                  child: Container(
                                    padding: EdgeInsets.all(4),
                                    width: 80,
                                    child: left.elementAt(0),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(0),
                                      width: 100,
                                      child: top.elementAt(0),
                                    ),
                                    GestureDetector(
                                      child: Transform.rotate(
                                        angle: 3.14 / 2,
                                        child: Container(
                                          padding: EdgeInsets.all(0),
                                          width: 200,
                                          child: FlatCardFan(
                                            children: center
                                                .map(
                                                  (e) => Container(
                                                    width: 70,
                                                    child: e,
                                                  ),
                                                )
                                                .toList(),
                                          ),
                                        ),
                                      ),onTap: (){},
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(0),
                                      width: 100,
                                      child: deck.elementAt(0),
                                    ),
                                  ],
                                ),
                                Transform.rotate(
                                  angle: 3.14 / 2,
                                  child: Container(
                                    padding: EdgeInsets.all(0),
                                    width: 100,
                                    child: right.elementAt(0),
                                  ),
                                ),
                              ]),
                        ),
                      ));
                    });
              });
        });
  }
}
