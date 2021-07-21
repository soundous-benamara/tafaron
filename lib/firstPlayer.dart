import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:playing_cards/playing_cards.dart';
import 'package:flutter/services.dart';
import 'package:turns/ChooseGame.dart';
import 'package:turns/MyPlayingCards.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:turns/StartNewGame.dart';
import 'package:turns/auth_screen.dart';

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

  Map<String, dynamic> shuffledDeck;

  Future<QuerySnapshot> getUsers() async {
    final res = await FirebaseFirestore.instance.collection('users').get();
    userName1 = res.docs[0]['username'];
    userName2 = res.docs[1]['username'];
    userName3 = res.docs[2]['username'];
    userName4 = res.docs[3]['username'];
    uid1 = res.docs[0].id;
    uid2 = res.docs[1].id;
    uid3 = res.docs[2].id;
    uid4 = res.docs[3].id;
    return res;
  }

  int turn;

  void getCenter() async {
    final res = await FirebaseFirestore.instance.collection('games').get();

    cen = await res.docs[0]['center'] as Map<String, dynamic>;
    center[0] = MyPlayingCard(
        value: MyPlayingCard.IntToCardValue(cen['card1']['val']),
        suit: MyPlayingCard.StringToSuit(cen['card1']['suit']));
    center[0].showBack = res.docs[0]['showback'];
    center[1] = MyPlayingCard(
        value: MyPlayingCard.IntToCardValue(cen['card2']['val']),
        suit: MyPlayingCard.StringToSuit(cen['card2']['suit']));
    center[1].showBack = res.docs[0]['showback'];
    center[2] = MyPlayingCard(
        value: MyPlayingCard.IntToCardValue(cen['card3']['val']),
        suit: MyPlayingCard.StringToSuit(cen['card3']['suit']));
    center[2].showBack = res.docs[0]['showback'];
    center[3] = MyPlayingCard(
        value: MyPlayingCard.IntToCardValue(cen['card4']['val']),
        suit: MyPlayingCard.StringToSuit(cen['card4']['suit']));
    center[3].showBack = res.docs[0]['showback'];
  }

  String userName1, userName2, userName3, userName4;
  @override
  void initState() {
    super.initState();
    getCenter();

    user = FirebaseAuth.instance.currentUser;

    userName1 = '';
    userName2 = '';
    userName3 = '';
    userName4 = '';

    rank.add(0);
    rank.add(0);
    rank.add(0);
    rank.add(0);

    SystemChrome.setEnabledSystemUIOverlays([]);

    center.add(MyPlayingCard.emptyCard());
    center.add(MyPlayingCard.emptyCard());
    center.add(MyPlayingCard.emptyCard());
    center.add(MyPlayingCard.emptyCard());

    deck.add(MyPlayingCard.emptyCard());
    top.add(MyPlayingCard.emptyCard());
    left.add(MyPlayingCard.emptyCard());
    right.add(MyPlayingCard.emptyCard());

    _enabled = true;

    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  /*bool isInit = false;
  @override
  void didchangeDependencies() {
    super.didChangeDependencies();
    if (!isInit) {
      isInit = true;
      initState();
    }
  }*/

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

  @override
  Widget build(BuildContext context) {
    ShapeBorder shape = RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
        side: BorderSide(color: Colors.black, width: 0.5));

    return FutureBuilder(
        future: FirebaseFirestore.instance.collection('room').get(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshotRoom) {
          if (snapshotRoom.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else
            return FutureBuilder(
                future: getUsers(),
                builder: (context, snapshotUsers) {
                  if (snapshotUsers.connectionState ==
                      ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else
                    return StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('games')
                            .snapshots(),
                        builder: (context, snapshotGames) {
                          final currentDeck = snapshotGames.data.docs[0]['deck']
                              as Map<String, dynamic>;

                          rank[0] = snapshotGames.data.docs[0]['deck']['card1']
                              ['val'];
                          rank[1] = snapshotGames.data.docs[0]['deck']['card2']
                              ['val'];
                          rank[2] = snapshotGames.data.docs[0]['deck']['card3']
                              ['val'];
                          rank[3] = snapshotGames.data.docs[0]['deck']['card4']
                              ['val'];

                          if (snapshotGames.data.docs[0]['isChosen'] == true &&
                              snapshotGames.data.docs[0]['displayCards'] ==
                                  true) {
                            displayCards(snapshotGames.data, currentDeck);

                            Future.delayed(Duration(seconds: 2), () {
                              Fluttertoast.showToast(
                                msg: snapshotGames.data.docs[0]
                                        ['firstPlayerUsername'] +
                                    ' will start the game !!',
                                backgroundColor: Colors.black,
                                gravity: ToastGravity.CENTER,
                                toastLength: Toast.LENGTH_LONG,
                                textColor: Colors.white,
                                timeInSecForIosWeb: 1,
                                fontSize: 17,
                              );
                            });

                            Future.delayed(Duration(seconds: 2), () {
                              updateTurn(
                                  snapshotGames.data.docs[0]
                                      ['indexOfFirstPlayer'],
                                  false);
                            });

                            Future.delayed(Duration(seconds: 3), () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChooseGame()),
                              );
                            });
                          }

                          return buildGameBoard(snapshotGames.data,
                              snapshotUsers.data, snapshotRoom.data);
                        });
                });
        });
  }

  Future<void> addDeck() async {
    MyPlayingCard.ALL_CARDS.shuffle();
    final newDeckDoc = {
      'deck': MyPlayingCard.ALL_CARDS.asMap().map(
            (i, value) => MapEntry("card${i + 1}", {
              'val': MyPlayingCard.CardValueToInt(value.cardValue),
              'suit': MyPlayingCard.SuitToString(value.cardSuit),
            }),
          ),
    };
    await FirebaseFirestore.instance
        .collection('games')
        .doc('YpyyMAaFcRzCPbphEfYR')
        .update(newDeckDoc);
  }

  void displayCards(
      QuerySnapshot snapshotGames, Map<String, dynamic> currentDeck) {
    if (user.uid == uid1) {
      deck.clear();
      deck.add(MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(currentDeck['card1']['suit']),
          value: MyPlayingCard.IntToCardValue(currentDeck['card1']['val'])));
      left.clear();
      left.add(MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(currentDeck['card2']['suit']),
          value: MyPlayingCard.IntToCardValue(currentDeck['card2']['val'])));
      top.clear();
      top.add(MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(currentDeck['card3']['suit']),
          value: MyPlayingCard.IntToCardValue(currentDeck['card3']['val'])));
      right.clear();
      right.add(MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(currentDeck['card4']['suit']),
          value: MyPlayingCard.IntToCardValue(currentDeck['card4']['val'])));
    }
    if (user.uid == uid2) {
      deck.clear();
      deck.add(MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(currentDeck['card2']['suit']),
          value: MyPlayingCard.IntToCardValue(currentDeck['card2']['val'])));
      left.clear();
      left.add(MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(currentDeck['card3']['suit']),
          value: MyPlayingCard.IntToCardValue(currentDeck['card3']['val'])));
      top.clear();
      top.add(MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(currentDeck['card4']['suit']),
          value: MyPlayingCard.IntToCardValue(currentDeck['card4']['val'])));
      right.clear();
      right.add(MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(currentDeck['card1']['suit']),
          value: MyPlayingCard.IntToCardValue(currentDeck['card1']['val'])));
    }
    if (user.uid == uid3) {
      deck.clear();
      deck.add(MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(currentDeck['card3']['suit']),
          value: MyPlayingCard.IntToCardValue(currentDeck['card3']['val'])));
      left.clear();
      left.add(MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(currentDeck['card4']['suit']),
          value: MyPlayingCard.IntToCardValue(currentDeck['card4']['val'])));
      top.clear();
      top.add(MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(currentDeck['card1']['suit']),
          value: MyPlayingCard.IntToCardValue(currentDeck['card1']['val'])));
      right.clear();
      right.add(MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(currentDeck['card2']['suit']),
          value: MyPlayingCard.IntToCardValue(currentDeck['card2']['val'])));
    }
    if (user.uid == uid4) {
      deck.clear();
      deck.add(MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(currentDeck['card4']['suit']),
          value: MyPlayingCard.IntToCardValue(currentDeck['card4']['val'])));
      left.clear();
      left.add(MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(currentDeck['card1']['suit']),
          value: MyPlayingCard.IntToCardValue(currentDeck['card1']['val'])));
      top.clear();
      top.add(MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(currentDeck['card2']['suit']),
          value: MyPlayingCard.IntToCardValue(currentDeck['card2']['val'])));
      right.clear();
      right.add(MyPlayingCard(
          suit: MyPlayingCard.StringToSuit(currentDeck['card3']['suit']),
          value: MyPlayingCard.IntToCardValue(currentDeck['card3']['val'])));
    }

    deck[0].showBack = snapshotGames.docs[0]['showCard'];
    left[0].showBack = snapshotGames.docs[0]['showCard'];
    right[0].showBack = snapshotGames.docs[0]['showCard'];
    top[0].showBack = snapshotGames.docs[0]['showCard'];
  }

  Future<void> updateTurn(int number, bool b) async {
    await FirebaseFirestore.instance
        .collection('games')
        .doc('YpyyMAaFcRzCPbphEfYR')
        .update(
            {'indexOfFirstPlayer': number, 'isChosen': b, 'displayCards': b});
  }

  Future<void> updateData(String str, int b) async {
    await FirebaseFirestore.instance
        .collection('games')
        .doc('YpyyMAaFcRzCPbphEfYR')
        .update({str: b});
  }

  Future<void> getFirstPlayer() async {
    indexOfPlayer = 0;
    maxVal = rank[0];
    for (int index = 1; index < rank.length; index++) {
      if (rank.elementAt(index) < maxVal) {
        maxVal = rank.elementAt(index);
        indexOfPlayer = index;
      }
    }
    switch (indexOfPlayer) {
      case 0:
        await FirebaseFirestore.instance
            .collection('games')
            .doc('YpyyMAaFcRzCPbphEfYR')
            .update({'firstPlayer': uid1, 'firstPlayerUsername': userName1});

        break;

      case 1:
        await FirebaseFirestore.instance
            .collection('games')
            .doc('YpyyMAaFcRzCPbphEfYR')
            .update({'firstPlayer': uid2, 'firstPlayerUsername': userName2});

        break;

      case 2:
        await FirebaseFirestore.instance
            .collection('games')
            .doc('YpyyMAaFcRzCPbphEfYR')
            .update({'firstPlayer': uid3, 'firstPlayerUsername': userName3});

        break;

      case 3:
        await FirebaseFirestore.instance
            .collection('games')
            .doc('YpyyMAaFcRzCPbphEfYR')
            .update({'firstPlayer': uid4, 'firstPlayerUsername': userName4});
        break;
      default:
    }
    updateTurn(indexOfPlayer + 1, true);
    updateData('turn', indexOfPlayer + 1);
  }

  Widget buildGameBoard(QuerySnapshot snapshotGames,
      QuerySnapshot snapshotUsers, QuerySnapshot snapshotRoom) {
    return MaterialApp(
        home: Scaffold(
      backgroundColor: Color.fromRGBO(44, 62, 80, 1.0),
      body: Align(
        alignment: Alignment.center,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Transform.rotate(
            angle: 3.14 / 2,
            child: Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(5),
              width: 80,
              child: left.elementAt(0),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(5),
                width: 80,
                child: top.elementAt(0),
              ),
              GestureDetector(
                child: Transform.rotate(
                  angle: 1 / 30,
                  child: Container(
                    padding: EdgeInsets.all(0),
                    width: 170,
                    child: FlatCardFan(
                      children: center
                          .map(
                            (e) => Container(
                              width: 60,
                              child: e,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
                onTap: () async {
                  await addDeck();
                  await getFirstPlayer();
                },
              ),
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(5),
                width: 80,
                child: deck.elementAt(0),
              ),
            ],
          ),
          Transform.rotate(
            angle: 3.14 / 2,
            child: Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(5),
              width: 80,
              child: right.elementAt(0),
            ),
          ),
        ]),
      ),
    ));
  }
}
